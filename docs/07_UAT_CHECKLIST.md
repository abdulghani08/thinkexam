# User Acceptance Testing (UAT) Checklist - Easy Exam

## Document Information
- **Project:** Easy Exam
- **Version:** 1.0.0
- **Purpose:** UAT Checklist for Phase 11 - Testing & Quality Assurance
- **Target Users:** Teachers (Admin), Students (6-12 years old)
- **Last Updated:** 2026

---

## UAT Overview

This checklist is designed to ensure the Easy Exam application meets the requirements specified in the Software Requirement Specification (SRS) and is ready for production deployment.

### UAT Participants
- **Product Owner:** [Name]
- **Teachers (Admin Users):** [Names]
- **Students:** [Names from different grades]
- **QA Team:** [Names]

### UAT Environment
- **Test Devices:**
  - Android devices (various screen sizes)
  - Web browsers (Chrome, Firefox, Safari, Edge)
- **Firebase Project:** [Project Name - Test Environment]
- **Test Data:**
  - Sample teachers: 3-5 accounts
  - Sample students: 20-30 accounts across different classes
  - Sample subjects: 5-10 subjects
  - Sample classes: 3-5 classes
  - Sample exams: 5-10 exams with various configurations

---

## 1. Authentication Module UAT

### 1.1 Teacher/Admin Sign-In
- [ ] Teacher can sign in with Google account
- [ ] Teacher is redirected to Admin Dashboard after successful sign-in
- [ ] Unauthorized Google account shows appropriate error message
- [ ] Sign-in works on different Android devices
- [ ] Sign-in works on web browsers
- [ ] Session persists after closing and reopening the app
- [ ] Teacher can sign out successfully
- [ ] After sign-out, user is redirected to login screen
- [ ] After sign-out, protected screens are inaccessible

### 1.2 Student Sign-In
- [ ] Student can sign in with Google account
- [ ] Student is redirected to Student Dashboard after successful sign-in
- [ ] Unauthorized Google account shows appropriate error message
- [ ] Sign-in works on different Android devices
- [ ] Session persists after closing and reopening the app
- [ ] Student can sign out successfully
- [ ] After sign-out, user is redirected to login screen

**UAT Result:** [Pass/Fail]
**Notes:** _______________________________________________________________________

---

## 2. Admin Module UAT

### 2.1 Dashboard
- [ ] Dashboard displays total number of exams
- [ ] Dashboard displays total number of students
- [ ] Dashboard displays total number of teachers
- [ ] Dashboard displays recent activity
- [ ] Dashboard shows exam statistics (average score, pass rate)
- [ ] Dashboard loads quickly (< 3 seconds)
- [ ] Dashboard is responsive on different screen sizes

### 2.2 Subject Management
- [ ] Teacher can create a new subject
- [ ] Subject name is required and validated
- [ ] Subject description is optional
- [ ] Created subject appears in the list
- [ ] Teacher can edit existing subject
- [ ] Teacher can delete subject (with confirmation)
- [ ] Subject cannot be deleted if used in exams
- [ ] Search/filter functionality works for subjects

### 2.3 Class Management
- [ ] Teacher can create a new class
- [ ] Class name is required and validated
- [ ] Grade is required and validated (1-6)
- [ ] Homeroom teacher assignment is optional
- [ ] Created class appears in the list
- [ ] Teacher can edit existing class
- [ ] Teacher can delete class (with confirmation)
- [ ] Class cannot be deleted if it has students
- [ ] Search/filter functionality works for classes

### 2.4 Student Management
- [ ] Teacher can create a new student
- [ ] Student full name is required and validated
- [ ] Student email is required and validated
- [ ] Student number is optional
- [ ] Class assignment is required
- [ ] Created student appears in the list
- [ ] Teacher can edit existing student
- [ ] Teacher can delete student (with confirmation)
- [ ] Teacher can move student to different class
- [ ] Import from Excel works correctly
- [ ] Import validates data and shows errors for invalid rows
- [ ] Export students to Excel works correctly
- [ ] Search/filter functionality works for students

