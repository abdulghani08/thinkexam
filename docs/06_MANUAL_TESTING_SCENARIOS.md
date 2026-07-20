# Manual Testing Scenarios - Easy Exam

## Document Information
- **Project:** Easy Exam
- **Version:** 1.0.0
- **Purpose:** Manual testing scenarios for Phase 11 - Testing & Quality Assurance
- **Last Updated:** 2026

---

## 1. Authentication Module Testing

### 1.1 Google Sign-In - Admin/Teacher
**Test Case ID:** AUTH-001
**Priority:** High

**Preconditions:**
- App is installed on device
- Device has internet connection
- Google account is available on device

**Test Steps:**
1. Launch the app
2. Tap "Sign in with Google" button
3. Select Google account from list
4. Wait for authentication to complete
5. Verify role is checked against Firestore
6. Verify navigation to Admin Dashboard

**Expected Results:**
- Google sign-in dialog appears
- User can select account
- Authentication completes successfully
- If user is authorized (exists in teachers collection), navigate to Admin Dashboard
- If user is unauthorized, show error message

**Actual Results:** [To be filled]

**Status:** [Pass/Fail]

---

### 1.2 Google Sign-In - Student
**Test Case ID:** AUTH-002
**Priority:** High

**Preconditions:**
- App is installed on device
- Device has internet connection
- Google account is available on device

**Test Steps:**
1. Launch the app
2. Tap "Sign in with Google" button
3. Select Google account from list
4. Wait for authentication to complete
5. Verify role is checked against Firestore
6. Verify navigation to Student Dashboard

**Expected Results:**
- Google sign-in dialog appears
- User can select account
- Authentication completes successfully
- If user is authorized (exists in students collection), navigate to Student Dashboard
- If user is unauthorized, show error message

**Actual Results:** [To be filled]

**Status:** [Pass/Fail]

---

### 1.3 Unauthorized User Handling
**Test Case ID:** AUTH-003
**Priority:** High

**Preconditions:**
- User has Google account
- User is NOT registered in teachers or students collection

**Test Steps:**
1. Launch the app
2. Tap "Sign in with Google" button
3. Select Google account that is not in database
4. Wait for authentication to complete
5. Observe error message

**Expected Results:**
- Authentication with Google succeeds
- App checks Firestore for user role
- Error message displayed: "Account not authorized. Please contact your teacher."
- User is redirected to login screen

**Actual Results:** [To be filled]

**Status:** [Pass/Fail]

---

### 1.4 Sign Out
**Test Case ID:** AUTH-004
**Priority:** Medium

**Preconditions:**
- User is logged in

**Test Steps:**
1. Navigate to profile/settings
2. Tap "Sign Out" button
3. Confirm sign out
4. Verify session is cleared
5. Verify navigation to login screen

**Expected Results:**
- Sign out confirmation dialog appears
- After confirmation, user is signed out
- Session data is cleared from secure storage
- User is redirected to login screen
- User cannot access protected screens without re-authentication

**Actual Results:** [To be filled]

**Status:** [Pass/Fail]

---

### 1.5 Session Persistence
**Test Case ID:** AUTH-005
**Priority:** Medium

**Preconditions:**
- User is logged in

**Test Steps:**
1. Close the app completely
2. Reopen the app
3. Verify user is still logged in
4. Verify navigation to appropriate dashboard

**Expected Results:**
- App remembers user session
- User is automatically logged in
- User is navigated to appropriate dashboard (Admin or Student)

**Actual Results:** [To be filled]

**Status:** [Pass/Fail]

---

## 2. Admin Module Testing

### 2.1 Create Subject
**Test Case ID:** ADMIN-001
**Priority:** High

**Preconditions:**
- Admin is logged in
- Admin has access to Subject Management

**Test Steps:**
1. Navigate to Subjects page
2. Tap "Add Subject" button
3. Enter subject name (e.g., "Mathematics")
4. Enter description (optional)
5. Tap "Save"
6. Verify subject appears in list

**Expected Results:**
- Subject creation form opens
- Form validates required fields
- Subject is saved to Firestore
- Subject appears in subjects list
- Success message is displayed

