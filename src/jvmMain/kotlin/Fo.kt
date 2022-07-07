import io.ktor.application.*
import io.ktor.request.*
import io.ktor.response.*
import io.ktor.routing.*
import io.ktor.util.pipeline.*

fun Route.getAndPost() {
    //https://ktor.io/docs/routing.html#parameters
    route(ROUTE_BD) {
        post("/$PASSW") {
            call.respond(
                with(call.receiveText()) {
                    substring(1, length - 1) == (System.getenv(
                        ADMIN_PASSW.uppercase().replace(" ", "_")
                    ) ?: "adm")
                }
            )
        }
        route("/{bd_name}") {
            post("/$JSON_PG_UPD/{pg_view?}/{where?}") {
                println("=====$JSON_PG_UPD==param======${call.parameters["pg_view"] ?: ""}===${call.parameters["where"] ?: ""}")
                call.respond(
                    jsonPGupd(
                        setBD(), call.receive(),
                        call.parameters["pg_view"] ?: ""
                    )
                )
            }
            get("/$JSON_PG/{pg_view}/{where?}") {
                call.respond(
                    with(getView()) {
                        if (contains(ERROR_FIELD)
                            && (contains(SQL_STATE_RETRY.split(",")[0]) || contains(SQL_STATE_RETRY.split(",")[1]))
                        )
                            getView() // try getPGConnection  after waiting
                        else this
                    })
            }
        }
    }
}

private fun PipelineContext<Unit, ApplicationCall>.getView() =
    jsonPGview(
        setBD(),
        call.parameters["pg_view"] ?: "",
        call.parameters["where"] ?: "",
        call.parameters["name"] ,
    )

private fun PipelineContext<Unit, ApplicationCall>.setBD() =
    call.parameters["bd_name"]
        .let { bd ->
            if (bd == QUERY_BD)
                System.getenv(QUERY_BD)
            else bd
        } ?: ""
