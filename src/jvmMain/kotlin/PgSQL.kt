import org.postgresql.util.PSQLException
import java.lang.*
import java.sql.*
import java.util.*

/**
 * HEROKUURL = "postgresql: // username: password @ host:port / database")
 */
    private var connectionsMap = mutableMapOf<String, Connection?>()
    private var baseName = "fo"
    private var url = "jdbc:postgresql://db.daas.team"
    private var user = "foUser"
    private var pass = "ablamtinas+12345"
    private var connectionError = ""
    internal const val PGSQLTIMEOUT: String = "14"
    internal const val JDBC = "jdbc:postgresql"
    internal const val DATABASE_URL = "DATABASE_URL"
    internal const val DATABASE_TIMEOUT = "DATABASE_TIMEOUT"

    private fun String.splitURL() {
        baseName = this.split("/")[3]
        url = "jdbc:postgresql://${this.split("@")[1].split("/")[0]}"
        user = this.split("//")[1].split(":")[0]
        pass = this.split(":")[2].split("@")[0]
    }

    private fun getPGConnection(bdConnectLine: String) =
        connectionsMap[bdConnectLine] ?: run {
            runCatching {
                println("========== Try connect")
                Class.forName("org.postgresql.Driver")
                bdConnectLine.splitURL()
                url = if (url.contains(JDBC)) url else "$JDBC://$url"
                connectionsMap[bdConnectLine] = DriverManager
                    .getConnection(String.format("%s/%s", url, baseName), setProperties(user, pass))
                println("Connection: HOST=$url, DB=$baseName, USER=$user")
            }.onFailure {
                println("onFailure getPGConnection ${(it as PSQLException).sqlState}  ${it.message} ")
                if (it.sqlState !in SQL_STATE_RETRY)
                    it.printStackTrace()
                connectionError = "ERROR connect: HOST=$url, \n DB=$baseName, \n USER=$user \n ${it.sqlState}  ${it.message}"
                connectionsMap[bdConnectLine] = null
            }
            connectionsMap[bdConnectLine]
        }

    private fun setProperties(USER: String, PASS: String) =
        Properties()
            .apply {
                this["user"] = USER
                this["password"] = PASS
                System.getenv(DATABASE_TIMEOUT) ?: PGSQLTIMEOUT
                    .also {
                        this["loginTimeout"] = it // sec
                        this["connectTimeout"] = it
                        this["socketTimeout"] = it
                    }
            }

fun jsonPGview(bd_name: String, pg_view: String, where: String = "", name: String?) =
    run {
        val rez = mutableListOf<String>()
        System.getenv("${DATABASE_URL}${if (bd_name != "") "_$bd_name" else ""}")
            ?.let { bdConnectLine ->
                println("pg_view=$pg_view;where=$where;name=$name")
                (name?.let {
                    rezSQL(
                        """select sql from ${VIEW_QUERY}_sql 
                            where name = '$name' 
                            order by query desc limit 1"""
                    )
                } ?: """SELECT  *  from $pg_view 
                 where 0=0 $where
                ${if (where.contains("order by")) "" else " order by 1"} """)
                    .let { query ->
                        getPGConnection(bdConnectLine)?.let {
                            runCatching {
                                checkInjection(where)?.let { //  Injection inserted
                                    rez.add("{$ERROR_FIELD: \" Check Injection ERROR -> ${encodeJson(query)}\"}")
                                } ?: run {
                                    val result = it.createStatement()?.executeQuery(query)
                                    while (result?.next() == true) {
                                        rez.add(resultStr(result))
                                    }
                                }
                                if (rez.isEmpty() && pg_view != VIEW_QUERY)
                                    rez.add("{$ERROR_FIELD: \" EMPTY -> base ${encodeJson(bd_name)}, query $pg_view $where \" }")
                                rez
                            }.onFailure {ex ->
                                println("onFailure jsonPGview ${(ex as PSQLException).sqlState} ${ex.message} ")
                                if (ex.sqlState !in SQL_STATE_RETRY)
                                    ex.printStackTrace()
                                connectionsMap[bdConnectLine] = null
                                connectionError = "${ex.sqlState} ${ex.message} | query=$query"
                            }.getOrNull() ?: rez.add(
                                "{$ERROR_FIELD: \"${encodeJson(connectionError)} \" }"
                            )
                        }
                    }
            } ?: rez.add("{$ERROR_FIELD: \" NO environment for base ${encodeJson(bd_name)} \" }")
        "[\n" + rez.joinToString(",\n") + "]\n"
    }

    private fun rezSQL(sqlSelect: String) =
        runCatching {
            val queryBd = if ((System.getenv(QUERY_BD) ?: "") != "") "_${System.getenv(QUERY_BD)}" else ""
            val bdConnectLineQuery = System.getenv("${DATABASE_URL}$queryBd")
            getPGConnection(bdConnectLineQuery)?.createStatement()?.executeQuery(sqlSelect)
                ?.let {
                    it.next()
                    if (it.isFirst) it.getString("sql")
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
                            if (meta.getColumnType(i) == 4 // integer
                                || meta.getColumnType(i) == 2 // numeric
                            ) {
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

    fun jsonPGupd(bd_name: String, updRecords: UpdateData, pg_view: String) =
        runCatching {
            val bdConnectLine = System.getenv("${DATABASE_URL}${if (bd_name != "") "_$bd_name" else ""}")
            bdConnectLine?.let {
                getPGConnection(bdConnectLine)
                val query =
                    transformToSQL(updRecords.rowsUpd)
                        .filter { it != "" }.joinToString(";\n") { row ->
                            updateRows(pg_view, row)
                        } + ";\n" +
                            transformToSQL(updRecords.rowsDel)
                                .filter { it != "" }.joinToString(";\n") { row ->
                                    deleteRows(pg_view, row)
                                } + ";\n" +
                            transformToSQL(updRecords.rowsIns)
                                .filter { it != "" }.joinToString(";\n") { row ->
                                    insertRows(pg_view, row)
                                }
                getPGConnection(bdConnectLine)?.createStatement()?.execute(query)
                    ?: "$UPDATE_BASE_ERROR $baseName "
                UPDATE_BASE_SUCCESS
            }
        }.onFailure {
            it.printStackTrace()
            connectionError = "$UPDATE_BASE_ERROR -> ${(it as PSQLException).sqlState} ${it.localizedMessage} "
        }.getOrNull() ?: connectionError

    private fun insertRows(pg_view: String, row: String) =
        "INSERT  into $pg_view \n" +
                " ${nameValue(0, row)} \n" +
                "VALUES ${nameValue(1, row.replace(encodeJson("'"), encodeJson("''")))}"

    private fun updateRows(pg_view: String, row: String) =
        "UPDATE  $pg_view \n" +
                "SET ${row.run { decodeJson(this.replace(encodeJson("'"), encodeJson("''"))) }} " + whereSQL(row)

    private fun deleteRows(pg_view: String, row: String) =
        "DELETE  from $pg_view \n" +
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
                    }.joinToString("") {
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