**Actual Results:** [To be filled]

**Status:** [Pass/Fail]

---

### 2.2 Create Class
**Test Case ID:** ADMIN-002
**Priority:** High

**Preconditions:**
- Admin is logged in
- Admin has access to Class Management

**Test Steps:**
1. Navigate to Classes page
2. Tap "Add Class" button
3. Enter class name (e.g., "5A")
4. Select grade (e.g., 5)
5. Select homeroom teacher (optional)
6. Tap "Save"
7. Verify class appears in list

**Expected Results:**
- Class creation form opens
- Form validates required fields
- Class is saved to Firestore
- Class appears in classes list
- Success message is displayed

**Actual Results:** [To be filled]

**Status:** [Pass/Fail]

---

### 2.3 Create Student
**Test Case ID:** ADMIN-003
**Priority:** High

**Preconditions:**
- Admin is logged in
- Class exists in system

**Test Steps:**
1. Navigate to Students page
2. Tap "Add Student" button
3. Enter student full name
4. Enter student email
5. Enter student number (optional)
6. Select class
7. Tap "Save"
8. Verify student appears in list

**Expected Results:**
- Student creation form opens
- Form validates required fields
- Email format is validated
- Student is saved to Firestore
- Student appears in students list
- Success message is displayed

**Actual Results:** [To be filled]

**Status:** [Pass/Fail]

---

### 2.4 Import Students from Excel
**Test Case ID:** ADMIN-004
**Priority:** Medium

**Preconditions:**
- Admin is logged in
- Excel file with student data is available

**Test Steps:**
1. Navigate to Students page
2. Tap "Import" button
3. Select Excel file
4. Review imported data
5. Tap "Confirm Import"
6. Verify students are created

**Expected Results:**
- File picker opens
- Excel file is parsed correctly
- Data validation is performed
- Invalid rows are highlighted
- Valid students are imported
- Import summary is shown

**Actual Results:** [To be filled]

**Status:** [Pass/Fail]

---

### 2.5 Create Exam - Draft
**Test Case ID:** ADMIN-005
**Priority:** High

**Preconditions:**
- Admin is logged in
- Subject exists in system
- Classes exist in system

**Test Steps:**
1. Navigate to Exams page
2. Tap "Create Exam" button
3. Enter exam title
4. Select subject
5. Select allowed classes
6. Set duration (in minutes)
7. Set passing grade (optional)
7. Tap "Save as Draft"
8. Verify exam appears in draft list

**Expected Results:**
- Exam creation form opens
- Form validates required fields
- Duration is validated (minimum 5 minutes)
- Exam is saved with status "draft"
- Exam appears in drafts section
- Success message is displayed

**Actual Results:** [To be filled]

**Status:** [Pass/Fail]

---

### 2.6 Add Questions to Exam
**Test Case ID:** ADMIN-006
**Priority:** High

**Preconditions:**
- Exam exists in draft status

**Test Steps:**
1. Open draft exam
2. Tap "Add Question" button
3. Select question type (Multiple Choice)
4. Enter question text
5. Upload image (optional)
6. Add answer options (at least 2)
7. Select correct answer
8. Set score (default 1)
9. Tap "Save"
10. Repeat for multiple questions
11. Verify questions appear in list

**Expected Results:**
- Question creation form opens
- Form validates required fields
- At least 2 options are required
- Correct answer must be selected
- Question is saved to Firestore
- Question appears in exam questions list
- Questions can be reordered

**Actual Results:** [To be filled]

**Status:** [Pass/Fail]

---

### 2.7 Publish Exam
**Test Case ID:** ADMIN-007
**Priority:** High

**Preconditions:**
- Exam exists in draft status
- Exam has at least one question

**Test Steps:**
1. Open draft exam
2. Tap "Publish" button
3. Review exam details
4. Set start time (optional)
5. Set end time (optional)
6. Confirm publication
7. Verify exam status changes to "published"

**Expected Results:**
- Publication confirmation dialog appears
- Exam details are displayed for review
- Validation ensures questions exist
- Exam status changes to "published"
- Exam becomes visible to students in allowed classes
- Success message is displayed

