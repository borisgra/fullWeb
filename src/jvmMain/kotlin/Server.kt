import io.ktor.application.*
import io.ktor.features.*
import io.ktor.http.*
import io.ktor.http.content.*
import io.ktor.response.*
import io.ktor.routing.*
import io.ktor.serialization.*
import io.ktor.server.engine.*
import io.ktor.server.netty.*
import java.io.FileInputStream
import java.util.*


fun main() {
    val port = System.getenv("PORT")?.toInt() ?: 9090
    embeddedServer(Netty, port) {
        install(ContentNegotiation) {
            json()
        }
        install(CORS) {
            method(HttpMethod.Get)
            method(HttpMethod.Post)
            method(HttpMethod.Delete)
            anyHost()
            header(HttpHeaders.ContentType) // for work http post on Heroku
        }
        install(Compression) {
            gzip()
        }

//        https://stackoverflow.com/questions/14583282/heroku-display-hash-of-current-commit-in-browser
//        heroku labs:enable runtime-dyno-metadata -a <app name>
        routing {
            post(LOADENV) {
                startEnv[FIRSTQUERY] = System.getenv(FIRSTQUERY) ?: ""
                startEnv[GITVERSION] = "Version:${gitVersion()}"
                println("startEnv=$startEnv")
                call.respond(startEnv)
            }
            get("/") {
                call.respondText(
                    (this::class.java.classLoader.getResource("index.html")?.readText() ?: "")
                    ,ContentType.Text.Html
                )
            }
            getAndPost()
            static("/") {
                resources("")
            }
        }
    }.start(wait = true)
}

//https://chercher.tech/kotlin/properties-file-kotlin#read-properties-file
private fun gitVersion() =
    runCatching {
        Properties().let { prop ->
            prop.load(FileInputStream(PROJECT_PROPERTIES))
            System.getenv("HEROKU_RELEASE_VERSION")?.let {
                "$it-${System.getenv("HEROKU_SLUG_COMMIT").substring(0, 7)}"
            } ?: prop.getProperty(GIT_VERSION)
        }
    }.onFailure { it.printStackTrace() }.getOrNull() ?: GIT_VERSION
