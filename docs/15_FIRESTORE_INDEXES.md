# Firestore Indexes Requirements

## Overview
This document lists all Firestore composite indexes required for the Easy Exam application to function properly in production.

## Required Composite Indexes

### 1. Exams Collection

#### Index: Status + CreatedAt (Descending)
- **Collection:** `exams`
- **Fields:** 
  - `status` (Ascending)
  - `createdAt` (Descending)
- **Query:** `orderBy('createdAt', descending: true).where('status', isEqualTo: status)`
- **Location:** `lib/data/datasources/firestore_exam_datasource.dart` (Lines 200-204)
- **Usage:** Filtering exams by status with chronological ordering

---

### 2. Exam Sessions Collection

#### Index: StudentId + CreatedAt (Descending)
- **Collection:** `exam_sessions`
- **Fields:**
  - `studentId` (Ascending)
  - `createdAt` (Descending)
- **Query:** `where('studentId', isEqualTo: studentId).orderBy('createdAt', descending: true)`
- **Location:** `lib/data/datasources/firestore_exam_session_datasource.dart` (Lines 68-72)
- **Usage:** Getting exam sessions for a specific student

#### Index: ExamId + CreatedAt (Descending)
- **Collection:** `exam_sessions`
- **Fields:**
  - `examId` (Ascending)
  - `createdAt` (Descending)
- **Query:** `where('examId', isEqualTo: examId).orderBy('createdAt', descending: true)`
- **Location:** `lib/data/datasources/firestore_exam_session_datasource.dart` (Lines 85-89)
- **Usage:** Getting exam sessions for a specific exam

---

### 3. Students Collection

#### Index: ClassId + IsActive + FullName
- **Collection:** `students`
- **Fields:**
  - `classId` (Ascending)
  - `isActive` (Ascending)
  - `fullName` (Ascending)
- **Query:** `where('classId', isEqualTo: classId).where('isActive', isEqualTo: true).orderBy('fullName')`
- **Location:** `lib/data/datasources/firestore_student_datasource.dart` (Lines 57-60)
- **Usage:** Getting active students in a specific class, ordered by name

#### Index: ClassId + FullName
- **Collection:** `students`
- **Fields:**
  - `classId` (Ascending)
  - `fullName` (Ascending)
- **Query:** `orderBy('fullName').where('classId', isEqualTo: classId)`
- **Location:** `lib/data/datasources/firestore_student_datasource.dart` (Lines 121-125)
- **Usage:** Searching students within a specific class

---

### 4. Questions Collection

#### Index: ExamId + Order
- **Collection:** `questions`
- **Fields:**
  - `examId` (Ascending)
  - `order` (Ascending)
- **Query:** `where('examId', isEqualTo: examId).orderBy('order')`
- **Location:** `lib/data/datasources/firestore_question_datasource.dart` (Lines 39-42)
- **Usage:** Getting questions for a specific exam in order

---

## How to Create Indexes

### Method 1: Firebase Console (Recommended)
1. Go to [Firebase Console](https://console.firebase.google.com)
2. Select your project
3. Navigate to **Firestore Database** → **Indexes**
4. Click **Add Index**
5. For each index above:
   - Select the collection
   - Add fields in the exact order specified
   - Set the sort order (Ascending/Descending)
   - Click **Create**

### Method 2: Automatic Index Creation
When you run the app in development mode and encounter an index error, Firebase will provide a direct link to create the required index automatically.

### Method 3: Firestore Indexes Definition File
Create a `firestore.indexes.json` file in the project root:

```json
{
  "indexes": [
    {
      "collectionGroup": "exams",
      "queryScope": "COLLECTION",
      "fields": [
        {
          "fieldPath": "status",
          "order": "ASCENDING"
        },
        {
          "fieldPath": "createdAt",
          "order": "DESCENDING"
        }
      ]
    },
    {
      "collectionGroup": "exam_sessions",
      "queryScope": "COLLECTION",
      "fields": [
        {
          "fieldPath": "studentId",
          "order": "ASCENDING"
        },
        {
          "fieldPath": "createdAt",
          "order": "DESCENDING"
        }
      ]
    },
    {
      "collectionGroup": "exam_sessions",
      "queryScope": "COLLECTION",
      "fields": [
        {
          "fieldPath": "examId",
          "order": "ASCENDING"
        },
        {
          "fieldPath": "createdAt",
          "order": "DESCENDING"
        }
      ]
    },
    {
      "collectionGroup": "students",
      "queryScope": "COLLECTION",
      "fields": [
        {
          "fieldPath": "classId",
          "order": "ASCENDING"
        },
        {
          "fieldPath": "isActive",
          "order": "ASCENDING"
        },
        {
          "fieldPath": "fullName",
          "order": "ASCENDING"
        }
      ]
    },
    {
      "collectionGroup": "students",
      "queryScope": "COLLECTION",
      "fields": [
        {
          "fieldPath": "classId",
          "order": "ASCENDING"
        },
        {
          "fieldPath": "fullName",
          "order": "ASCENDING"
        }
      ]
    },
    {
      "collectionGroup": "questions",
      "queryScope": "COLLECTION",
      "fields": [
        {
          "fieldPath": "examId",
          "order": "ASCENDING"
        },
        {
          "fieldPath": "order",
          "order": "ASCENDING"
        }
      ]
    }
  ]
}
```

Then deploy with:
```bash
firebase deploy --only firestore:indexes
```

---

## Testing Indexes

After creating indexes, test the following scenarios:

1. **Admin Dashboard:** Load exams filtered by status
2. **Student Dashboard:** Load student's exam history
3. **Teacher Dashboard:** Load students in a class
4. **Exam Taking:** Load questions for an exam in order
5. **Results View:** Load exam sessions for a specific exam

If queries fail with index errors, check the Firebase Console error logs for the exact index configuration needed.

---

## Single Field Indexes

The following single field indexes are automatically created by Firestore and do not need manual configuration:
- `exams.createdAt`
- `exams.status`
- `exam_sessions.studentId`
- `exam_sessions.examId`
- `exam_sessions.createdAt`
- `students.classId`
- `students.isActive`
- `students.fullName`
- `questions.examId`
- `questions.order`

---

## Index Cost Considerations

- Composite indexes increase write latency slightly
- Each composite index adds storage cost
- Only create indexes that are actually used
- Monitor index usage in Firebase Console
- Remove unused indexes to reduce costs

---

## Maintenance

- Review index usage quarterly
- Remove unused indexes
- Update this document when adding new queries
- Test new queries in development before production

---

**Last Updated:** July 2026
**Document Version:** 1.0
