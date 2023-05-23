import io.ktor.http.*
import io.ktor.server.request.*
import io.ktor.server.response.*
import io.ktor.server.application.*
import io.ktor.server.routing.*
import io.ktor.util.pipeline.*
import kotlinx.serialization.decodeFromString
import kotlinx.serialization.json.Json
import javax.script.ScriptEngineManager

var localizedMessage = ""

fun Route.getAndPost() {
    //https://ktor.io/docs/routing.html#parameters
    post(JSR223) {
        rowFieldsValueMap = call.receive()
        call.respond(
            if ((System.getenv(JSR223) ?: "") != HIDE)
                runScript(rowFieldsValueMap["src"] ?: "")
            else ""
        )
    }
    post(LOADENV) {
        call.respond(startEnv)
    }
    get("/") {
        call.respondText(
            (this::class.java.classLoader.getResource("index.html")?.readText() ?: ""), ContentType.Text.Html
        )
    }
    route(ROUTE_BD) {
        post("/$PASSW") {
            call.respond(
                call.receiveText() == (System.getenv(
                    ADMIN_PASSW.uppercase().replace(" ", "_")
                ) ?: "adm")
            )
        }
        route("/{bd_name}") {
            post("/$JSON_PG_UPD/{pg_view?}/{where?}") {
                println("=====$JSON_PG_UPD==param======${call.parameters["pg_view"] ?: ""}===${call.parameters["where"] ?: ""}")
                val upd = call.receive<UpdateData>()
                call.respondText(
                        jsonPGupd(
                            setBD(), upd,
                            call.parameters["pg_view"] ?: ""
                        )
                )
            }
            get("/$JSON_PG/{pg_view}/{where?}") {
                (call.request.queryParameters[ROW_FIELDS_VALUE_PARAM]
                    ?.let { Json.decodeFromString<Map<String, String>>(it) } ?: emptyMap())
                    .let {
                        call.respondText(
                            with(getView(it)) {
                                if (contains(ERROR_FIELD)
                                    && (contains(SQL_STATE_RETRY.split(",")[0]) || contains(SQL_STATE_RETRY.split(",")[1]))
                                )
                                    getView(it) // try getPGConnection  after waiting
                                else this
                            })
                    }
            }
        }
    }
}

private fun PipelineContext<Unit, ApplicationCall>.getView(fieldsValue: Map<String, String>) =
    jsonPGview(
        setBD(),
        call.parameters["pg_view"] ?: "",
        call.parameters["where"] ?: "",
        call.parameters["name"],
        fieldsValue    )

private fun PipelineContext<Unit, ApplicationCall>.setBD() =
    call.parameters["bd_name"]
        .let { bd ->
            if (bd == QUERY_BD)
                System.getenv(QUERY_BD)
            else bd
        } ?: ""

private fun runScript(src: String) =
//    https://github.com/Kotlin/kotlin-script-examples/blob/master/jvm/jsr223/jsr223-simple/src/test/kotlin/org/jetbrains/kotlin/script/examples/jvm/jsr223/simple/test/simpleJsr223Test.kt
//    https://www.tabnine.com/code/java/methods/javax.script.ScriptEngine/createBindings
    runCatching {
        val engine = ScriptEngineManager().getEngineByExtension("kts")
        engine.eval(src, engine.createBindings().apply {
            rowFieldsValueMap.forEach { put(it.key, it.value) }
        })
    }.onFailure { localizedMessage = "ERROR in script -> ${it.localizedMessage} " }
        .getOrNull() ?: localizedMessage
