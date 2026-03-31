plugins {
    id("com.android.application")
    id("kotlin-android")
    // This connects the file to your Flutter/Dart code
    id("dev.flutter.flutter-gradle-plugin")
}

val envPath = System.getenv("ZENITH_KEYSTORE_PATH")
val keystorePath = envPath ?: "../../secrets/zenith-upload-key.jks"

// This print statement is your "eyes" inside the GitHub Action logs!
println("CI/CD DEBUG: Using Keystore Path -> $keystorePath")

android {
    namespace = "com.viyer.zenith_architecture" 
    compileSdk = 36

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

   kotlinOptions {
        jvmTarget = "17"
    }

    defaultConfig {
        applicationId = "com.example.zenith"
        minSdk = flutter.minSdkVersion
        targetSdk = 34
        versionCode = 1
        versionName = "1.0.0"
    }

    signingConfigs {
        create("release") {
            storeFile = file(keystorePath)
            storePassword = System.getenv("ZENITH_KEYSTORE_PASSWORD")
            keyAlias = System.getenv("ZENITH_KEY_ALIAS")
            keyPassword = System.getenv("ZENITH_KEY_PASSWORD")
        }
    }

    buildTypes {
        getByName("release") {
            // Tie the signing config we created above to the release build
            signingConfig = signingConfigs.getByName("release")

            isMinifyEnabled = false 
            isShrinkResources = false
            
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }

        getByName("debug") {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    // Keep your existing dependencies here
}