### 2.5 Exam Management
- [ ] Teacher can create a new exam
- [ ] Exam title is required and validated
- [ ] Subject selection is required
- [ ] Class selection is required (at least one)
- [ ] Duration is required and validated (minimum 5 minutes)
- [ ] Passing grade is optional
- [ ] Exam is saved as draft by default
- [ ] Teacher can edit draft exam
- [ ] Teacher can delete draft exam (with confirmation)
- [ ] Teacher can duplicate existing exam
- [ ] Teacher can archive completed exam
- [ ] Search/filter functionality works for exams
- [ ] Exam status is correctly displayed (Draft, Published, Closed)

### 2.6 Question Builder
- [ ] Teacher can add questions to exam
- [ ] Question text is required and validated
- [ ] Question image upload works
- [ ] At least 2 answer options are required
- [ ] Correct answer must be selected
- [ ] Score can be set per question
- [ ] Question can be edited
- [ ] Question can be deleted
- [ ] Questions can be reordered
- [ ] Question types work correctly (Multiple Choice, True/False, Checkbox)
- [ ] Question explanation can be added
- [ ] Question preview works correctly
- [ ] Randomization settings can be configured

### 2.7 Exam Publication
- [ ] Teacher can publish draft exam
- [ ] Validation ensures exam has questions before publishing
- [ ] Start time can be set (optional)
- [ ] End time can be set (optional)
- [ ] Published exam becomes visible to students
- [ ] Published exam cannot be edited (only deactivated)
- [ ] Teacher can deactivate published exam
- [ ] Teacher can close completed exam

### 2.8 Exam Monitoring & Results
- [ ] Teacher can view active exam sessions
- [ ] Teacher can see which students are taking exam
- [ ] Teacher can view student progress
- [ ] Teacher can view submitted answers
- [ ] Automatic scoring works correctly
- [ ] Pass/fail status is calculated correctly
- [ ] Results are displayed accurately
- [ ] Question statistics are calculated correctly
- [ ] Export results to Excel works
- [ ] Export results to CSV works
- [ ] Export results to PDF works
- [ ] Print functionality works

### 2.9 Settings
- [ ] Teacher can configure academic year/semester
- [ ] Teacher can configure school profile
- [ ] Teacher can set default exam duration
- [ ] Teacher can set default passing grade
- [ ] Teacher can configure notification settings
- [ ] Teacher can enable/disable maintenance mode
- [ ] Settings are saved and persisted

**UAT Result:** [Pass/Fail]
**Notes:** _______________________________________________________________________

---

## 3. Student Module UAT

### 3.1 Student Dashboard
- [ ] Dashboard displays student profile information
- [ ] Dashboard displays class information
- [ ] Dashboard displays available exams
- [ ] Available exams are filtered by student's class
- [ ] Only published exams are shown
- [ ] Exam status is correctly displayed
- [ ] Upcoming exams show scheduled time
- [ ] Completed exams show results (if enabled)
- [ ] Dashboard has pull-to-refresh
- [ ] Real-time updates work (new exams appear)
- [ ] Offline indicator is shown when no internet

### 3.2 Exam Details
- [ ] Student can view exam details
- [ ] Exam instructions are displayed clearly
- [ ] Exam duration is displayed
- [ ] Exam schedule is displayed (if set)
- [ ] Student can see number of questions
- [ ] Student can see passing grade (if set)
- [ ] Start button is enabled when exam is available
- [ ] Start button is disabled when exam is not available

### 3.3 Exam Session
- [ ] Student can start exam
- [ ] Confirmation dialog appears before starting
- [ ] Timer starts counting down
- [ ] Timer is displayed prominently
- [ ] Low time warning appears (e.g., at 1 minute)
- [ ] Questions are displayed one per page
- [ ] Question number and total are shown
- [ ] Progress indicator is shown
- [ ] Answer options are clearly displayed
- [ ] Selected answer is highlighted
- [ ] Navigation buttons work (Next, Previous)
- [ ] Question sidebar/jump navigation works
- [ ] Question status indicators work (Answered, Unanswered, Flagged)
- [ ] Flag for review feature works
- [ ] Auto-save indicator appears after answering
- [ ] Answers can be changed before submission

### 3.4 Question Randomization
- [ ] Questions are randomized when enabled
- [ ] Answer options are randomized when enabled
- [ ] Randomized order is consistent during session
- [ ] Randomization is different per student

