import org.postgresql.util.PSQLException
import java.lang.*
import java.sql.*
import java.util.*

private var connectionsMap = mutableMapOf<String, Connection?>()
private var baseName = ""
private var url = ""
private var user = ""
private var pass = ""
private var connectionError = ""
internal const val PGSQLTIMEOUT: String = "14"
internal const val JDBC = "jdbc:postgresql"
internal const val DATABASE_URL = "DATABASE_URL"
internal const val DATABASE_TIMEOUT = "DATABASE_TIMEOUT"

private fun String.splitURL() {
//    "postgresql: // username: password @ host:port / database?sslmode=require"
    this.split("?")[0]
        .apply {
            baseName = this.split("/")
                .let { it[3] + (if (it.size > 4) "%2F" + it[4] else "") } // https://stackoverflow.com/questions/38415052/postgresql-jdbc-url-with-database-name-containing-forward-slash
            url = "jdbc:postgresql://${this.split("@")[1].split("/")[0]}"
            user = this.split("//")[1].split(":")[0]
            pass = this.split(":")[2].split("@")[0]
        }
}

private fun getPGConnection(bdName: String) =
    connectionsMap[bdName] ?: run {
        runCatching {
            println("========== Try connect")
            Class.forName("org.postgresql.Driver")
            (if (bdName.endsWith("_") && bdName != QUERY_BD)  // connection string in VIEW_QUERY ? field: sql
                rezSQL(
                    """select sql from ${VIEW_QUERY}_sql 
                            where name = '$bdName' 
                            order by query desc limit 1"""
                )
            else
                System.getenv("${DATABASE_URL}_$bdName"))
                ?.let { bdConnectLine ->
                    bdConnectLine.splitURL()
                    url = if (url.contains(JDBC)) url else "$JDBC://$url"
                    connectionsMap[bdName] = DriverManager
                        .getConnection(String.format("%s/%s", url, baseName), setProperties(user, pass, bdConnectLine))
                    println("Connection: HOST=$url, DB=$baseName, USER=$user")
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
                    .also {parameter ->
                        parameter.split(",")
                            .forEach{ this[it.split("=")[0].trim()] = it.split("=")[1].trim() }
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
        println("fieldsValueMap=$fieldsValueMap")
        println("pgView=$pgView;where=$where;name=$name")
        val rez = mutableListOf<String>()
        (name?.let {
            rezSQL(
                """select sql from ${VIEW_QUERY}_sql 
                            where name = '$name' 
                            order by query desc limit 1"""
                , fieldsValueMap
            )
//                } ?: """SELECT   ROW_TO_JSON(t, true)  -- NOT work for cocroatDB (unknown signature: row_to_json(..)
        } ?: """SELECT  *  
                    from (SELECT * from $pgView ${if (where.contains("order by")) "" else " order by 1"}) t
                     where 0=0 $where
                """)
            .let { insertParameterValue(it, fieldsValueMap) }
            .let { query ->
                getPGConnection(bdName)?.let {
                    runCatching {
                        checkInjection(where)?.let { //  Injection inserted
                            rez.add("{$ERROR_FIELD: \" Check Injection ERROR -> ${encodeJson(query)}\"}")
                        } ?: run {
                            val result = it.createStatement()?.executeQuery(query)
                            while (result?.next() == true) {
//                                        rez.add(result.getString(result.metaData.getColumnLabel(1))) // NOT work for cocroatDB
                                rez.add(resultStr(result))
                            }
                        }
                        if (rez.isEmpty() && pgView != VIEW_QUERY)
                            rez.add("{$ERROR_FIELD: \" EMPTY -> base ${encodeJson(bdName)}, query= ${encodeJson(query)} \" }")
                        rez
                    }.onFailure { ex ->
                        println("onFailure jsonPGview ${(ex as PSQLException).sqlState} ${ex.message} ")
                        if (ex.sqlState in SQL_STATE_RETRY) // This connection has been closed
                            connectionsMap[bdName] = null
                        connectionError = "${ex.sqlState} ${ex.message} | query=${encodeJson(query)}"
                    }.getOrNull() ?: rez.add(
                        "{$ERROR_FIELD: \"${encodeJson(connectionError)} \" }"
                    )
                } ?: rez.add(
                    "{$ERROR_FIELD: \" problem connect to base ${encodeJson(bdName)}  (${
                        encodeJson(connectionError)
                    }) \" }"
                )
            }
        "[\n" + rez.joinToString(",\n") + "]\n"
    }

private fun rezSQL(sqlSelect: String, fieldsValueMap: Map<String, String> = emptyMap(), bdName: String = System.getenv(QUERY_BD)) =
    runCatching {
        connectionsMap[bdName]?.createStatement()
            ?.executeQuery(insertParameterValue(sqlSelect, fieldsValueMap))
            ?.let {
                it.next()
                if (it.isFirst) it.getString(1)
                else ""
            }
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

private fun resultStr(result: ResultSet?) =
    result?.metaData
        ?.let { meta ->
            val record = mutableListOf<String>()
            (1..meta.columnCount).forEach { i ->
                result.getString(meta.getColumnLabel(i))
                    ?.let {
                        var value = result.getString(meta.getColumnLabel(i))
                            .replace("},", ";")
                        val nameField = meta.getColumnLabel(i)
                        if (NUMERIC_TYPES.split(",")
                            .map { it in meta.getColumnTypeName(i) }
                            .contains(true)) {
                            if (value == "")
                                value = "0"
                            record.add("    \"$nameField\": $value")
                        } else
                            record.add("    \"$nameField\": \"${
                                if (!nameField.contains("date"))
                                    value.run { encodeJson(this) }
                                else value
                            }\"")
                    }
            }.let {
                "  {\n" + record.joinToString(",\n") + "}"
            }
        } ?: ""

fun jsonPGupd(bdName: String, updRecords: UpdateData, pgView: String) =
    runCatching {
        println("UPD.fieldsValueMap=${updRecords.fieldsValue}")
        connectionError = ""
        formQueryForUpdate(updRecords, pgView)
            .let { query ->
                getPGConnection(bdName)?.createStatement()
                    ?.execute(
                        if (!pgView.contains(VIEW_QUERY))
                            insertParameterValue(query, updRecords.fieldsValue)
                        else query
                    )
                    ?: "$UPDATE_BASE_ERROR $baseName "
            }
        UPDATE_BASE_SUCCESS
    }.onFailure { e ->
        connectionError = connectionError.ifEmpty {
            "$UPDATE_BASE_ERROR -> ${if (e is PSQLException) e.sqlState else ""} ${e.localizedMessage} "
                .also { e.printStackTrace() }
        }
    }.getOrNull() ?: connectionError

private fun formQueryForUpdate(updRecords: UpdateData, pgView: String) =
    transformToSQL(updRecords.rowsUpd)
        .filter { it != "" }.joinToString(";\n") { row ->
            updateRows(pgView, row)
        } + ";\n" +
            transformToSQL(updRecords.rowsDel)
                .filter { it != "" }.joinToString(";\n") { row ->
                    deleteRows(pgView, row)
                } + ";\n" +
            transformToSQL(updRecords.rowsIns)
                .filter { it != "" }.joinToString(";\n") { row ->
                    insertRows(pgView, row)
                }

private fun insertRows(pgView: String, row: String) =
    "INSERT  into $pgView \n" +
            " ${nameValue(0, row)} \n" +
            "VALUES ${nameValue(1, row.replace(encodeJson("'"), encodeJson("''")))}"

private fun updateRows(pgView: String, row: String) =
    "UPDATE  $pgView \n" +
            "SET ${row.run { decodeJson(this.replace(encodeJson("'"), encodeJson("''"))) }} " + whereSQL(row)

private fun deleteRows(pgView: String, row: String) =
    "DELETE  from $pgView \n" +
            whereSQL(row)

private fun nameValue(what: Int, row: String) =
    " ( ${
        row.split(",")
            .filter { it != "" }
            .mapIndexed { i, it ->
                val rez = if (i > 0) it.split("=")[what] else null
                if (rez != null && what == 1) decodeJson(rez) else rez
            }.filterNotNull()
            .joinToString(",")
    } ) \n"

private fun whereSQL(row: String) =
    " where 0=0 " +
            row.split(",")
                .filter { it2 ->
                    !it2.contains("'")
                            && (it2.split("=")[0].trim() == "id"
                            || it2.split("=")[0].trim().endsWith("_id"))
                }
                .also { if (it.isEmpty()) throw Exception("Impossible to build whereSQL") }
                .joinToString("") {
                    " and ${
                        it.split(",")[0]
                    }"
                }

private fun transformToSQL(rec: String) =
    rec.substring(1, rec.length - 1)
        .replace("""[\\{\[\]]""".toRegex(), "")
        .replace("\":".toRegex(), "\"=")
        .split("},")
        .map {
            val fieldAndValue = it.split(",")
                .filter { it2 -> !it2.startsWith("\"_") }
            fieldAndValue.joinToString(",") { it1 ->
                if (it1.contains("=")) {
                    val (name, value) = it1.split("=")
                    "${name.replace("\"", "")} = ${
                        value
                            .replace("\"", "'")
                            .replace("}", "")
                    }"
                } else ""
            }
        }


