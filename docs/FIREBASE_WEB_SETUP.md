# Firebase Web Setup Guide

This guide explains how to configure Firebase for the Web platform in the Easy Exam project.

## Prerequisites

1. Create a Firebase project at [Firebase Console](https://console.firebase.google.com/)
2. Complete Android Firebase setup (see `docs/FIREBASE_ANDROID_SETUP.md`)
3. Enable the following Firebase services:
   - Authentication (Google Sign-In)
   - Cloud Firestore
   - Firebase Storage
   - Cloud Messaging
   - Analytics
   - Crashlytics

## Steps

### 1. Add Web App to Firebase Project

1. Go to Firebase Console → Project Settings
2. Click "Add app" → Web
3. Enter app nickname: `Easy Exam Web` (or your preferred name)
4. (Optional) Check "Set up Firebase Hosting"
5. Click "Register app"
6. Copy the Firebase SDK configuration snippet

### 2. Configure Firebase for Web

#### Option A: Using FlutterFire CLI (Recommended)

Run the following command to automatically configure Firebase for all platforms:

```bash
flutterfire configure
```

This will:
- Automatically detect your Flutter project
- Generate `lib/core/config/firebase_options.dart`
- Configure all platforms (Android, iOS, Web, etc.)

#### Option B: Manual Configuration

If you prefer manual configuration:

1. Copy the Firebase SDK configuration from Firebase Console
2. Create or update `web/index.html` with the Firebase config:

```html
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Easy Exam</title>
  
  <!-- Firebase SDK -->
  <script src="https://www.gstatic.com/firebasejs/9.0.0/firebase-app.js"></script>
  <script src="https://www.gstatic.com/firebasejs/9.0.0/firebase-auth.js"></script>
  <script src="https://www.gstatic.com/firebasejs/9.0.0/firebase-firestore.js"></script>
  <script src="https://www.gstatic.com/firebasejs/9.0.0/firebase-storage.js"></script>
  <script src="https://www.gstatic.com/firebasejs/9.0.0/firebase-messaging.js"></script>
  <script src="https://www.gstatic.com/firebasejs/9.0.0/firebase-analytics.js"></script>
  
  <script>
    const firebaseConfig = {
      apiKey: "YOUR_API_KEY",
      authDomain: "YOUR_AUTH_DOMAIN",
      projectId: "YOUR_PROJECT_ID",
      storageBucket: "YOUR_STORAGE_BUCKET",
      messagingSenderId: "YOUR_MESSAGING_SENDER_ID",
      appId: "YOUR_APP_ID",
      measurementId: "YOUR_MEASUREMENT_ID"
    };
 firebase.initializeApp(firebaseConfig);
  </script>
</head>
<body>
  <!-- Flutter app will be rendered here -->
</body>
</html>
```

3. Update `lib/core/config/firebase_options.dart` with web configuration:

```dart
const FirebaseOptions web = FirebaseOptions(
  apiKey: 'YOUR_API_KEY',
  appId: 'YOUR_APP_ID',
  messagingSenderId: 'YOUR_MESSAGING_SENDER_ID',
  projectId: 'YOUR_PROJECT_ID',
  storageBucket: 'YOUR_STORAGE_BUCKET',
  authDomain: 'YOUR_AUTH_DOMAIN',
  measurementId: 'YOUR_MEASUREMENT_ID',
);
```

### 3. Enable Google Sign-In for Web

1. Go to Firebase Console → Authentication → Sign-in method
2. Enable Google Sign-In
3. Add authorized domains:
   - `localhost` (for development)
   - Your production domain (e.g., `easyexam.example.com`)

### 4. Configure Firestore Security Rules

See `docs/FIRESTORE_SECURITY_RULES.md` for detailed security rules configuration.

### 5. Configure Firebase Hosting (Optional)

If you want to deploy the web app using Firebase Hosting:

1. Install Firebase CLI:
```bash
npm install -g firebase-tools
```

2. Initialize Firebase Hosting:
```bash
firebase login
firebase init hosting
```

3. Build the Flutter web app:
```bash
flutter build web
```

4. Deploy:
```bash
firebase deploy
```

### 6. Test Configuration

Run the web app to verify Firebase is working:

```bash
flutter run -d chrome
```

Check the browser console for Firebase initialization messages.

## Troubleshooting

### "Firebase initialization failed"
- Verify Firebase config values are correct
- Check that all required Firebase services are enabled
- Ensure the domain is authorized in Firebase Console

### "Google Sign-In fails on web"
- Verify the domain is added to authorized domains
- Check that Google Sign-In is enabled in Authentication settings
- Ensure pop-ups are not blocked in the browser

### "Firestore permission denied"
- Verify Firestore security rules are properly configured
- Check that the user is authenticated
- Review the security rules in Firebase Console

## Web-Specific Considerations

### CORS Configuration

If you encounter CORS issues with Firebase Storage, configure CORS in Firebase Storage:

1. Install gsutil:
```bash
pip install gsutil
```

2. Create `cors.json`:
```json
[
  {
    "origin": ["*"],
    "method": ["GET"],
    "maxAgeSeconds": 3600
  }
]
```

3. Apply CORS configuration:
```bash
gsutil cors set cors.json gs://your-storage-bucket
```

### Service Worker for PWA

For Progressive Web App (PWA) functionality, configure service worker in `web/index.html`.

## Next Steps

After completing Web setup, proceed to:
1. Implement authentication flow (Phase 4)
2. Build admin dashboard (Phase 6)
