import java.text.SimpleDateFormat
import java.util.*
import java.io.FileOutputStream
import java.io.IOException
import java.util.Properties
import org.jetbrains.kotlin.gradle.targets.js.webpack.KotlinWebpack

val serializationVersion = "1.6.0"
val ktorVersion = "2.3.6"
val kotlinWrappersVersion = "1.0.0-pre.659"
val kotlinw = "org.jetbrains.kotlin-wrappers:kotlin"
val kotlinVersion = "1.9.21"

plugins {
    kotlin("multiplatform") version "1.9.21"
    application //to run JVM part
    kotlin("plugin.serialization") version "1.9.21"
}

group = "org.example"
version = "1.1"

repositories {
//    google()
    mavenCentral()
}

kotlin {
    sourceSets.all {
        languageSettings {
            languageVersion = "2.0"
        }
    }
}

kotlin {
    jvm {
        withJava()
    }
    js(IR ) {// https://kotlinlang.org/docs/js-ir-migration.html
        browser {
            binaries.executable()
        }
    }
    sourceSets {
        val commonMain by getting {
            dependencies {
                implementation(kotlin("stdlib-common"))
                implementation("org.jetbrains.kotlinx:kotlinx-serialization-core:$serializationVersion")
                implementation("org.jetbrains.kotlinx:kotlinx-serialization-json:$serializationVersion")
//                https://github.com/Kotlin/kotlinx-datetime#using-in-your-projects
//                https://resources.jetbrains.com/storage/products/kotlin/events/kotlin14/Slides/datetime%20.pdf
                implementation("org.jetbrains.kotlinx:kotlinx-datetime:0.4.1")
            }
        }
        val commonTest by getting {
            dependencies {
                implementation(kotlin("test-common"))
                implementation(kotlin("test-annotations-common"))
            }
        }

        val jvmMain by getting {
            dependencies {
                implementation("io.ktor:ktor-serialization-kotlinx-json:$ktorVersion")
                implementation("io.ktor:ktor-server-content-negotiation:$ktorVersion")
                implementation("io.ktor:ktor-server-compression:$ktorVersion")
                implementation("io.ktor:ktor-server-cors:$ktorVersion")
                implementation("io.ktor:ktor-serialization:$ktorVersion")
                implementation("io.ktor:ktor-server-core:$ktorVersion")
                implementation("io.ktor:ktor-server-netty:$ktorVersion")
                implementation("ch.qos.logback:logback-classic:1.4.7")
                implementation("io.ktor:ktor-websockets:$ktorVersion")
//                runtimeOnly("org.jetbrains.kotlin:kotlin-scripting-jsr223:$kotlinVersion") # kotlin-compiler-embeddable
                implementation("org.postgresql:postgresql:42.6.0")
                implementation ("com.google.cloud:google-cloud-bigquery:2.34.2")
//                implementation (platform("com.google.cloud:libraries-bom:26.18.0"))
//                implementation ("com.google.cloud:google-cloud-bigquery")
            }
        }

        val jsMain by getting {
            dependencies {
                implementation("io.ktor:ktor-client-core:$ktorVersion")
                implementation("io.ktor:ktor-client-js:$ktorVersion") //include http&websockets
                implementation("io.ktor:ktor-client-json-js:$ktorVersion")
                implementation("io.ktor:ktor-client-serialization-js:$ktorVersion")
                implementation("io.ktor:ktor-serialization-kotlinx-json:$ktorVersion")
                implementation("io.ktor:ktor-client-content-negotiation:$ktorVersion")
                implementation("org.jetbrains.kotlinx:kotlinx-coroutines-core:1.6.4")
                implementation(project.dependencies.enforcedPlatform("$kotlinw-wrappers-bom:$kotlinWrappersVersion"))
                implementation("$kotlinw-react")
                implementation("$kotlinw-react-dom")
                implementation("$kotlinw-extensions")
                implementation("$kotlinw-emotion") // css {} - not in use now
                implementation("$kotlinw-mui-base")
                implementation("$kotlinw-mui-material")
                implementation("$kotlinw-mui-icons-material")

                implementation(npm("date-fns", "2.30.0"))
                implementation(npm("@date-io/date-fns", "2.17.0"))
                implementation(npm("css-loader", "6.8.1")) //https://discuss.kotlinlang.org/t/kotlin-js-a-style-from-the-npm-package/16759/3
                implementation(npm("style-loader", "3.3.3"))
//                @file:JsModule
                implementation(npm("react-share", "~4.4.1"))//https://www.npmjs.com/package/react-share
                implementation(npm("mui-nested-menu", "~3.2.2"))//https://www.npmjs.com/package/mui-nested-menu
                implementation(npm("ag-grid-community", "~30.2.1")) // https://www.npmjs.com/package/ag-grid-community
//                implementation(npm("ag-grid-enterprise", "~30.0.2")) // not free
                implementation(npm("ag-grid-react", "~30.2.1"))
            }
        }
    }
}

