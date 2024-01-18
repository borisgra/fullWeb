import com.google.auth.oauth2.GoogleCredentials
import com.google.cloud.bigquery.*
import org.postgresql.util.PSQLException
import java.io.File
import java.sql.Connection
import java.sql.DriverManager
import java.util.*

data class ConnectionType(var pgSql: Connection?, var bigQuery: BigQuery?)

private var connectionsMap = mutableMapOf<String, ConnectionType?>()
private var baseName = ""
private var url = ""
private var user = ""
private var pass = ""
private var connectionError = ""
internal const val PGSQLTIMEOUT: String = "14" // default
internal const val JDBC = "jdbc:postgresql"
internal const val DATABASE_URL = "DATABASE_URL"
internal const val BIG_QUERY = "BIG_QUERY"
internal const val DATABASE_TIMEOUT = "DATABASE_TIMEOUT"

private fun String.splitURL() {
//    "postgresql://username:password@host:port/database?sslmode=require"
    this.split("?")[0]
        .apply {
            baseName = this.split("/")
                .let { it[3] + (if (it.size > 4) "%2F" + it[4] else "") } // https://stackoverflow.com/questions/38415052/postgresql-jdbc-url-with-database-name-containing-forward-slash
            url = "jdbc:postgresql://${this.split("@")[1].split("/")[0]}"
            user = this.split("//")[1].split(":")[0]
            pass = this.split(":")[2].split("@")[0]
        }
}

fun getBaseConnection(bdName: String) =
    connectionsMap[bdName] ?: run {
        runCatching {
            println("========== Try connect to $bdName")
            url = "";baseName = "";user = ""
            Class.forName("org.postgresql.Driver")
            (if (bdName.endsWith("_") && bdName != QUERY_BD)  // connection string in VIEW_QUERY ? field: sql
                rezSQL(
                    """select sql from ${startEnv[VIEW_QUERY_NAME]}_sql 
                            where name = '$bdName' 
                            order by 1 limit 1"""
                )
            else System.getenv("${DATABASE_URL}_${bdName}")
                    )
                ?.let { bdConnectLine ->
                    bdConnectLine.splitURL()
                    url = if (url.contains(JDBC)) url else "$JDBC://$url"
                    connectionsMap[bdName] = ConnectionType(
                        DriverManager.getConnection(
                            String.format("%s/%s", url, baseName),
                            setProperties(user, pass, bdConnectLine)
                        ), null
                    )
                    println("Connection OK base=$bdName: HOST=$url, DB=$baseName, USER=$user")
                } ?: (System.getenv("${BIG_QUERY}_${bdName}")
                ?: System.getenv("${BIG_QUERY}_${bdName.replace("-", "__")}"))
                ?.let {
                    connectionsMap[bdName] = ConnectionType(null, bigQuery(bdName, it))
                    println("Connection OK bigQuery base=$bdName")
                } ?: throw Exception("NO environment for base $bdName")
        }.onFailure {
            println("onFailure getPGConnection ${if (it is PSQLException) it.sqlState else ""}  ${it.message} ")
            connectionError =
                "ERROR connect: HOST=$url, DB=$baseName, USER=$user  ${if (it is PSQLException) it.sqlState else ""}  ${it.message}"
            connectionsMap[bdName] = null
        }
        connectionsMap[bdName]
    }

private fun setProperties(user: String, pass: String, bdConnectLine: String) =
    Properties()
        .apply {
            this["user"] = user
            this["password"] = pass
            this["ssl"] = true
            this["sslmode"] = "prefer" // require
            (System.getenv(DATABASE_TIMEOUT) ?: PGSQLTIMEOUT)
                .also {
                    this["loginTimeout"] = it // sec
                    this["connectTimeout"] = it
                    this["socketTimeout"] = it
                }
            if (bdConnectLine.contains("?"))
                bdConnectLine.split("?")[1]
                    .also { parameter ->
                        parameter.split("&")
                            .forEach { this[it.split("=")[0].trim()] = it.substring(it.indexOfFirst {it.toString().contains("=") } + 1).trim() }
                    }
            if (this["sslmode"] == "verify-full") {
                File("./$baseName.crt").writeText(this["sslrootcert"].toString()
                    .replace("-----BEGIN CERTIFICATE-----","\n-----BEGIN CERTIFICATE-----\n")
                    .replace("-----END CERTIFICATE-----","\n-----END CERTIFICATE-----\n")                )
                this["sslrootcert"] = "./$baseName.crt"
            }
        }

