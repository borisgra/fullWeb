import kotlinx.serialization.Serializable

internal const val HTTP = "http"
internal const val QUERY_BD = "QUERY_BD"
internal const val JSON_PG = "jsonPG"
internal const val JSON_PG_UPD = "jsonPGupd"
internal const val ROUTE_BD = "bd"
internal const val PASSW = "passw"
internal const val TRYING_TO_SAVE = "Trying to save... "
internal const val TRYING_TO_FETCH = "Trying to fetch... "
internal const val ERROR_IN_FETCH = "ERROR in fetch FOR "
internal const val UPDATE_BASE_SUCCESS = "Update Success !!!"
internal const val UPDATE_BASE_ERROR = "Update Error !!!"
internal const val NOT_FOUND_QUERY_NAME = "NOT fount query name"
internal const val CONSTRUCTION = "Construction"
internal const val HIDE = "hide"
internal const val SHOW = "show"
internal const val NOT_JSON_CHAR = "" // early "\n{}\"';,:=\t\b\n\\#&"
internal const val REPLACE_STR = "^^%d@@"
internal const val QUOTE_ONE = "'"
internal const val QUOTE_THREE = "\"\"\""
internal const val LOADENV = "loadEnv"
internal const val JSR223 = "jsr223"
internal const val SUBMENU = "submenu"
internal const val VIEW_QUERY = "v_querys"
internal const val FIRSTQUERY = "q"
internal const val ENDPOINT_SERVICE_URL = "b"
internal const val VIEW_QUERY_NAME = "v"
internal const val VIEW_QUERY_WHERE = "w"
internal const val VIEW_QUERY_WHERE_DEFAULT = " and left(name,2)!='--'"
internal const val ROW_FIELDS_VALUE_PARAM = "rFV"
internal const val URI_FOR_QUERY = " Uri for query OR name query: "
internal const val TITLES_FOR_QUERY = " Title for query"
internal const val ADMIN_PASSW = "Admin passw"
internal const val SAVE_TO_SERVER = " 'SAVE to server ??'"
internal const val EDIT_YES = "edit_yes"
internal const val EDIT_NO = "edit_no"
internal const val ERROR_FIELD = "\"error\""
internal const val NEW_TAB = "*"
internal const val GIT_VERSION = "git.version"
internal const val SQL_STATE_RETRY = "08003,08006,57P01"  // terminating connection
internal const val DATE_FROM = "@dateFrom"
internal const val DATE_TO = "@dateTo"
internal const val DATE_MIN = "2015-01-01"
internal const val DATE_MAX = "2027-12-31"
internal const val OPEN_IN_NEW_TAB = "Open in New Tab"
internal const val SERVER_TYPE = "https"
internal const val LOAD_TESTING_KEYS = "LOAD_TESTING_KEYS" // delimiter is ';'
internal const val META_SECURITY = "<meta http-equiv='Content-Security-Policy' content='upgrade-insecure-requests'>"
internal var startEnv = mutableMapOf<String, String>()
var rowFieldsValueMap = mutableMapOf<String, String>()

@Serializable
data class UpdateData(val rowsUpd: List<String>, val rowsDel: List<String>, val rowsIns: List<String>,val fieldsValue:Map<String, String>)

fun decodeJson(inString: String, replacedChar: String = NOT_JSON_CHAR) =
    run {
        var rez = inString
        replacedChar.indices.forEach {
            rez = rez.replace(REPLACE_STR.replace("%d", it.toString()), replacedChar[it].toString())
        }
        rez
    }

fun encodeJson(inString: String, replacedChar: String = NOT_JSON_CHAR) =
    run {
        var rez = inString
        replacedChar.indices.forEach {
            rez = rez.replace(replacedChar[it].toString(), REPLACE_STR.replace("%d", it.toString()))
        }
        rez
    }

fun insertParameterValue(queryIn: String, fieldsValueMap: Map<String, String> = rowFieldsValueMap) = run {
    var query = queryIn
    if (queryIn.contains("{")) { // {
        fieldsValueMap.keys
            .ifEmpty { null }
            ?.forEach { key ->
                query = query
                    .replace("{$key}", fieldsValueMap[key].toString())
            }
    }
    query
}

fun nameValue(nameAndValue: String, delimiter: String = ":") =
    NameValue (
        nameAndValue.substring(0,nameAndValue.indexOf(delimiter)).trim(),
        nameAndValue.substring(nameAndValue.indexOf(delimiter) + 1).trim()
    )
data class NameValue (val name: String, val value: String)
