@file:Suppress("UNUSED_VARIABLE")

import org.jetbrains.kotlin.gradle.targets.js.webpack.KotlinWebpack

val serializationVersion = "1.4.1"  // 1.5.0 not work
val ktorVersion = "2.2.3" // 2.2.4 not work
val kotlinWrappersVersion = "1.0.0-pre.523" // > 523- kotlin-react:18.2.0-pre.524 was found - only IR compiler
val kotlinw = "org.jetbrains.kotlin-wrappers:kotlin"
val kotlinVersion = "1.8.21"

plugins {
    kotlin("multiplatform") version "1.8.21"
    application //to run JVM part
    kotlin("plugin.serialization") version "1.8.21"
}

group = "org.example"
version = "1.0.beta"

repositories {
    google()
    mavenCentral()
}

kotlin {
    jvm {
        withJava()
    }
    js(LEGACY ) { //IR not work
        browser {
            binaries.executable()
        }
    }
    sourceSets {
        val commonMain by getting {
            dependencies {
                implementation(kotlin("stdlib-common"))
                implementation("org.jetbrains.kotlinx:kotlinx-serialization-core:$serializationVersion")
//                https://github.com/Kotlin/kotlinx-datetime#using-in-your-projects
//                https://resources.jetbrains.com/storage/products/kotlin/events/kotlin14/Slides/datetime%20.pdf
                implementation("org.jetbrains.kotlinx:kotlinx-datetime:0.4.0")
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
                implementation("ch.qos.logback:logback-classic:1.2.3")
                implementation("io.ktor:ktor-websockets:$ktorVersion")
//                runtimeOnly("org.jetbrains.kotlin:kotlin-main-kts:$kotlinVersion")
                runtimeOnly("org.jetbrains.kotlin:kotlin-scripting-jsr223:$kotlinVersion")
                implementation("org.postgresql:postgresql:42.4.0")
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
                implementation("$kotlinw-mui")
                implementation("$kotlinw-mui-icons")

                implementation(npm("date-fns", "2.29.3"))
                implementation(npm("@date-io/date-fns", "2.16.0"))
                implementation(npm("css-loader", "6.7.3")) //https://discuss.kotlinlang.org/t/kotlin-js-a-style-from-the-npm-package/16759/3
                implementation(npm("style-loader", "3.3.2"))
//                @file:JsModule
                implementation(npm("react-share", "~4.4.1"))//https://www.npmjs.com/package/react-share
                implementation(npm("mui-nested-menu", "~3.2.0"))//https://www.npmjs.com/package/mui-nested-menu
                implementation(npm("ag-grid-community", "~29.2.0")) // https://www.npmjs.com/package/ag-grid-community
                implementation(npm("ag-grid-enterprise", "~29.2.0")) // not free
                implementation(npm("ag-grid-react", "~29.2.0"))
            }
        }
    }
}

application {// https://docs.gradle.org/current/userguide/application_plugin.html
    mainClass.set("ServerKt")
    tasks.named<JavaExec>("run") {  //https://stackoverflow.com/questions/69947839/how-do-i-get-a-custom-property-defined-in-gradle-properties-in-kotlin-code
//        systemProperty("git.version", "${lastNumberCommit()}-${gitCommitHash()}")
        environment["git_version"] = "${lastNumberCommit()}-${gitCommitHash()}"
        println("Gradle Run git_version= ${environment["git_version"]}")
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
    from(File(webpackTask.destinationDirectory, webpackTask.outputFileName)) // bring output file along into the JAR
}

tasks {
    withType<org.jetbrains.kotlin.gradle.tasks.KotlinCompile> {
        kotlinOptions {
            jvmTarget = "17"
        }
    }
}

distributions {
    main {
        contents {
            from("$buildDir/libs") {
                rename("${rootProject.name}-jvm", rootProject.name)
                into("lib")
            }
        }
    }
}

// Alias "installDist" as "stage" (for cloud providers)
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