fun jsonPGview(
    bdName: String,
    pgView: String,
    where: String = "",
    name: String?,
    fieldsValueMap: Map<String, String>
) =
    run {
//        println("fieldsValueMap=$fieldsValueMap")
        println("pgView=$pgView;where=$where;name=$name")
        checkInjection(pgView + where)?.let { //  Injection inserted
            return "[\n" + errorJson("Check Injection ERROR -> ${pgView + where}") + "]\n"
        }
        val rez = mutableListOf<String>()
        (name?.let {
                rezSQL(
                    """select sql from ${startEnv[VIEW_QUERY_NAME]}_sql 
                            where name = '$name' 
                            order by 1 limit 1""", fieldsValueMap
                )?.let { "($it) as s " }
            }  ?: pgView)
            .let {view ->
                """SELECT   ROW_TO_JSON(t, true) 
                    from (SELECT * from $view ${if (where.contains("order by")) "" else " order by 1"}) t
                     where 0=0 $where
                """
                    .let { insertParameterValue(it, fieldsValueMap) }
                    .let { query ->
                        getBaseConnection(bdName)?.pgSql?.let {
                            pgsqlJson(rez, query, it, bdName)
                        } ?: getBaseConnection(bdName)?.bigQuery?.let {
                            cloudBigQueryJson(rez, query.replace("ROW_TO_JSON","TO_JSON_STRING"), it, bdName)
                        } ?: rez.add(errorJson(" problem connect to base $bdName  ($connectionError)"))
                    }
                "[\n" + rez.joinToString(",\n") + "]\n"
            }
    }

private fun rezSQL(sqlSelect: String, fieldsValueMap: Map<String, String> = emptyMap(),
                   bdName: String = queryBdName) =
    runCatching {
        connectionsMap[bdName]?.pgSql?.createStatement()
            ?.executeQuery(insertParameterValue(sqlSelect, fieldsValueMap))
            ?.let {
                it.next()
                if (it.isFirst) it.getString(1)
                else ""
            }
            ?: connectionsMap[bdName]?.bigQuery
                ?.query(QueryJobConfiguration.newBuilder(sqlSelect).build())
                ?.iterateAll()?.map { row ->
                    row[0].value
                }?.first().toString()
            .also { println("sql=$it") }
    }.onFailure {
        println("onFailure rezSQL ${(it as PSQLException).sqlState} ${it.message} ")
        if (it.sqlState !in (SQL_STATE_RETRY))
            it.printStackTrace()
    }.getOrNull()

private fun checkInjection(query: String) =
    listOf(" OR ", ";", "CREATE", "INSERT", "DELETE", "SELECT")
        .filter { query.uppercase(Locale.getDefault()).contains(it) }
        .ifEmpty { null } // Injection NOT inserted

fun jsonPGupd(bdName: String, updRecords: UpdateData, pgView: String) =
    runCatching {
        println("UPD.fieldsValueMap=${updRecords.fieldsValue}")
        connectionError = ""
        getBaseConnection(bdName)?.pgSql?.createStatement()
            ?.execute(formSQLQuery(updRecords, pgView, QUOTE_ONE))
            ?: getBaseConnection(bdName)?.bigQuery
                ?.query(QueryJobConfiguration.newBuilder(formSQLQuery(updRecords, pgView, QUOTE_THREE)).build())
            ?: "$UPDATE_BASE_ERROR $baseName "
        UPDATE_BASE_SUCCESS
    }.onFailure { e ->
        connectionError = connectionError.ifEmpty {
            "$UPDATE_BASE_ERROR -> ${if (e is PSQLException) e.sqlState else ""} ${e.message} "
                .also { e.printStackTrace() }
        }
    }.getOrNull() ?: connectionError

