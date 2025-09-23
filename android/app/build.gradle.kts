plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    signingConfigs {
        create("release")
    }

    namespace = project.extra["app_id"] as String
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_1_8.toString()
    }

    defaultConfig {
        applicationId = project.extra["app_id"] as String
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            isMinifyEnabled = true
            isShrinkResources = true
            signingConfig = signingConfigs.getByName("release")
            ndk.debugSymbolLevel = "FULL"
        }
        debug {
            isDebuggable = true
            isMinifyEnabled = false
            isShrinkResources = false
            signingConfig = signingConfigs.getByName("debug")
        }
    }

    // Disable legacy packaging
    packaging {
        jniLibs {
            useLegacyPackaging = false
        }
    }
}

// Create a variable called keystorePropertiesFile, and initialize it to your
// keystore.properties file, in the rootProject folder.
val props = Properties()
val propFile = File("keystore.properties")

// Check if we can read the file
if (propFile.canRead()) {
    props.load(FileInputStream(propFile))

    // Before assigning, we check if key is present
    if (props.containsKey("STORE_FILE") && 
        props.containsKey("STORE_PASSWORD") && 
        props.containsKey("KEY_ALIAS") && 
        props.containsKey("KEY_PASSWORD")) {
        
        // Load release configs
        android.signingConfigs.getByName("release") {
            storeFile = file(props["STORE_FILE"] as String)
            storePassword = props["STORE_PASSWORD"] as String
            keyAlias = props["KEY_ALIAS"] as String
            keyPassword = props["KEY_PASSWORD"] as String
        }
    } else {
        println("signing.properties found but some entries are missing")
        android.buildTypes.getByName("release").signingConfig = null
    }
} else {
    println("signing.properties not found")
    android.buildTypes.getByName("release").signingConfig = null
}

flutter {
    source = "../.."
}