### 3.5 Auto-Save
- [ ] Answers are saved automatically
- [ ] Auto-save indicator appears
- [ ] Answers are saved during network interruption
- [ ] Local answers sync when network returns
- [ ] No data is lost during network interruption

### 3.6 Exam Submission
- [ ] Student can submit exam manually
- [ ] Submission summary shows question status
- [ ] Student can review before final submission
- [ ] Confirmation dialog appears before submission
- [ ] Submission processing indicator appears
- [ ] Success message appears after submission
- [ ] Results are displayed (if enabled)
- [ ] Score is calculated correctly
- [ ] Pass/fail status is shown
- [ ] Answer review is available (if enabled)

### 3.7 Auto-Submit
- [ ] Auto-submit occurs when timer reaches zero
- [ ] Current answers are submitted
- [ ] Auto-submit notification is shown
- [ ] Results are calculated after auto-submit

### 3.8 Session Recovery
- [ ] Session can be recovered after app crash
- [ ] Answers are preserved after recovery
- [ ] Timer is synchronized after recovery
- [ ] Student can continue from where left off
- [ ] No data is lost during recovery

### 3.9 Exam History
- [ ] Student can view completed exams
- [ ] History shows exam date and score
- [ ] Student can view detailed results
- [ ] Student can review answers (if enabled)
- [ ] Correct answers are shown (if enabled)
- [ ] Explanations are shown (if enabled)
- [ ] Filter functionality works for history

### 3.10 Profile
- [ ] Student can view profile information
- [ ] Profile shows name, email, class
- [ ] Profile shows photo (if available)
- [ ] Student can log out

**UAT Result:** [Pass/Fail]
**Notes:** _______________________________________________________________________

---

## 4. Security & Anti-Cheat UAT

### 4.1 Background Detection
- [ ] App detects when backgrounded during exam
- [ ] Warning message is displayed when returning
- [ ] Violation counter increments
- [ ] Warning shows remaining violations
- [ ] Multiple violations trigger auto-submit

### 4.2 Violation Threshold
- [ ] Auto-submit occurs at configured threshold
- [ ] Violation is logged in audit trail
- [ ] User is notified of auto-submit
- [ ] Threshold can be configured by admin

### 4.3 Orientation Lock
- [ ] Orientation is locked during exam (portrait)
- [ ] Orientation is unlocked after exam
- [ ] Rotation does not affect exam during session

### 4.4 Screenshot Prevention (Android)
- [ ] Screenshot is prevented (if device supports)
- [ ] Screenshot attempt is logged as violation
- [ ] Warning is shown for screenshot attempt

### 4.5 Session Integrity
- [ ] Session cannot be resumed on different device
- [ ] Session is tied to original device
- [ ] Device ID is verified on session recovery

**UAT Result:** [Pass/Fail]
**Notes:** _______________________________________________________________________

---

## 5. Performance UAT

### 5.1 Load Time
- [ ] App launches within 3 seconds
- [ ] Dashboard loads within 3 seconds
- [ ] Exam list loads within 3 seconds
- [ ] Exam starts within 3 seconds
- [ ] Questions load within 2 seconds

### 5.2 Navigation Performance
- [ ] Screen transitions are smooth
- [ ] No lag when navigating between questions
- [ ] No lag when opening menus
- [ ] No lag when loading lists

### 5.3 Concurrent Users
- [ ] System handles 10+ concurrent exam takers
- [ ] No data corruption with concurrent users
- [ ] Real-time updates work with concurrent users
- [ ] Auto-save works for all concurrent users

**UAT Result:** [Pass/Fail]
**Notes:** _______________________________________________________________________

---

## 6. UI/UX UAT

### 6.1 Design Consistency
- [ ] Material Design 3 is followed
- [ ] Colors are consistent across screens
- [ ] Typography is consistent
- [ ] Icons are consistent
- [ ] Buttons are consistent
- [ ] Forms are consistent

### 6.2 Mobile UI (Student)
- [ ] UI is simple and easy for children (6-12 years)
- [ ] Buttons are large enough for children
- [ ] Text is large enough for children
- [ ] Icons are understandable for children
- [ ] Navigation is simple
- [ ] Exam interface is distraction-free
- [ ] Timer is clearly visible
- [ ] Progress is clearly visible

