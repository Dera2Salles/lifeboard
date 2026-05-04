allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}

subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}

// Fix for "Namespace not specified" error in legacy plugins like isar_flutter_libs
subprojects {
    val applyNamespace = { p: Project ->
        val android = p.extensions.findByName("android")
        if (android != null) {
            try {
                val getNamespace = android.javaClass.getMethod("getNamespace")
                if (getNamespace.invoke(android) == null) {
                    val setNamespace = android.javaClass.getMethod("setNamespace", String::class.java)
                    val ns = if (p.name == "isar_flutter_libs") {
                        "dev.isar.isar_flutter_libs"
                    } else {
                        "com.lifeboard.${p.name.replace("-", "_")}"
                    }
                    setNamespace.invoke(android, ns)
                }
            } catch (e: Exception) {
            }
        }
    }

    if (project.state.executed) {
        applyNamespace(project)
    } else {
        project.afterEvaluate {
            applyNamespace(this)
        }
    }
}