**Actual Results:** [To be filled]

**Status:** [Pass/Fail]

---

### 2.8 View Exam Results
**Test Case ID:** ADMIN-008
**Priority:** High

**Preconditions:**
- Exam has been completed by students

**Test Steps:**
1. Navigate to Exams page
2. Open published exam
3. Tap "Results" tab
4. View student submissions
5. View individual student results
6. View question statistics
7. Export results (optional)

**Expected Results:**
- Results tab shows all student submissions
- Each submission shows score and status
- Individual results show detailed answers
- Question statistics show difficulty and distribution
- Export functionality works (Excel/CSV/PDF)

**Actual Results:** [To be filled]

**Status:** [Pass/Fail]

---

## 3. Student Module Testing

### 3.1 Student Dashboard
**Test Case ID:** STUDENT-001
**Priority:** High

**Preconditions:**
- Student is logged in
- Student is assigned to a class

**Test Steps:**
1. Navigate to Student Dashboard
2. Verify profile information is displayed
3. Verify class information is displayed
4. Verify available exams are listed
5. Verify exam status is shown
6. Verify upcoming exams are shown
7. Verify completed exams are shown

**Expected Results:**
- Student name, email, class are displayed
- Available exams are filtered by student's class
- Only published exams are shown
- Exam status is correctly displayed (Not Started, Available, In Progress, Completed)
- Upcoming exams show scheduled time
- Completed exams show results (if enabled)

**Actual Results:** [To be filled]

**Status:** [Pass/Fail]

---

### 3.2 Start Exam
**Test Case ID:** STUDENT-002
**Priority:** High

**Preconditions:**
- Student is logged in
- Exam is available for student's class
- Exam is published
- Current time is within exam schedule (if set)

**Test Steps:**
1. Navigate to Dashboard
2. Tap on available exam
3. View exam instructions
4. Tap "Start Exam"
5. Confirm start
6. Verify exam session is created
7. Verify timer starts
8. Verify first question is displayed

**Expected Results:**
- Exam details page shows instructions
- Start button is enabled
- Confirmation dialog appears
- After confirmation, exam session is created in Firestore
- Timer starts counting down
- First question is displayed
- Navigation controls are available

**Actual Results:** [To be filled]

**Status:** [Pass/Fail]

---

### 3.3 Answer Questions
**Test Case ID:** STUDENT-003
**Priority:** High

**Preconditions:**
- Exam session is active

**Test Steps:**
1. Read question
2. Select answer
3. Tap "Next" button
4. Answer next question
5. Navigate back to previous question
6. Change answer
7. Navigate to specific question via sidebar
8. Flag question for review

**Expected Results:**
- Question is displayed clearly
- Answer options are clickable
- Selected answer is highlighted
- Navigation works (Next, Previous, Jump)
- Answers can be changed before submission
- Question status indicators work (Answered, Unanswered, Flagged)
- Auto-save indicator appears after answering

**Actual Results:** [To be filled]

**Status:** [Pass/Fail]

---

### 3.4 Auto-Save Functionality
**Test Case ID:** STUDENT-004
**Priority:** High

**Preconditions:**
- Exam session is active

**Test Steps:**
1. Answer a question
2. Wait for auto-save (observe indicator)
3. Simulate network disconnection
4. Answer another question
5. Reconnect network
6. Verify answers are synced

**Expected Results:**
- Auto-save indicator appears after answering
- Answer is saved to Firestore
- During network disconnection, answer is saved locally
- Upon reconnection, local answers sync to Firestore
- No data is lost

**Actual Results:** [To be filled]

**Status:** [Pass/Fail]

---

### 3.5 Submit Exam
**Test Case ID:** STUDENT-005
**Priority:** High

**Preconditions:**
- Exam session is active
- At least one question is answered

**Test Steps:**
1. Navigate to last question or tap "Submit"
2. Review summary (answered, unanswered, flagged)
3. Navigate back to unanswered questions (optional)
4. Tap "Submit" button
5. Confirm submission
6. Wait for processing
7. View results (if enabled)

