import io.ktor.http.*
import io.ktor.server.application.*
import io.ktor.server.engine.*
import io.ktor.server.http.content.*
import io.ktor.server.netty.*
import io.ktor.server.plugins.compression.*
import io.ktor.server.plugins.contentnegotiation.*
import io.ktor.server.plugins.cors.routing.*
import io.ktor.server.routing.*
import io.ktor.serialization.kotlinx.json.*
import java.text.SimpleDateFormat
import java.util.*

fun main() {
    loadEnv()

    embeddedServer(Netty, System.getenv("PORT")?.toInt() ?: 9090) {
        install(ContentNegotiation) {
            json()
        }
        install(CORS) {
            allowMethod(HttpMethod.Get)
            allowMethod(HttpMethod.Post)
            allowMethod(HttpMethod.Delete)
            anyHost()
            allowHeader(HttpHeaders.ContentType) // for work http post on Heroku
        }
        install(Compression) {
            gzip()
        }
        routing {
            getAndPost()
            static("/") {
                resources("")
            }
        }
    }.start(wait = true)
}

private fun loadEnv() {
    startEnv[GIT_VERSION] =
        "ver:${System.getenv(GIT_VERSION) ?: ""}  (${SimpleDateFormat("dd.MM.yyyy").format(Date())})"
    startEnv[JSR223] = System.getenv(JSR223) ?: ""
    startEnv[FIRSTQUERY] = System.getenv(FIRSTQUERY) ?: ""
    startEnv[ENDPOINT_SERVICE_URL] = System.getenv(ENDPOINT_SERVICE_URL) ?: ""
    println("startEnv=$startEnv")
}
