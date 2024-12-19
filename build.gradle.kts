import java.text.SimpleDateFormat
import java.util.*
import java.io.FileOutputStream
import java.io.IOException
import java.util.Properties
import org.jetbrains.kotlin.gradle.targets.js.webpack.KotlinWebpack
import org.jetbrains.kotlin.gradle.dsl.JvmTarget
import org.jetbrains.kotlin.gradle.tasks.KotlinJvmCompile
import org.jetbrains.kotlin.org.apache.commons.io.output.ByteArrayOutputStream

val serializationVersion = "1.7.3"
val ktorVersion = "3.0.1"
val pre = 841 // from 601: not work requireAll(require ;from 609: npm react-share
val kotlinWrappersVersion = "1.0.0-pre.$pre"
val kotlinw = "org.jetbrains.kotlin-wrappers:kotlin"

plugins {
    kotlin("multiplatform") version "2.1.0"
    application //to run JVM part
    kotlin("plugin.serialization") version "2.1.0"
}

group = "org.example"
version = "1.2"

repositories {
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
                implementation("org.jetbrains.kotlinx:kotlinx-datetime:0.6.1")
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
                implementation("ch.qos.logback:logback-classic:1.5.12")
                implementation("io.ktor:ktor-websockets:$ktorVersion")
//                runtimeOnly("org.jetbrains.kotlin:kotlin-scripting-jsr223:$kotlinVersion") # kotlin-compiler-embeddable
                implementation("org.postgresql:postgresql:42.7.4")
                implementation ("com.google.cloud:google-cloud-bigquery:2.44.0")
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
                implementation("org.jetbrains.kotlinx:kotlinx-coroutines-core:1.9.0")
                implementation(project.dependencies.enforcedPlatform("$kotlinw-wrappers-bom:$kotlinWrappersVersion"))
                implementation("$kotlinw-react")
                implementation("$kotlinw-react-dom")
//                implementation("$kotlinw-extensions") // is deprecated - aSemy and turansky committed on May 9 2024
                implementation("$kotlinw-emotion") // css {} ,GlobalStyles
                if (pre > 638) {
                    implementation("$kotlinw-mui-base")
                    implementation("$kotlinw-mui-material")
                    implementation("$kotlinw-mui-icons-material")
                } else {
                    implementation("$kotlinw-mui")
                    implementation("$kotlinw-mui-icons")
                }

                implementation(npm("date-fns", "4.1.0"))
                implementation(npm("@date-io/date-fns", "3.0.0"))
                implementation(npm("css-loader", "7.1.2")) //https://discuss.kotlinlang.org/t/kotlin-js-a-style-from-the-npm-package/16759/3
                implementation(npm("style-loader", "4.0.0"))
//                @file:JsModule
                implementation(npm("react-share", "~5.1.1"))//https://www.npmjs.com/package/react-share
                implementation(npm("mui-nested-menu", "~3.4.0"))//https://www.npmjs.com/package/mui-nested-menu
                implementation(npm("ag-grid-community", "~32.3.3")) // https://www.npmjs.com/package/ag-grid-community
                implementation(npm("ag-grid-react", "~32.3.3"))
                implementation(npm("@ag-grid-community/styles", "~32.3.3"))
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

//https://stackoverflow.com/questions/77363060/how-to-replace-the-deprecated-kotlinoptions-in-a-java-library-kotlin-module
tasks.withType<KotlinJvmCompile>().configureEach {
    compilerOptions {
        jvmTarget.set(JvmTarget.JVM_23) // set GOOGLE_RUNTIME_VERSION=jvmTarget  in CloudRun
        freeCompilerArgs.add("-opt-in=kotlin.RequiresOptIn")
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

//https://discuss.gradle.org/t/how-to-run-execute-string-as-a-shell-command-in-kotlin-dsl/32235/9
fun String.runCommand(currentWorkingDir: File = file(".")) =
    runCatching {
        val byteOut = ByteArrayOutputStream()
        project.exec {
            workingDir = currentWorkingDir
            commandLine = this@runCommand.split("\\s".toRegex())
            standardOutput = byteOut
        }
        String(byteOut.toByteArray()).trim()
    }.onFailure { println("ERROR RUN command: $this \n msg: ${it.message}") }.getOrNull()

//https://stackoverflow.com/questions/35421699/how-to-invoke-external-command-from-within-kotlin-code/41495542#41495542
fun String.runCommand_old(
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
                                "$version.${lastNumberCommit()}-${gitCommitHash()} node.${"node -v".runCommand()} Compile on ${
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
        println("Gradle:my config.properties ERROR ${e.message}")
    }