**Expected Results:**
- Submission summary shows question status
- User can review before final submission
- Confirmation dialog appears
- After confirmation, exam is submitted
- Session status changes to "completed"
- Results are calculated
- Results are displayed (if showResult is enabled)

**Actual Results:** [To be filled]

**Status:** [Pass/Fail]

---

### 3.6 Auto-Submit on Time Expiry
**Test Case ID:** STUDENT-006
**Priority:** High

**Preconditions:**
- Exam session is active
- Timer is set to short duration for testing

**Test Steps:**
1. Start exam with short duration (e.g., 1 minute)
2. Answer some questions
3. Wait for timer to reach 0
4. Verify auto-submit occurs
5. Verify results are calculated

**Expected Results:**
- Timer counts down correctly
- Low time warning appears (e.g., at 1 minute)
- When timer reaches 0, auto-submit triggers
- Current answers are submitted
- Session status changes to "completed"
- Results are calculated
- User is notified of auto-submit

**Actual Results:** [To be filled]

**Status:** [Pass/Fail]

---

### 3.7 View Exam History
**Test Case ID:** STUDENT-007
**Priority:** Medium

**Preconditions:**
- Student has completed at least one exam

**Test Steps:**
1. Navigate to History tab
2. View list of completed exams
3. Tap on a completed exam
4. View exam details
5. View score and answers (if enabled)

**Expected Results:**
- History shows all completed exams
- Each exam shows date, score, status
- Tapping exam shows detailed results
- Answers can be reviewed (if enabled by admin)
- Correct answers are shown (if enabled by admin)

**Actual Results:** [To be filled]

**Status:** [Pass/Fail]

---

## 4. Security & Anti-Cheat Testing

### 4.1 Background Detection
**Test Case ID:** SECURITY-001
**Priority:** High

**Preconditions:**
- Exam session is active

**Test Steps:**
1. Start an exam
2. Answer a question
3. Minimize the app (press home button)
4. Wait for detection
5. Return to app
6. Verify warning message
7. Verify violation counter incremented

**Expected Results:**
- App detects when it goes to background
- Warning message is displayed when returning
- Violation counter increments
- Warning shows remaining violations before auto-submit
- Exam session continues if threshold not reached

**Actual Results:** [To be filled]

**Status:** [Pass/Fail]

---

### 4.2 Violation Threshold Auto-Submit
**Test Case ID:** SECURITY-002
**Priority:** High

**Preconditions:**
- Exam session is active
- Violation threshold is set (e.g., 3 violations)

**Test Steps:**
1. Start an exam
2. Trigger violations (background app multiple times)
3. Reach violation threshold
4. Verify auto-submit occurs
5. Verify violation is logged

**Expected Results:**
- Each violation increments counter
- Warning appears before threshold
- When threshold is reached, auto-submit triggers
- Current answers are submitted
- Violation is logged in audit trail
- User is notified of auto-submit due to violations

**Actual Results:** [To be filled]

**Status:** [Pass/Fail]

---

### 4.3 Orientation Lock
**Test Case ID:** SECURITY-003
**Priority:** Medium

**Preconditions:**
- Exam session is active
- Device supports rotation

**Test Steps:**
1. Start an exam
2. Rotate device
3. Verify orientation remains locked
4. Complete exam
5. Exit exam
6. Verify orientation is unlocked

**Expected Results:**
- During exam, orientation is locked (portrait)
- Rotation does not change orientation
- After exam, orientation is unlocked
- Normal rotation behavior resumes

**Actual Results:** [To be filled]

**Status:** [Pass/Fail]

---

### 4.4 Screenshot Prevention (Android)
**Test Case ID:** SECURITY-004
**Priority:** Medium

**Preconditions:**
- Exam session is active
- Device is Android

**Test Steps:**
1. Start an exam
2. Attempt to take screenshot
3. Verify screenshot is prevented or logged
4. Check if violation is triggered

**Expected Results:**
- Screenshot is prevented (if supported by device)
- If screenshot succeeds, violation is detected
- Violation counter increments
- Warning message is displayed

**Actual Results:** [To be filled]

**Status:** [Pass/Fail]

---

### 4.5 Session Recovery After Interruption
**Test Case ID:** SECURITY-005
**Priority:** High

