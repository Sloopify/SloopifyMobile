plugins {
    id("com.android.application")
    id("kotlin-android")
    id("com.google.gms.google-services")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.sloopify_mobile"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.example.sloopify_mobile"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        compileSdk = 35
        ndkVersion = "27.0.12077973"
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

//        signingConfigs {
//        create("release") {
//            storeFile =file("C:\\Users\\Nour-Alkhalel\\StudioProjects\\Sloopify_Mobile\\android\\sloopiy-release-key.jks")
//            storePassword= "sloopify"
//            keyAlias ="sloopify-key-alias"
//            keyPassword ="sloopify"
//        }
//    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
             // signingConfig = signingConfigs.getByName("release")
        }
    }


}

flutter {
    source = "../.."
}
dependencies {
    implementation(platform("com.google.firebase:firebase-bom:33.10.0"))
    implementation("com.google.firebase:firebase-analytics-ktx")
}