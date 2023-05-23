import kotlinx.serialization.Serializable

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
internal const val ENDPOINT_SERVICE_URL = "b"
internal const val NOT_FOUND_QUERY_NAME = "NOT fount query name"
internal const val CONSTRUCTION = "Construction"
internal const val HIDE = "hide"
internal const val SHOW = "show"
internal const val NOT_JSON_CHAR = "\n{}\"';,:=\t\b\n\\#&"
internal const val REPLACE_STR = "^^%d@@"
internal const val LOADENV = "loadEnv"
internal const val JSR223 = "jsr223"
internal const val SUBMENU = "submenu"
internal const val VIEW_QUERY = "v_querys"
internal const val FIRSTQUERY = "q"
internal const val ROW_FIELDS_VALUE_PARAM = "rFV"
internal const val URI_FOR_QUERY = " Uri for query OR name query: "
internal const val TITLES_FOR_QUERY = " Title for query"
internal const val ADMIN_PASSW = "Admin passw"
internal const val SAVE_TO_SERVER = " 'SAVE to server ??'"
internal const val EDIT_YES = "edit_yes"
internal const val EDIT_NO = "edit_no"
internal const val ERROR_FIELD = "\"error\""
internal const val NEW_TAB = "*"
internal const val GIT_VERSION = "git_version"
internal const val SQL_STATE_RETRY = "08003,08006"
internal const val NUMERIC_TYPES = "int,serial,numeric,money,real,float,double"
internal const val DATE_FROM = "@dateFrom"
internal const val DATE_TO = "@dateTo"
internal const val DATE_MIN = "2015-01-01"
internal const val DATE_MAX = "2027-12-31"
internal const val OPEN_IN_NEW_TAB = "Open in New Tab"
internal var startEnv = mutableMapOf<String, String>()
var rowFieldsValueMap = mutableMapOf<String, String>()

@Serializable
data class UpdateData(val rowsUpd: String, val rowsDel: String, val rowsIns: String,val fieldsValue:Map<String, String>)

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

fun insertParameterValue(queryIn: String,fieldsValueMap: Map<String, String> = rowFieldsValueMap) = run {
    var query = queryIn
    if (queryIn.contains("{") || queryIn.contains("^^1@@")) { // {
        fieldsValueMap.keys
            .ifEmpty { null }
            ?.forEach { key ->
                query = query
                    .replace("{$key}", fieldsValueMap[key].toString())
                    .replace("^^1@@$key^^2@@", fieldsValueMap[key].toString())
            }
    }
    query
}