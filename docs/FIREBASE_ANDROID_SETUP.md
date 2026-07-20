# Firebase Android Setup Guide

This guide explains how to configure Firebase for the Android platform in the Easy Exam project.

## Prerequisites

1. Create a Firebase project at [Firebase Console](https://console.firebase.google.com/)
2. Enable the following Firebase services:
   - Authentication (Google Sign-In)
   - Cloud Firestore
   - Firebase Storage
   - Cloud Messaging
   - Analytics
   - Crashlytics

## Steps

### 1. Add Android App to Firebase Project

1. Go to Firebase Console → Project Settings
2. Click "Add app" → Android
3. Enter package name: `com.example.easyexam` (or your custom package name)
4. (Optional) Enter app nickname
5. Download `google-services.json`
6. Place the file in `android/app/` directory

### 2. Configure build.gradle Files

#### Project-level build.gradle (`android/build.gradle`)

Add the Google Services dependency:

```gradle
buildscript {
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        classpath 'com.android.tools.build:gradle:7.3.0'
        classpath 'com.google.gms:google-services:4.3.15'
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}
```

#### App-level build.gradle (`android/app/build.gradle`)

Add the Google Services plugin:

```gradle
plugins {
    id "com.android.application"
    id "kotlin-android"
    id "com.google.gms.google-services"  // Add this line
}

android {
    // ... existing configuration
}

dependencies {
    // ... existing dependencies
}
```

### 3. Configure Android Manifest

Add permissions to `android/app/src/main/AndroidManifest.xml`:

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="com.example.easyexam">

    <!-- Internet permission -->
    <uses-permission android:name="android.permission.INTERNET" />

    <!-- Notification permissions for FCM -->
    <uses-permission android:name="android.permission.POST_NOTIFICATIONS" />

    <application
        android:label="Easy Exam"
        android:name="${applicationName}"
        android:icon="@mipmap/ic_launcher">
        
        <!-- ... existing configuration -->
        
    </application>
</manifest>
```

### 4. Enable Google Sign-In

1. Go to Firebase Console → Authentication → Sign-in method
2. Enable Google Sign-In
3. Add your SHA-1 fingerprint (required for release builds)

#### Get SHA-1 Fingerprint

For debug:
```bash
keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android
```

For release:
```bash
keytool -list -v -keystore <path-to-your-keystore> -alias <your-alias>
```

### 5. Configure Firestore Security Rules

See `docs/FIRESTORE_SECURITY_RULES.md` for detailed security rules configuration.

### 6. Test Configuration

Run the app to verify Firebase is working:

```bash
flutter run
```

Check the console logs for Firebase initialization messages.

## Troubleshooting

### "google-services.json not found"
- Ensure `google-services.json` is placed in `android/app/` directory
- Verify the package name in Firebase Console matches your app

### "Firebase initialization failed"
- Check that all required Firebase services are enabled
- Verify internet connection
- Check console logs for specific error messages

### "Google Sign-In fails"
- Ensure SHA-1 fingerprint is added to Firebase Console
- Verify Google Sign-In is enabled in Authentication settings
- Check that the package name matches

## Next Steps

After completing Android setup, proceed to:
1. Web Firebase setup (see `docs/FIREBASE_WEB_SETUP.md`)
2. Implement authentication flow (Phase 4)
