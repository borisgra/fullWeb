import io.ktor.http.*
import io.ktor.client.*
import io.ktor.client.request.*
import io.ktor.client.features.json.JsonFeature
import io.ktor.client.features.json.serializer.KotlinxSerializer

import kotlinx.browser.window
import kotlinx.coroutines.coroutineScope
import kotlinx.coroutines.launch
import kotlin.coroutines.resume
import kotlin.coroutines.suspendCoroutine

val endpoint = window.location.origin // only needed until https://github.com/ktorio/ktor/issues/1695 is resolved

val jsonClient = HttpClient {
    install(JsonFeature) { serializer = KotlinxSerializer() }
}

suspend fun <T> saveRow(rowList: Array<T>, NewValue: Map<String, String>, url: String) =
    jsonClient.post<String>(endpoint + "/" + url.replace(JSON_PG, JSON_PG_UPD)) {
        contentType(ContentType.Application.Json.withParameter("charset", "utf-8"))
        body = UpdateData(
            selectRowByType(rowList, NewValue, "upd"),
            selectRowByType(rowList, NewValue, "del"),
            selectRowByType(rowList, NewValue, "ins,copy")
        )
    }

fun <T> selectRowByType(rowList: Array<T>, NewValue: Map<String, String>, type: String) =
    JSON.stringify(rowList.filterIndexed { index, _ ->
        NewValue.filterValues { it in type.split(",") }
            .keys.contains(index.toString())
    })
        .also { println("$type=${it}") }

suspend fun checkPassw(url: String, passw: String): Boolean =
    jsonClient.post("$endpoint/$url") {
        contentType(ContentType.Application.Json.withParameter("charset", "utf-8"))
        body = passw
    }

suspend fun loadByPost(url: String, parametr: String): MutableMap<String, String> =
    coroutineScope {
        suspendCoroutine { continuation ->
            launch {
                continuation.resume(
                    jsonClient.post("$endpoint/$url") {
                        contentType(ContentType.Application.Json.withParameter("charset", "utf-8"))
                        body = parametr
                    }
                )
            }
        }
    }

/**
Parameters:
q - starts with concret request (name request in list requests or route request)
m=hide - hide All menus
s=hide - hide Service menu
v - name view in base for list requests
w - wher for view(in base) for list requests (?w=and left(submenu,3)='Big')
 */
fun getParameter(name: String, search: String = window.location.search) =
    search.substringAfter("?")
        .replace("%20", " ")
        .replace("%27", "'")
        .split("&")
        .filter { it.split("=")[0] == name }
        .ifEmpty { null }
        ?.map { it.split("$name=")[1] }
        ?.first()

