import io.ktor.http.*
import io.ktor.serialization.kotlinx.json.*
import io.ktor.server.application.*
import io.ktor.server.engine.*
import io.ktor.server.http.content.*
import io.ktor.server.netty.*
import io.ktor.server.plugins.compression.*
import io.ktor.server.plugins.contentnegotiation.*
import io.ktor.server.plugins.cors.routing.*
import io.ktor.server.routing.*
import java.io.File
import java.io.IOException
import java.text.SimpleDateFormat
import java.util.*
import ch.qos.logback.classic.Level
import ch.qos.logback.classic.LoggerContext
import org.slf4j.LoggerFactory

var queryBdName: String= QUERY_BD

fun main() {
//    https://stackoverflow.com/questions/74115382/how-to-turn-off-netty-library-debug-output-using-slf4j-programmatically
    (LoggerFactory.getILoggerFactory() as LoggerContext)
        .getLogger("io.netty")
        .setLevel(Level.INFO)

    embeddedServer(Netty, System.getenv("PORT")?.toInt() ?: 9090) {
        loadEnv(this::class.java.classLoader)
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
            staticFiles("/", File("")) {
                staticResources("/", null)
            }
        }
    }.start(wait = true)
}

private fun loadEnv(loader:ClassLoader) = // https://mkyong.com/java/java-properties-file-examples/
    try {
        loader.getResourceAsStream("config.properties").use { input ->
            Properties()
                .let {
                    it.load(input)
                    startEnv[GIT_VERSION] =
                        "ver:${it.getProperty(GIT_VERSION) ?: ""}  (Start on ${SimpleDateFormat("dd.MM.yyyy").format(Date())})"
                    startEnv[JSR223] = System.getenv(JSR223) ?: HIDE
                    startEnv[FIRSTQUERY] = System.getenv(FIRSTQUERY) ?: ""
                    startEnv[ENDPOINT_SERVICE_URL] = System.getenv(ENDPOINT_SERVICE_URL) ?: ""
                    startEnv[VIEW_QUERY_NAME] = System.getenv(VIEW_QUERY_NAME) ?: VIEW_QUERY
                    startEnv[VIEW_QUERY_WHERE] = System.getenv(VIEW_QUERY_WHERE) ?: VIEW_QUERY_WHERE_DEFAULT
                    println("startEnv=$startEnv")
            }
        }
        System.getenv(QUERY_BD)?.let {
            queryBdName = it
            startEnv[QUERY_BD] = System.getenv(QUERY_BD)
            getBaseConnection(it) // after reload server
            loadTestingKeys = System.getenv(LOAD_TESTING_KEYS) ?: LOAD_TESTING_KEYS
        }
    } catch (ex: IOException) {
        ex.printStackTrace()
    }

