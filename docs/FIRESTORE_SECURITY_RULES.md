# Firestore Security Rules

This document defines the Firestore security rules for the Easy Exam application.

## Security Principles

1. **Authentication Required**: All write operations require user authentication
2. **Role-Based Access Control**: Access based on user roles (ADMIN, STUDENT)
3. **Data Ownership**: Users can only access data they own or are authorized to access
4. **Validation**: All data must be validated before write operations
5. **Least Privilege**: Grant minimum necessary permissions

## Complete Security Rules

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    
    // Helper function to check if user is admin
    function isAdmin() {
      return get(/databases/$(database)/documents/teachers/$(request.auth.uid)).data.role == 'ADMIN';
    }
    
    // Helper function to check if user owns the document
    function isOwner(userId) {
      return request.auth.uid == userId;
    }
    
    // Teachers collection
    match /teachers/{teacherId} {
      allow read: if request.auth != null && (isOwner(teacherId) || isAdmin());
      allow write: if request.auth != null && (isOwner(teacherId) || isAdmin());
    }
    
    // Students collection
    match /students/{studentId} {
      allow read: if request.auth != null && 
        (isOwner(studentId) || isAdmin() ||
         get(/databases/$(database)/documents/teachers/$(request.auth.uid)).data.classId == resource.data.classId);
      allow write: if request.auth != null && (isOwner(studentId) || isAdmin());
    }
    
    // Classes collection
    match /classes/{classId} {
      allow read: if request.auth != null;
      allow write: if request.auth != null && isAdmin();
    }
    
    // Subjects collection
    match /subjects/{subjectId} {
      allow read: if request.auth != null;
      allow write: if request.auth != null && isAdmin();
    }
    
    // Exams collection
    match /exams/{examId} {
      allow read: if request.auth != null && 
        (resource.data.teacherId == request.auth.uid || isAdmin() ||
         (get(/databases/$(database)/documents/students/$(request.auth.uid)).data.classId in resource.data.allowedClasses &&
          resource.data.status == 'published'));
      allow create: if request.auth != null && isAdmin() && request.resource.data.teacherId == request.auth.uid;
      allow update: if request.auth != null && (resource.data.teacherId == request.auth.uid || isAdmin());
      allow delete: if request.auth != null && (resource.data.teacherId == request.auth.uid || isAdmin());
    }
    
    // Questions collection
    match /questions/{questionId} {
      allow read: if request.auth != null && 
        (get(/databases/$(database)/documents/exams/$(resource.data.examId)).data.teacherId == request.auth.uid || 
         isAdmin() ||
         (get(/databases/$(database)/documents/students/$(request.auth.uid)).data.classId in 
         get(/databases/$(database)/documents/exams/$(resource.data.examId)).data.allowedClasses &&
         get(/databases/$(database)/documents/exams/$(resource.data.examId)).data.status == 'published'));
      allow write: if request.auth != null && 
        get(/databases/$(database)/documents/exams/$(resource.data.examId)).data.teacherId == request.auth.uid;
    }
    
    // Exam sessions collection
    match /examSessions/{sessionId} {
      allow read: if request.auth != null && 
        (resource.data.studentId == request.auth.uid || isAdmin() ||
         get(/databases/$(database)/documents/exams/$(resource.data.examId)).data.teacherId == request.auth.uid);
      allow create: if request.auth != null && request.resource.data.studentId == request.auth.uid;
      allow update: if request.auth != null && 
        (resource.data.studentId == request.auth.uid || 
         get(/databases/$(database)/documents/exams/$(resource.data.examId)).data.teacherId == request.auth.uid);
    }
    
    // Exam answers collection
    match /examAnswers/{answerId} {
      allow read: if request.auth != null && 
        (resource.data.studentId == request.auth.uid || isAdmin() ||
         get(/databases/$(database)/documents/exams/$(resource.data.examId)).data.teacherId == request.auth.uid);
      allow create: if request.auth != null && request.resource.data.studentId == request.auth.uid;
      allow update: if request.auth != null && resource.data.studentId == request.auth.uid;
    }
    
    // Exam results collection
    match /examResults/{resultId} {
      allow read: if request.auth != null && 
        (resource.data.studentId == request.auth.uid || isAdmin() ||
         get(/databases/$(database)/documents/exams/$(resource.data.examId)).data.teacherId == request.auth.uid);
      allow write: if request.auth != null && isAdmin();
    }
    
    // Notifications collection
    match /notifications/{notificationId} {
      allow read: if request.auth != null && 
        (resource.data.userId == request.auth.uid || isAdmin());
      allow write: if request.auth != null && isAdmin();
    }
    
    // App settings collection
    match /appSettings/{settingId} {
      allow read: if request.auth != null;
      allow write: if request.auth != null && isAdmin();
    }
  }
}
```

## How to Apply Rules

1. Go to Firebase Console → Firestore Database → Rules
2. Copy the complete security rules above
3. Paste into the rules editor
4. Click "Publish"

## Testing Rules

Use the Firebase Console Rules Simulator to test rules before publishing:
1. Click "Rules Simulator" in the Rules tab
2. Select collection and document
3. Choose operation type (get, list, create, update, delete)
4. Set authentication status and user attributes
5. Click "Run" to test

## Important Notes

- These rules assume user role is stored in the `teachers` collection
- For production, consider adding additional validation rules
- Review and update rules as application requirements evolve
- Always test rules in the simulator before publishing