**Preconditions:**
- Exam session is active

**Test Steps:**
1. Start an exam
2. Answer several questions
3. Force close the app (kill process)
4. Reopen the app
5. Verify session recovery
6. Verify answers are preserved
7. Verify timer is synchronized

**Expected Results:**
- App detects existing session
- Session is recovered from local storage
- Answers are preserved
- Timer is synchronized with server
- User can continue from where left off
- No data is lost

**Actual Results:** [To be filled]

**Status:** [Pass/Fail]

---

## 5. Performance Testing

### 5.1 Exam Loading Performance
**Test Case ID:** PERF-001
**Priority:** Medium

**Preconditions:**
- Exam exists with 50+ questions

**Test Steps:**
1. Start exam
2. Measure time to load all questions
3. Measure time to render first question
4. Navigate through all questions
5. Measure navigation performance

**Expected Results:**
- Questions load within 3 seconds
- First question renders within 1 second
- Navigation between questions is smooth (< 500ms)
- No lag or stuttering

**Actual Results:** [To be filled]

**Status:** [Pass/Fail]

---

### 5.2 Multiple Concurrent Users
**Test Case ID:** PERF-002
**Priority:** Medium

**Preconditions:**
- Multiple test devices available
- Exam is published

**Test Steps:**
1. Have 10+ students start the same exam simultaneously
2. Monitor Firestore performance
3. Verify all students can start without issues
4. Verify auto-save works for all users
5. Verify submission works for all users

**Expected Results:**
- All students can start exam successfully
- Firestore handles concurrent writes
- No data corruption occurs
- All students can submit successfully
- Results are calculated correctly for all

**Actual Results:** [To be filled]

**Status:** [Pass/Fail]

---

## 6. Network Testing

### 6.1 Offline Mode - Exam Start
**Test Case ID:** NET-001
**Priority:** Medium

**Preconditions:**
- Device supports offline mode
- Exam is available

**Test Steps:**
1. Enable airplane mode
2. Try to start exam
3. Verify error message
4. Disable airplane mode
5. Start exam successfully

**Expected Results:**
- Offline error message is displayed
- User is informed that internet is required
- App gracefully handles network unavailability

**Actual Results:** [To be filled]

**Status:** [Pass/Fail]

---

### 6.2 Network Interruption During Exam
**Test Case ID:** NET-002
**Priority:** High

**Preconditions:**
- Exam session is active

**Test Steps:**
1. Start exam
2. Answer a question
3. Enable airplane mode
4. Answer another question
5. Disable airplane mode
6. Verify answers sync

**Expected Results:**
- Answer is saved locally when offline
- Auto-save indicator shows local save
- When network returns, answers sync to Firestore
- No data is lost
- User can continue exam seamlessly

**Actual Results:** [To be filled]

**Status:** [Pass/Fail]

---

## 7. UI/UX Testing

### 7.1 Responsive Design - Mobile
**Test Case ID:** UI-001
**Priority:** Medium

**Preconditions:**
- App is running on mobile device

**Test Steps:**
1. Navigate through all screens
2. Verify layout adapts to screen size
3. Verify text is readable
4. Verify buttons are tappable
5. Verify scroll works where needed

**Expected Results:**
- Layout fits screen properly
- No overflow or clipping
- Text is readable (minimum 14sp)
- Touch targets are at least 48x48
- Scroll works smoothly

**Actual Results:** [To be filled]

**Status:** [Pass/Fail]

---

### 7.2 Responsive Design - Web Admin
**Test Case ID:** UI-002
**Priority:** Medium

**Preconditions:**
- App is running on web browser

**Test Steps:**
1. Open Admin Dashboard in browser
2. Resize browser window
3. Verify layout adapts
4. Test on different screen sizes (desktop, tablet)
5. Verify all features work

**Expected Results:**
- Layout adapts to different screen sizes
- Sidebar works correctly
- Tables are scrollable on small screens
- All features are accessible
- No layout breaks

**Actual Results:** [To be filled]

**Status:** [Pass/Fail]

---

### 7.3 Empty States
**Test Case ID:** UI-003
**Priority:** Low

