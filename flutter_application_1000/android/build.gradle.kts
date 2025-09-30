import org.gradle.api.tasks.Delete
import org.gradle.api.plugins.JavaPlugin
import org.gradle.api.tasks.compile.JavaCompile
import org.jetbrains.kotlin.gradle.tasks.KotlinCompile

subprojects {
    afterEvaluate {
        // توحيد إعدادات الـ Java على جميع الموديولات (بما فيها الـ plugin)
        extensions.findByType<com.android.build.gradle.BaseExtension>()?.apply {
            compileOptions {
                sourceCompatibility = JavaVersion.VERSION_17
                targetCompatibility = JavaVersion.VERSION_17
            }
        }
        // توحيد إعدادات الـ Kotlin على جميع الموديولات
        extensions.findByType<org.jetbrains.kotlin.gradle.dsl.KotlinJvmOptions>()?.apply {
            jvmTarget = "17"
        }
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

rootProject.buildDir = file("../build")

subprojects {
    buildDir = file("${rootProject.buildDir}/${name}")
    evaluationDependsOn(":app")

    plugins.withType<JavaPlugin> {
        extensions.configure<org.gradle.api.plugins.JavaPluginExtension>("java") {
            toolchain {
                languageVersion.set(JavaLanguageVersion.of(17))
            }
        }

        tasks.withType<JavaCompile>().configureEach {
            sourceCompatibility = JavaVersion.VERSION_17.toString()
            targetCompatibility = JavaVersion.VERSION_17.toString()
        }
    }

    plugins.withId("org.jetbrains.kotlin.android") {
        tasks.withType<KotlinCompile>().configureEach {
            kotlinOptions.jvmTarget = "17"
        }
    }
}
plugins {
    id("com.android.application") apply false
    id("org.jetbrains.kotlin.android") apply false
}


tasks.register<Delete>("clean") {
    delete(rootProject.buildDir)
}


