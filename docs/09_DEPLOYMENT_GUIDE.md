# Deployment Guide - Easy Exam

## Document Information
- **Project:** Easy Exam
- **Version:** 1.0.0
- **Purpose:** Comprehensive deployment guide for Phase 12 - Deployment
- **Last Updated:** 2026

---

## Overview

This guide provides step-by-step instructions for deploying the Easy Exam application to production, including Android APK/AAB build, Web Admin deployment, Firebase configuration, and database backup strategy.

---

## Prerequisites

### Tools Required
- Flutter SDK 3.11.0 or higher
- Android Studio (for Android builds)
- Node.js (for web deployment, optional)
- Firebase CLI
- Google account with Firebase access

### Accounts Required
- Google Play Console account (for Play Store publishing)
- Firebase account
- GitHub account (for code hosting)

---

## 1. Android Deployment

### 1.1 Create Signing Keystore

#### Generate Keystore
```bash
keytool -genkey -v -keystore ~/easyexam-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias easyexam
```

#### Store Keystore Securely
- **IMPORTANT:** Never commit the keystore file to version control
- Store the keystore in a secure location
- Keep backup copies in different secure locations
- Document the keystore password and key password securely

### 1.2 Configure Signing

#### Create key.properties
1. Copy `android/key.properties.example` to `android/key.properties`
2. Fill in your actual keystore information:

```properties
storePassword=your_keystore_password
keyPassword=your_key_password
keyAlias=easyexam
storeFile=/path/to/easyexam-keystore.jks
```

#### Update build.gradle.kts
The `android/app/build.gradle.kts` file should reference the key.properties:

```kotlin
// Add at the top of android block
val keystorePropertiesFile = rootProject.file("key.properties")
val keystoreProperties = Properties()
keystoreProperties.load(FileInputStream(keystorePropertiesFile))

android {
    signingConfigs {
        create("release") {
            keyAlias = keystoreProperties["keyAlias"] as String
            keyPassword = keystoreProperties["keyPassword"] as String
            storeFile = file(keystoreProperties["storeFile"] as String)
            storePassword = keystoreProperties["storePassword"] as String
        }
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("release")
            isMinifyEnabled = true
            isShrinkResources = true
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
    }
}
```

### 1.3 Update Application ID

Update `android/app/build.gradle.kts`:

```kotlin
defaultConfig {
    applicationId = "com.yourschool.easyexam"  // Change to your school's package name
    minSdk = flutter.minSdkVersion
    targetSdk = flutter.targetSdkVersion
    versionCode = 1
    versionName = "1.0.0"
}
```

### 1.4 Update App Name and Icon

#### Update App Name
Edit `android/app/src/main/AndroidManifest.xml`:

```xml
<application
    android:label="Easy Exam"  <!-- Your app name -->
    android:name="${applicationName}"
    android:icon="@mipmap/ic_launcher">
```

#### Update App Icon
Replace the launcher icons in:
- `android/app/src/main/res/mipmap-*/ic_launcher.png`
- `android/app/src/main/res/mipmap-*/ic_launcher_foreground.png`

Use Android Studio's Image Asset Studio or an online tool to generate icons.

### 1.5 Build APK (for testing/distribution)

```bash
cd android
./gradlew assembleRelease
```

The APK will be located at:
`android/app/build/outputs/apk/release/app-release.apk`

### 1.6 Build App Bundle (for Play Store)

```bash
cd android
./gradlew bundleRelease
```

The AAB will be located at:
`android/app/build/outputs/bundle/release/app-release.aab`

### 1.7 Publish to Google Play Store

