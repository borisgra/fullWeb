import io.ktor.http.*
import io.ktor.client.*
import io.ktor.client.call.*
import io.ktor.client.request.*
import io.ktor.serialization.kotlinx.json.*
import kotlinx.browser.window
import kotlinx.coroutines.coroutineScope
import kotlinx.coroutines.launch
import kotlin.coroutines.resume
import kotlin.coroutines.suspendCoroutine
import io.ktor.client.plugins.contentnegotiation.*
import io.ktor.client.statement.*

external fun decodeURIComponent(encodedURI: String): String // https://discuss.kotlinlang.org/t/where-is-decodeuricomponent-defined/6079

val jsonClient = HttpClient {
    install(ContentNegotiation) {
        json()
    }
}

suspend fun <T> saveRow(rowList: Array<T>, newValue: Map<String, String>, url: String, endpoint: String?): HttpResponse =
    jsonClient.post(endpoint + "/" + url.replace(JSON_PG, JSON_PG_UPD)) {
        contentType(ContentType.Application.Json.withParameter("charset", "utf-8"))
        setBody(
            UpdateData(
                selectRowByType(rowList, newValue, "upd"),
                selectRowByType(rowList, newValue, "del"),
                selectRowByType(rowList, newValue, "ins,copy"),
                rowFieldsValueMap,
            )
        )
    }

fun <T> selectRowByType(rowList: Array<T>, newValue: Map<String, String>, type: String) =
    JSON.stringify(rowList.filterIndexed { index, _ ->
        newValue.filterValues { it in type.split(",") }
            .keys.contains(index.toString())
    })
        .also { println("$type=${it}") }

suspend fun checkPassw(url: String, passw: String, endpoint: String?):Boolean =
    jsonClient.post("$endpoint/$url") {
        contentType(ContentType.Application.Json.withParameter("charset", "utf-8"))
        setBody(passw)
    }.body()

suspend fun loadByPost(url: String, endpoint: String?, parameter: Any = emptyMap<String,String>()): HttpResponse =
    coroutineScope {
        suspendCoroutine { continuation ->
            endpoint?.let {
                launch {
                    continuation.resume(
                        jsonClient.post("$endpoint/$url") {
                            contentType(ContentType.Application.Json.withParameter("charset", "utf-8"))
                            setBody(parameter)
                        }
                    )
                }
            }
        }
    }

/**
Parameters:
q - starts with concrete request (name request in list requests or route request)
m=hide - hide All menus
s=hide - hide Service menu
v - name view in base for list requests
b - url for QUERY_BD
w - where for view(in base) for list requests (?w=and left(submenu,3)='Big')
 */
fun getParameter(name: String, search: String = window.location.search) =
    decodeURIComponent(search.substringAfter("?"))
        .split("&")
        .filter { it.split("=")[0] == name }
        .ifEmpty { null }
        ?.map { it.split("$name=")[1] }
        ?.first()