**Preconditions:**
- Various lists are empty

**Test Steps:**
1. Navigate to Subjects (empty)
2. Navigate to Classes (empty)
3. Navigate to Students (empty)
4. Navigate to Exams (empty)
5. Verify empty states are displayed

**Expected Results:**
- Empty state widget is displayed
- Appropriate icon is shown
- Descriptive message is shown
- Action button is shown (if applicable)

**Actual Results:** [To be filled]

**Status:** [Pass/Fail]

---

### 7.4 Error States
**Test Case ID:** UI-004
**Priority:** Low

**Preconditions:**
- Simulate various errors

**Test Steps:**
1. Simulate network error
2. Simulate server error
3. Simulate validation error
4. Verify error messages are displayed

**Expected Results:**
- Error state widget is displayed
- Appropriate error message is shown
- Retry button is shown (if applicable)
- User can recover from error

**Actual Results:** [To be filled]

**Status:** [Pass/Fail]

---

## 8. Data Validation Testing

### 8.1 Email Validation
**Test Case ID:** VAL-001
**Priority:** Medium

**Test Steps:**
1. Enter invalid email format
2. Enter empty email
3. Enter valid email
4. Verify validation messages

**Expected Results:**
- Invalid email shows error
- Empty email shows required error
- Valid email passes validation

**Actual Results:** [To be filled]

**Status:** [Pass/Fail]

---

### 8.2 Required Field Validation
**Test Case ID:** VAL-002
**Priority:** Medium

**Test Steps:**
1. Submit form with empty required fields
2. Verify validation errors
3. Fill required fields
4. Submit successfully

**Expected Results:**
- Empty required fields show errors
- Form cannot be submitted with errors
- Filled fields pass validation

**Actual Results:** [To be filled]

**Status:** [Pass/Fail]

---

## 9. Export/Import Testing

### 9.1 Export Results to Excel
**Test Case ID:** EXPORT-001
**Priority:** Medium

**Preconditions:**
- Exam has results

**Test Steps:**
1. Navigate to exam results
2. Tap "Export to Excel"
3. Verify file is downloaded
4. Open Excel file
5. Verify data is correct

**Expected Results:**
- Excel file is generated
- File contains all results
- Data is formatted correctly
- File can be opened in Excel

**Actual Results:** [To be filled]

**Status:** [Pass/Fail]

---

### 9.2 Import Students from Excel
**Test Case ID:** IMPORT-001
**Priority:** Medium

**Preconditions:**
- Excel file with student data exists

**Test Steps:**
1. Navigate to Students page
2. Tap "Import"
3. Select Excel file
4. Review data
5. Confirm import
6. Verify students are created

**Expected Results:**
- Excel file is parsed
- Data is validated
- Invalid rows are highlighted
- Valid students are imported
- Import summary is shown

**Actual Results:** [To be filled]

**Status:** [Pass/Fail]

---

## 10. Accessibility Testing

### 10.1 Color Contrast
**Test Case ID:** A11Y-001
**Priority:** Low

**Test Steps:**
1. Review all screens
2. Check color contrast ratios
3. Verify text is readable

**Expected Results:**
- Color contrast meets WCAG AA standards
- Text is readable for all users
- Important information is highlighted

**Actual Results:** [To be filled]

**Status:** [Pass/Fail]

---

### 10.2 Touch Target Size
**Test Case ID:** A11Y-002
**Priority:** Low

**Test Steps:**
1. Measure button sizes
2. Measure touch targets
3. Verify minimum size

**Expected Results:**
- Touch targets are at least 48x48
- Buttons are easily tappable
- No targets are too small

**Actual Results:** [To be filled]

**Status:** [Pass/Fail]

---

## Test Summary

### Total Test Cases: [Count]
### Passed: [Count]
### Failed: [Count]
### Blocked: [Count]
### Not Executed: [Count]

### Overall Status: [Pass/Fail]

### Notes:
- [Add any notes about testing environment, issues found, etc.]

### Testers:
- [Tester Name 1]
- [Tester Name 2]

### Test Execution Date:
- Start: [Date]
- End: [Date]