### 6.3 Web UI (Admin)
- [ ] UI is efficient for teachers
- [ ] Sidebar navigation works
- [ ] Tables are scrollable
- [ ] Forms are easy to fill
- [ ] Bulk operations work
- [ ] Dashboard provides useful overview

### 6.4 Responsive Design
- [ ] Layout adapts to different screen sizes
- [ ] No overflow or clipping
- [ ] Text is readable on all sizes
- [ ] Touch targets are adequate
- [ ] Scroll works where needed

### 6.5 States
- [ ] Empty states are displayed appropriately
- [ ] Loading states are displayed appropriately
- [ ] Error states are displayed appropriately
- [ ] Success messages are shown for actions

### 6.6 Accessibility
- [ ] Color contrast meets WCAG AA standards
- [ ] Touch targets are at least 48x48
- [ ] Text is at least 14sp
- [ ] Important information is highlighted

**UAT Result:** [Pass/Fail]
**Notes:** _______________________________________________________________________

---

## 7. Network & Offline UAT

### 7.1 Online Mode
- [ ] All features work with internet
- [ ] Real-time updates work
- [ ] Firebase operations work
- [ ] Notifications work

### 7.2 Offline Mode
- [ ] App shows offline indicator
- [ ] App handles network errors gracefully
- [ ] Error messages are clear
- [ ] Retry functionality works

### 7.3 Network Interruption
- [ ] Exam answers are saved locally during interruption
- [ ] Answers sync when network returns
- [ ] No data is lost
- [ ] User can continue exam seamlessly

**UAT Result:** [Pass/Fail]
**Notes:** _______________________________________________________________________

---

## 8. Data Management UAT

### 8.1 Export
- [ ] Export to Excel works
- [ ] Export to CSV works
- [ ] Export to PDF works
- [ ] Exported data is accurate
- [ ] Exported data is formatted correctly

### 8.2 Import
- [ ] Import from Excel works
- [ ] Import validates data
- [ ] Import shows errors for invalid rows
- [ ] Import creates valid records
- [ ] Import summary is shown

### 8.3 Data Integrity
- [ ] No data loss during operations
- [ ] No data corruption
- [ ] Relationships are maintained
- [ ] Foreign keys are validated

**UAT Result:** [Pass/Fail]
**Notes:** _______________________________________________________________________

---

## 9. Cross-Platform UAT

### 9.1 Android
- [ ] App works on Android 8.0+
- [ ] App works on different screen sizes
- [ ] App works on different aspect ratios
- [ ] Permissions are handled correctly
- [ ] Notifications work on Android

### 9.2 Web
- [ ] App works on Chrome
- [ ] App works on Firefox
- [ ] App works on Safari
- [ ] App works on Edge
- [ ] Responsive design works on web

**UAT Result:** [Pass/Fail]
**Notes:** _______________________________________________________________________

---

## 10. Overall UAT Assessment

### 10.1 Functional Requirements
- [ ] All SRS functional requirements are met
- [ ] All business rules are implemented
- [ ] All user stories are completed

### 10.2 Non-Functional Requirements
- [ ] Performance requirements are met
- [ ] Security requirements are met
- [ ] Reliability requirements are met
- [ ] Usability requirements are met

### 10.3 User Satisfaction
- [ ] Teachers find the system easy to use
- [ ] Students find the system easy to use
- [ ] System meets user expectations
- [ ] System is ready for production

---

## UAT Sign-Off

### UAT Summary
- **Total Checklist Items:** [Count]
- **Passed:** [Count]
- **Failed:** [Count]
- **Blocked:** [Count]
- **Not Tested:** [Count]

### Overall UAT Result: [Pass/Fail]

### Critical Issues Found
1. [Issue description]
2. [Issue description]
3. [Issue description]

### Recommendations
1. [Recommendation]
2. [Recommendation]
3. [Recommendation]

### Go/No-Go Decision
- **Decision:** [GO / NO-GO / GO WITH CONDITIONS]

### Signatures
- **Product Owner:** ______________________ Date: _______
- **Teacher Representative:** ______________________ Date: _______
- **QA Lead:** ______________________ Date: _______

### UAT Execution Dates
- **Start Date:** [Date]
- **End Date:** [Date]

### Notes
___________________________________________________________________________
___________________________________________________________________________
___________________________________________________________________________