private fun formSQLQuery(updRecords: UpdateData, pgView: String, quoteType: String) =
    (updRecords.rowsUpd.joinToString(";\n") { rowJson ->
        fromJsonString(rowJson, quoteType, replaceEscape).let { keysValues ->
            keysValues
                .filter { !it.key.startsWith("_") } // not modify field
                .map { "${it.key} = ${it.value}" }
                .joinToString(",")
                .let { row ->
                    "UPDATE  $pgView \n SET $row " +
                            whereSQL(keysValues, quoteType)
                }
        }
    } + if (updRecords.rowsUpd.isNotEmpty())  ";\n" else "" +
            updRecords.rowsDel.joinToString(";\n") { rowJson ->
                fromJsonString(rowJson, quoteType, replaceEscape).let { keysValues ->
                    keysValues
                        .let {
                            "DELETE  from $pgView \n" +
                                    whereSQL(keysValues, quoteType)
                        }
                }
            } + if (updRecords.rowsDel.isNotEmpty())  ";\n" else "" +
            updRecords.rowsIns.joinToString(";\n") { rowJson ->
                fromJsonString(rowJson, quoteType, replaceEscape).let { keysValues ->
                    "INSERT  into $pgView (" +
                            keysValues
                                .filter { !idFieds(it, quoteType) }  // table's primary keys
                                .filter { !it.key.startsWith("_") } // not modify field
                                .map { "${it.key} " }
                                .joinToString(",") + ") \n" +
                            " VALUES(" +
                            keysValues
                                .filter { !idFieds(it, quoteType) } // table's primary keys
                                .filter { !it.key.startsWith("_") } // not modify field
                                .map { "${it.value} " }
                                .joinToString(",") + ")"
                }
            }
            )
        .let { query ->
            if (!pgView.contains(VIEW_QUERY))
                insertParameterValue(query, updRecords.fieldsValue)
            else query
        }

private fun idFieds(it: Map.Entry<String, Any?>, quoteType: String) = // table's primary keys
    (!it.value.toString().endsWith(quoteType)
            && (it.key == "id"
            || it.key.endsWith("_id")))

private fun whereSQL(keysValues: Map<String, Any?>, quoteType: String) =
    "\n where 0=0 " + keysValues
        .filter {idFieds(it, quoteType)}
        .map { " and ${it.key} ${if (it.value == null) "is" else "=" } ${it.value}" }
        .joinToString(" ")

private fun pgsqlJson(
    rez: MutableList<String>,
    query: String,
    conn: Connection,
    bdName: String
) = runCatching {
    val result = conn.createStatement()?.executeQuery(query)
    while (result?.next() == true) {
        rez.add(result.getString(result.metaData.getColumnLabel(1))) // NOT work for cocroatDB
    }
    rez.ifEmpty {rez.add(errorJson(" EMPTY -> base ${encodeJson(bdName)}, query= $query"))}
}.onFailure { ex ->
    println("onFailure pgsqlJson ${(ex as PSQLException).sqlState} ${ex.message}\n" +
            " SQL -> base $bdName), query=\n$query  ")
    if (ex.sqlState in SQL_STATE_RETRY) // This connection has been closed
        connectionsMap[bdName] = null
    connectionError = "${ex.sqlState} ${ex.message}"
}.getOrNull() ?: rez.add(errorJson(connectionError))

// https://cloud.google.com/bigquery/docs/running-queries
// https://www.revisitclass.com/gcp/how-to-execute-a-query-on-bigquery-using-java/
//https://www.sohamkamani.com/java/bigquery/
fun cloudBigQueryJson(rez: MutableList<String>, query: String?, bigQuery: BigQuery, projectId: String = "vpn_gra") =
    runCatching {
        bigQuery.query(QueryJobConfiguration.newBuilder(query).build())
            ?.iterateAll()?.forEach { row ->
                rez.add(row[0].value.toString())
            }
        rez.ifEmpty { rez.add(errorJson("EMPTY -> base $projectId), query= $query")) }
    }.onFailure { ex ->
        println("onFailure cloudBigQueryJson  ${ex.message}\n" +
                " SQL -> project $projectId), query=\n$query ")
        connectionError = ex.message.toString()
    }.getOrNull()
        ?: rez.add(errorJson(connectionError))

private fun errorJson(message: String) =
    "{$ERROR_FIELD: \" ${message.replace("\n","").replace("\"","")} \" }"


private fun bigQuery(projectId: String = "vpn-gra", keyJson: String): BigQuery? =
    BigQueryOptions.newBuilder()
        .setProjectId(projectId)
        .setCredentials(
            GoogleCredentials.fromStream(
                keyJson.replace("&quot;", "\"")
                    .byteInputStream()
            )
        )
        .build().service

//https://kotlinlang.org/docs/lambdas.html#invoking-a-function-type-instance
// https://stackoverflow.com/questions/935/string-literals-and-escape-characters-in-postgresql
// use lambdas fromJsonString(rowJson, quoteType, replaceEscape)
val replaceEscape = { content: String, quote: String ->
    if (quote == "") content
    else
        "${if (quote == QUOTE_ONE) "E" else ""}$quote${
            if (quote == QUOTE_ONE)
                content
                    .replace("'", "''")
            else content
        }$quote"
}