application {
    mainClass.set("ServerKt") // https://docs.gradle.org/current/userguide/application_plugin.html
    tasks.named<JavaExec>("run") {
        myProp()
    }
}

// include JS artifacts in any JAR we generate
tasks.getByName<Jar>("jvmJar") {
    val taskName = if (project.hasProperty("isProduction")) { // in env var ORG_GRADLE_PROJECT_isProduction
        "jsBrowserProductionWebpack"
    } else {
        "jsBrowserDevelopmentWebpack"
    }
    val webpackTask = tasks.getByName<KotlinWebpack>(taskName)
    dependsOn(webpackTask) // make sure JS gets compiled first
    duplicatesStrategy = DuplicatesStrategy.EXCLUDE
    from(webpackTask.outputDirectory, webpackTask.mainOutputFileName) // bring output file along into the JAR
}

tasks {
    withType<org.jetbrains.kotlin.gradle.tasks.KotlinCompile> {
        kotlinOptions {
            jvmTarget = "21" // set GOOGLE_RUNTIME_VERSION=jvmTarget  in CloudRun
        }
    }
}

distributions {
    main {
        contents {
            from("$projectDir/libs") {
                rename("${rootProject.name}-jvm", rootProject.name)
                into("lib")
            }
        }
    }
}

// Alias "installDist" as "stage" (for cloud providers)
//https://devcenter.heroku.com/articles/deploying-gradle-apps-on-heroku#verify-that-your-build-file-is-set-up-correctly
// koyeb : GRADLE_TASK=stage
tasks.create("stage") {
    dependsOn(tasks.getByName("installDist"))
}

tasks.getByName<JavaExec>("run") {
    classpath(tasks.getByName<Jar>("jvmJar")) // so that the JS artifacts generated by `jvmJar` can be found and served
}

//https://stackoverflow.com/questions/35421699/how-to-invoke-external-command-from-within-kotlin-code/41495542#41495542
fun String.runCommand(
    workingDir: File = File("."),
    timeoutAmount: Long = 60,
    timeoutUnit: TimeUnit = TimeUnit.SECONDS
) = runCatching {
    ProcessBuilder("\\s".toRegex().split(this))
        .directory(workingDir)
        .redirectOutput(ProcessBuilder.Redirect.PIPE)
        .redirectError(ProcessBuilder.Redirect.PIPE)
        .start().also { it.waitFor(timeoutAmount, timeoutUnit) }
        .inputStream.bufferedReader().readText()
}.onFailure { it.printStackTrace() }.getOrNull()
    ?.replace("\n", "") ?: ""

fun gitCommitHash() =
    "git rev-parse --verify --short HEAD"
        .runCommand()


fun lastNumberCommit() =
    "git rev-list --first-parent --count HEAD" // current HEAD commit
        .runCommand()

fun myProp() = // https://mkyong.com/java/java-properties-file-examples/
    try {
        if (version != "") {
            FileOutputStream("./src/commonMain/resources/config.properties")
                .use { output ->
                    Properties()
                        .let {
                            it.setProperty(
                                "git.version",
                                "$version.${lastNumberCommit()}-${gitCommitHash()} Compile on ${
                                    SimpleDateFormat("dd.MM.yyyy").format(
                                        Date()
                                    )
                                }"
                            )
                            it.store(output, null)
                            println(it)
                        }
                }
        } else ""
    } catch (e: IOException) {
        e.printStackTrace()
    }