#### Create Google Play Console Account
1. Go to [Google Play Console](https://play.google.com/console)
2. Create a new developer account ($25 one-time fee)
3. Complete the registration process

#### Create App Listing
1. In Play Console, create a new app
2. Fill in app information:
   - App name: Easy Exam
   - Description: [Provide app description]
   - Screenshots: [Provide screenshots]
   - Icon: [Provide app icon]
   - Feature graphic: [Provide feature graphic]

#### Upload App Bundle
1. Go to "Release" > "Production" (or "Internal Testing" for testing)
2. Create a new release
3. Upload the AAB file
4. Fill in release notes

#### Configure Content Rating
1. Complete the content rating questionnaire
2. Get content rating certificate

#### Set Pricing and Distribution
1. Set price (Free)
2. Select distribution countries
3. Opt out of ads (if applicable)

#### Submit for Review
1. Review all information
2. Submit for review
3. Wait for approval (typically 1-3 days)

---

## 2. Web Admin Deployment

### 2.1 Build Web Release

```bash
flutter build web --release
```

The build will be located at:
`build/web/`

### 2.2 Deploy to Firebase Hosting

#### Install Firebase CLI
```bash
npm install -g firebase-tools
```

#### Login to Firebase
```bash
firebase login
```

#### Initialize Firebase Hosting
```bash
firebase init hosting
```

Follow the prompts:
- Select your Firebase project
- Use `build/web` as your public directory
- Configure as a single-page app (yes)
- Overwrite index.html (no)

#### Deploy
```bash
firebase deploy --only hosting
```

### 2.3 Deploy to Other Hosting Services

#### Netlify
```bash
npm install -g netlify-cli
netlify deploy --prod --dir=build/web
```

#### Vercel
```bash
npm install -g vercel
vercel --prod
```

#### GitHub Pages
1. Push build to `gh-pages` branch
2. Enable GitHub Pages in repository settings

---

## 3. Firebase Production Configuration

### 3.1 Create Firebase Production Project

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Create a new project
3. Name it (e.g., "easyexam-production")
4. Enable Google Analytics (optional but recommended)
5. Create project

### 3.2 Add Android App

1. In Firebase Console, go to Project Settings
2. Add Android app
3. Package name: `com.yourschool.easyexam`
4. Download `google-services.json`
5. Place in `android/app/`
6. Add dependencies to `android/build.gradle` (if not already added)
7. Add plugin to `android/app/build.gradle` (if not already added)

### 3.3 Add Web App

1. In Firebase Console, go to Project Settings
2. Add Web app
3. App nickname: Easy Exam Web
4. Copy firebaseConfig object
5. Update `web/index.html` with the config

### 3.4 Configure Authentication

1. Enable Google Sign-In in Firebase Console
2. Add authorized domains for web
3. Configure OAuth consent screen

### 3.5 Configure Firestore

1. Create Firestore database
2. Choose production mode (or start in test mode)
3. Set up indexes for complex queries
4. Configure security rules (see section 4)

### 3.6 Configure Firebase Storage

1. Enable Storage
2. Set up security rules
3. Configure CORS if needed

### 3.7 Configure Cloud Messaging

1. Enable Cloud Messaging
2. Add server key (if using custom server)
3. Configure APNs for iOS (if deploying iOS)

### 3.8 Configure Crashlytics

1. Enable Crashlytics
2. Accept terms
3. Crashlytics will automatically start collecting crash reports

### 3.9 Update Environment Configuration

Update `.env` file or configuration files with production Firebase config:

```env
# Production Firebase Configuration
FIREBASE_API_KEY=your_production_api_key
FIREBASE_AUTH_DOMAIN=your_project.firebaseapp.com
FIREBASE_PROJECT_ID=your_production_project_id
FIREBASE_STORAGE_BUCKET=your_production_bucket.appspot.com
FIREBASE_MESSAGING_SENDER_ID=your_sender_id
FIREBASE_APP_ID=your_app_id
FIREBASE_MEASUREMENT_ID=your_measurement_id
```

---

## 4. Firebase Security Rules

### 4.1 Firestore Security Rules

```rules
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    
    // Helper functions
    function isAuthenticated() {
      return request.auth != null;
    }
    
    function isTeacher(userId) {
      return isAuthenticated() && 
             get(/databases/$(database)/documents/teachers/$(userId)).data != null;
    }
    
    function isStudent(userId) {
      return isAuthenticated() && 
             get(/databases/$(database)/documents/students/$(userId)).data != null;
    }
    
    function isAuthorized() {
      return isTeacher(request.auth.uid) || isStudent(request.auth.uid);
    }
    
    // Teachers collection - only teachers can read/write
    match /teachers/{teacherId} {
      allow read: if isTeacher(teacherId) || isTeacher(request.auth.uid);
      allow write: if isTeacher(request.auth.uid);
    }
    
    // Students collection - teachers can read/write, students can read own
    match /students/{studentId} {
      allow read: if isTeacher(request.auth.uid) || isStudent(studentId);
      allow write: if isTeacher(request.auth.uid);
    }
    
    // Classes collection - teachers can read/write
    match /classes/{classId} {
      allow read: if isAuthorized();
      allow write: if isTeacher(request.auth.uid);
    }
    
    // Subjects collection - teachers can read/write
    match /subjects/{subjectId} {
      allow read: if isAuthorized();
      allow write: if isTeacher(request.auth.uid);
    }
    
    // Exams collection - teachers can read/write, students can read published
    match /exams/{examId} {
      allow read: if isTeacher(request.auth.uid) || 
                  (isStudent(request.auth.uid) && 
                   resource.data.status == 'published' &&
                   request.auth.uid in get(/databases/$(database)/documents/students/$(request.auth.uid)).data.classId);
      allow write: if isTeacher(request.auth.uid);
    }
    
    // Questions collection - teachers can read/write
    match /questions/{questionId} {
      allow read: if isAuthorized();
      allow write: if isTeacher(request.auth.uid);
    }
    
    // Exam sessions - students can read/write own, teachers can read all
    match /exam_sessions/{sessionId} {
      allow read: if isTeacher(request.auth.uid) || 
                  resource.data.studentId == request.auth.uid;
      allow write: if resource.data.studentId == request.auth.uid;
      allow create: if isStudent(request.auth.uid);
    }
    
    // Exam answers - students can read/write own, teachers can read all
    match /exam_answers/{answerId} {
      allow read: if isTeacher(request.auth.uid) || 
                  resource.data.studentId == request.auth.uid;
      allow write: if resource.data.studentId == request.auth.uid;
      allow create: if isStudent(request.auth.uid);
    }
    
    // Exam results - students can read own, teachers can read/write
    match /exam_results/{resultId} {
      allow read: if isTeacher(request.auth.uid) || 
                  resource.data.studentId == request.auth.uid;
      allow write: if isTeacher(request.auth.uid);
    }
    
    // Notifications - users can read own, teachers can write
    match /notifications/{notificationId} {
      allow read: if resource.data.userId == request.auth.uid;
      allow write: if isTeacher(request.auth.uid);
    }
    
    // App settings - teachers can read/write
    match /app_settings/{settingsId} {
      allow read: if isAuthorized();
      allow write: if isTeacher(request.auth.uid);
    }
  }
}
```

### 4.2 Storage Security Rules

```rules
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    
    function isAuthenticated() {
      return request.auth != null;
    }
    
    function isTeacher(userId) {
      return isAuthenticated() && 
             firestore.get(/databases/(default)/documents/teachers/$(userId)).data != null;
    }
    
    // Question images - teachers can upload, everyone can read
    match /questions/{allPaths=**} {
      allow read: if true;
      allow write: if isTeacher(request.auth.uid);
    }
    
    // Profile photos - users can upload own, everyone can read
    match /profiles/{userId}/{allPaths=**} {
      allow read: if true;
      allow write: if request.auth.uid == userId;
    }
  }
}
```

### 4.3 Deploy Security Rules

Using Firebase CLI:
```bash
firebase deploy --only firestore:rules
firebase deploy --only storage:rules
```

---

## 5. Database Backup Strategy

### 5.1 Automated Backups

Firestore automatically backs up data, but you should implement additional backup strategies:

#### Using Firebase Scheduled Exports
1. In Firebase Console, go to Firestore
2. Click "Scheduled Exports"
3. Create scheduled export to Cloud Storage
4. Schedule: Daily or weekly
5. Export location: Cloud Storage bucket

#### Using Cloud Functions for Custom Backups
Create a Cloud Function to export data:

```javascript
const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

exports.scheduledBackup = functions.pubsub.schedule('0 2 * * *').onRun(async (context) => {
  const firestore = admin.firestore();
  const bucket = admin.storage().bucket();
  
  // Export collections
  const collections = ['teachers', 'students', 'classes', 'subjects', 'exams', 'questions'];
  
  for (const collection of collections) {
    const snapshot = await firestore.collection(collection).get();
    const data = snapshot.docs.map(doc => doc.data());
    
    const filename = `backups/${collection}-${Date.now()}.json`;
    const file = bucket.file(filename);
    
    await file.save(JSON.stringify(data, null, 2), {
      contentType: 'application/json'
    });
  }
  
  console.log('Backup completed');
});
```

### 5.2 Manual Backup

#### Export Data Using Firebase Console
1. Go to Firestore in Firebase Console
2. Select collection
3. Click "Export"
4. Choose format (JSON)
5. Download

#### Export Using Firebase CLI
```bash
firestore export gs://your-bucket/backups
```

#### Import Data
```bash
firestore import gs://your-bucket/backups
```

### 5.3 Backup Retention Policy

- **Daily backups:** Keep for 7 days
- **Weekly backups:** Keep for 4 weeks
- **Monthly backups:** Keep for 12 months
- **Annual backups:** Keep indefinitely

### 5.4 Disaster Recovery Plan

1. **Identify Critical Data:**
   - Student accounts
   - Exam data
   - Exam results
   - Historical records

2. **Recovery Steps:**
   - Assess damage
   - Restore from most recent backup
   - Verify data integrity
   - Notify stakeholders
   - Document incident

3. **Testing Recovery:**
   - Test backup restoration monthly
   - Document recovery time
   - Update recovery procedures based on tests

---

## 6. Monitoring and Maintenance

### 6.1 Firebase Crashlytics

- Monitor crash reports
- Prioritize critical crashes
- Fix crashes and deploy updates
- Track crash-free users percentage

### 6.2 Firebase Analytics

- Monitor user engagement
- Track feature usage
- Identify popular features
- Monitor performance metrics

### 6.3 Performance Monitoring

- Monitor app startup time
- Monitor screen load time
- Monitor network performance
- Identify performance bottlenecks

### 6.4 Error Tracking

- Monitor error rates
- Track error patterns
- Prioritize common errors
- Fix errors proactively

---

## 7. Update and Version Management

### 7.1 Version Numbering

Use semantic versioning: `MAJOR.MINOR.PATCH`

- **MAJOR:** Incompatible changes
- **MINOR:** New features, backward compatible
- **PATCH:** Bug fixes, backward compatible

### 7.2 Release Process

1. Update version in `pubspec.yaml`
2. Update version in `android/app/build.gradle.kts`
3. Update release notes
4. Build release APK/AAB
5. Test release build thoroughly
6. Deploy to testing environment
7. Get approval from stakeholders
8. Deploy to production

### 7.3 Rollback Plan

If critical issues are found after deployment:

1. Identify the issue
2. Assess impact
3. Decide on rollback vs. hotfix
4. If rollback:
   - Revert to previous version
   - Deploy previous version
   - Notify users
5. If hotfix:
   - Fix the issue
   - Build new version
   - Deploy hotfix
   - Notify users

---

## 8. Security Considerations

### 8.1 API Keys

- Never commit API keys to version control
- Use environment variables for sensitive data
- Rotate API keys periodically
- Monitor API key usage

### 8.2 User Data

- Encrypt sensitive data at rest
- Use HTTPS for all communications
- Implement proper authentication
- Follow data protection regulations (GDPR, etc.)

### 8.3 App Security

- Enable code obfuscation (ProGuard/R8)
- Use certificate pinning (optional)
- Implement certificate transparency
- Regular security audits

---

## 9. Troubleshooting

### 9.1 Build Issues

**Issue:** Build fails with signing error
**Solution:** Verify keystore configuration in key.properties

**Issue:** Build fails with dependency error
**Solution:** Run `flutter pub get` and check pubspec.yaml

**Issue:** APK/AAB size too large
**Solution:** Enable code shrinking and resource shrinking

### 9.2 Deployment Issues

**Issue:** Firebase deployment fails
**Solution:** Check Firebase CLI authentication and project configuration

**Issue:** Web deployment fails
**Solution:** Verify build output and hosting configuration

**Issue:** Play Store rejection
**Solution:** Review Play Console policies and fix issues

### 9.3 Runtime Issues

**Issue:** App crashes on startup
**Solution:** Check Firebase configuration and Crashlytics

**Issue:** Authentication fails
**Solution:** Verify Firebase Auth configuration and SHA-1 fingerprints

**Issue:** Database operations fail
**Solution:** Check Firestore security rules and indexes

---

## 10. Post-Deployment Checklist

- [ ] Android APK/AAB built successfully
- [ ] Web Admin deployed successfully
- [ ] Firebase production project configured
- [ ] Security rules deployed
- [ ] Database backup strategy implemented
- [ ] Monitoring configured (Crashlytics, Analytics)
- [ ] Release notes published
- [ ] User guides distributed
- [ ] Stakeholders notified
- [ ] Support documentation ready
- [ ] Rollback plan documented
- [ ] First users onboarded successfully

---

## Contact

For deployment issues or questions:
- **DevOps Team:** [devops@easyexam.com]
- **Development Team:** [dev@easyexam.com]
- **Firebase Support:** [Firebase Console Support]
