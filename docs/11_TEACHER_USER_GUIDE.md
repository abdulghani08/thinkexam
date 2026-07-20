# Teacher User Guide - Easy Exam

## Document Information
- **Project:** Easy Exam
- **Version:** 1.0.0
- **Target Audience:** Teachers / Administrators
- **Purpose:** Comprehensive user guide for teachers using the Easy Exam platform
- **Last Updated:** 2026

---

## Table of Contents

1. [Getting Started](#1-getting-started)
2. [Dashboard Overview](#2-dashboard-overview)
3. [Subject Management](#3-subject-management)
4. [Class Management](#4-class-management)
5. [Student Management](#6-student-management)
6. [Exam Management](#7-exam-management)
7. [Question Builder](#8-question-builder)
8. [Exam Publishing](#9-exam-publishing)
9. [Monitoring Exams](#10-monitoring-exams)
10. [Results & Analytics](#11-results--analytics)
11. [Settings](#12-settings)
12. [Troubleshooting](#13-troubleshooting)

---

## 1. Getting Started

### 1.1 System Requirements

**For Web Admin Dashboard:**
- Modern web browser (Chrome, Firefox, Safari, Edge)
- Stable internet connection
- Screen resolution: 1280x720 or higher recommended

### 1.2 First-Time Setup

#### Step 1: Sign In
1. Open your browser and navigate to the Easy Exam URL
2. Click "Sign in with Google"
3. Select your Google account
4. Wait for authorization (your account must be registered by school administrator)

#### Step 2: Complete Profile (if required)
1. Fill in your full name
2. Verify your email address
3. Upload profile photo (optional)

#### Step 3: Initial Configuration
1. Create subjects (see Section 3)
2. Create classes (see Section 4)
3. Add students (see Section 5)
4. Configure settings (see Section 12)

---

## 2. Dashboard Overview

### 2.1 Dashboard Components

The dashboard provides a quick overview of your Easy Exam system:

**Statistics Cards:**
- Total Exams: Number of exams in the system
- Total Students: Number of registered students
- Total Teachers: Number of teachers in the system
- Active Exams: Number of currently active exams

**Recent Activity:**
- Shows recent exam creations
- Shows recent student submissions
- Shows recent system changes

**Exam Statistics:**
- Average score across all exams
- Pass rate percentage
- Most recent exam performance

### 2.2 Navigation Menu

The sidebar provides access to all features:

- **Dashboard:** Home page with overview
- **Subjects:** Manage subjects
- **Classes:** Manage classes
- **Students:** Manage students
- **Exams:** Create and manage exams
- **Questions:** Question bank
- **Results:** View exam results
- **Settings:** System configuration

---

## 3. Subject Management

### 3.1 Creating a Subject

1. Navigate to **Subjects** from the sidebar
2. Click **"Add Subject"** button
3. Fill in the form:
   - **Subject Name:** Required (e.g., "Mathematics", "Science")
   - **Description:** Optional (e.g., "Math for Grade 5")
4. Click **"Save"**

### 3.2 Editing a Subject

1. Navigate to **Subjects**
2. Find the subject you want to edit
3. Click the **edit icon** (pencil)
4. Modify the information
5. Click **"Save"**

### 3.3 Deleting a Subject

1. Navigate to **Subjects**
2. Find the subject you want to delete
3. Click the **delete icon** (trash)
4. Confirm deletion
5. **Note:** You cannot delete subjects that are used in exams

### 3.4 Searching Subjects

1. Navigate to **Subjects**
2. Use the search bar at the top
3. Type subject name or description
4. Results will filter in real-time

---

## 4. Class Management

### 4.1 Creating a Class

1. Navigate to **Classes** from the sidebar
2. Click **"Add Class"** button
3. Fill in the form:
   - **Class Name:** Required (e.g., "5A", "6B")
   - **Grade:** Required (1-6)
   - **Homeroom Teacher:** Optional (select from list)
4. Click **"Save"**

### 4.2 Editing a Class

1. Navigate to **Classes**
2. Find the class you want to edit
3. Click the **edit icon** (pencil)
4. Modify the information
5. Click **"Save"**

### 4.3 Deleting a Class

1. Navigate to **Classes**
2. Find the class you want to delete
3. Click the **delete icon** (trash)
4. Confirm deletion
5. **Note:** You cannot delete classes that have students assigned

### 4.4 Viewing Class Details

1. Navigate to **Classes**
2. Click on a class name
3. View class information and assigned students

---

## 5. Student Management

### 5.1 Adding a Single Student

1. Navigate to **Students** from the sidebar
2. Click **"Add Student"** button
3. Fill in the form:
   - **Full Name:** Required (e.g., "John Doe")
   - **Email:** Required (student's Google account email)
   - **Student Number:** Optional (e.g., "NIS-12345")
   - **Class:** Required (select from dropdown)
4. Click **"Save"**

### 5.2 Importing Students from Excel

#### Preparing Excel File
Create an Excel file with the following columns:
- Full Name (required)
- Email (required)
- Student Number (optional)
- Class Name (required)

Example:
| Full Name | Email | Student Number | Class Name |
|-----------|-------|----------------|------------|
| John Doe | john.doe@school.com | NIS-001 | 5A |
| Jane Smith | jane.smith@school.com | NIS-002 | 5A |

#### Import Process
1. Navigate to **Students**
2. Click **"Import"** button
3. Select your Excel file
4. Review the imported data
5. Fix any errors (highlighted in red)
6. Click **"Confirm Import"**

### 5.3 Editing a Student

1. Navigate to **Students**
2. Find the student you want to edit
3. Click the **edit icon** (pencil)
4. Modify the information
5. Click **"Save"**

### 5.4 Deleting a Student

1. Navigate to **Students**
2. Find the student you want to delete
3. Click the **delete icon** (trash)
4. Confirm deletion
5. **Note:** Deleting a student will also delete their exam history

### 5.5 Moving a Student to Different Class

1. Navigate to **Students**
2. Find the student you want to move
3. Click the **edit icon** (pencil)
4. Change the **Class** selection
5. Click **"Save"**

### 5.6 Exporting Students

1. Navigate to **Students**
2. Click **"Export"** button
3. Choose format (Excel, CSV)
4. File will be downloaded

### 5.7 Searching Students

1. Navigate to **Students**
2. Use the search bar
3. Type name, email, or student number
4. Results will filter in real-time

---

## 6. Exam Management

### 6.1 Creating an Exam

1. Navigate to **Exams** from the sidebar
2. Click **"Create Exam"** button
3. Fill in the form:
   - **Title:** Required (e.g., "Math Chapter 1 Test")
   - **Description:** Optional (e.g., "Covers addition and subtraction")
   - **Subject:** Required (select from dropdown)
   - **Allowed Classes:** Required (select one or more classes)
   - **Duration:** Required (in minutes, minimum 5)
   - **Passing Grade:** Optional (percentage, e.g., 70)
   - **Randomize Questions:** Optional (shuffle question order)
   - **Randomize Options:** Optional (shuffle answer options)
   - **Show Results:** Optional (show results to students after submission)
4. Click **"Save as Draft"**

### 6.2 Adding Questions to Exam

1. Open a draft exam
2. Click **"Add Question"** button
3. Select question type:
   - **Multiple Choice:** One correct answer
   - **True/False:** Yes/No questions
   - **Checkbox:** Multiple correct answers
4. Fill in question details:
   - **Question Text:** Required
   - **Question Image:** Optional (upload image)
   - **Answer Options:** Add at least 2 options
   - **Correct Answer:** Select the correct option(s)
   - **Score:** Points for this question (default: 1)
   - **Explanation:** Optional (shown to students after exam)
5. Click **"Save"**
6. Repeat for all questions

### 6.3 Reordering Questions

1. Open the exam
2. Use drag-and-drop to reorder questions
3. Changes are saved automatically

### 6.4 Editing a Question

1. Open the exam
2. Find the question you want to edit
3. Click the **edit icon** (pencil)
4. Modify the question
5. Click **"Save"**

### 6.5 Deleting a Question

1. Open the exam
2. Find the question you want to delete
3. Click the **delete icon** (trash)
4. Confirm deletion

### 6.6 Duplicating an Exam

1. Navigate to **Exams**
2. Find the exam you want to duplicate
3. Click the **duplicate icon** (copy)
4. The exam will be copied as a new draft
5. Modify as needed

### 6.7 Publishing an Exam

1. Open a draft exam
2. Ensure the exam has at least one question
3. Click **"Publish"** button
4. Review exam details
5. Set schedule (optional):
   - **Start Time:** When exam becomes available
   - **End Time:** When exam closes
6. Click **"Confirm Publish"**
7. The exam will now be visible to students in allowed classes

### 6.8 Deactivating an Exam

1. Navigate to **Exams**
2. Find the published exam
3. Click **"Deactivate"** button
4. Confirm deactivation
5. Students will no longer see the exam

### 6.9 Closing an Exam

1. Navigate to **Exams**
2. Find the completed exam
3. Click **"Close"** button
4. Confirm closure
5. Exam is archived and no longer active

### 6.10 Archiving an Exam

1. Navigate to **Exams**
2. Find the exam
3. Click **"Archive"** button
4. Exam is moved to archive

---

## 7. Question Builder

### 7.1 Question Types

#### Multiple Choice
- One correct answer
- Student selects one option
- Common for most questions

#### True/False
- Two options: True and False
- Quick to create
- Good for factual questions

#### Checkbox
- Multiple correct answers
- Student can select multiple options
- Good for "select all that apply" questions

### 7.2 Creating Effective Questions

**Best Practices:**
- Keep questions clear and concise
- Avoid ambiguous language
- Use appropriate difficulty level
- Include relevant images when helpful
- Provide explanations for learning

**Question Structure:**
1. **Clear Question:** What is being asked?
2. **Options:** 2-4 options (except True/False)
3. **Correct Answer:** Clearly marked
4. **Score:** Appropriate point value
5. **Explanation:** Why is this the correct answer?

### 7.3 Using Images

1. Click **"Upload Image"** button
2. Select image from your computer
3. Image will be displayed with the question
4. Supported formats: JPG, PNG, GIF
5. Maximum file size: 5MB

### 7.4 Question Bank

Questions are automatically saved to the question bank when created in an exam. You can:

- Reuse questions across multiple exams
- Search the question bank
- Filter by subject or topic
- Duplicate questions for modification

---

## 8. Exam Publishing

### 8.1 Before Publishing Checklist

- [ ] Exam has a clear title
- [ ] Exam has at least one question
- [ ] All questions have correct answers marked
- [ ] Duration is set appropriately
- [ ] Allowed classes are selected
- [ ] Subject is selected
- [ ] Passing grade is set (if applicable)
- [ ] Randomization settings are configured
- [ ] Show results setting is configured

### 8.2 Scheduling Exams

#### Immediate Availability
- Leave start time empty
- Exam is available immediately after publishing

#### Scheduled Start
- Set a specific start time
- Exam becomes available at that time
- Students will see it as "Upcoming"

#### Scheduled End
- Set a specific end time
- Exam closes automatically at that time
- Students cannot submit after end time

### 8.3 Publishing Process

1. Review all exam details
2. Check all questions
3. Set schedule if needed
4. Click **"Publish"**
5. Confirm publication
6. Notify students (optional)

---

## 9. Monitoring Exams

### 9.1 Viewing Active Exams

1. Navigate to **Exams**
2. Filter by status: "Published"
3. View active exams list

### 9.2 Real-Time Monitoring

1. Click on an active exam
2. Go to **"Monitoring"** tab
3. View:
   - Number of students taking exam
   - Student progress
   - Time remaining for each student
   - Students who haven't started

### 9.3 Viewing Student Progress

1. In the monitoring tab
2. Click on a student's name
3. View:
   - Current question number
   - Answers given so far
   - Time remaining
   - Violations (if any)

### 9.4 Handling Issues

If a student has technical issues:
1. Note the student's name and issue
2. Contact technical support
3. If necessary, extend exam time for that student
4. Document the incident

---

## 10. Results & Analytics

### 10.1 Viewing Exam Results

1. Navigate to **Exams**
2. Click on a completed exam
3. Go to **"Results"** tab
4. View all student submissions

### 10.2 Individual Student Results

1. In the results tab
2. Click on a student's name
3. View:
   - Total score
   - Correct/incorrect answers
   - Time taken
   - Question-by-question breakdown

### 10.3 Exam Statistics

1. In the results tab
2. Go to **"Statistics"** section
3. View:
   - Average score
   - Highest score
   - Lowest score
   - Pass rate
   - Question difficulty analysis
   - Answer distribution

### 10.4 Exporting Results

1. In the results tab
2. Click **"Export"** button
3. Choose format:
   - **Excel:** For spreadsheet analysis
   - **CSV:** For data processing
   - **PDF:** For printing or sharing
4. File will be downloaded

### 10.5 Printing Reports

1. Export results to PDF
2. Open PDF file
3. Print using your browser's print function

---

## 11. Settings

### 11.1 Academic Year/Semester

1. Navigate to **Settings**
2. Go to **"Academic"** section
3. Set current academic year
4. Set current semester
5. Click **"Save"**

### 11.2 School Profile

1. Navigate to **Settings**
2. Go to **"School Profile"** section
3. Fill in:
   - School name
   - School address
   - School logo (upload)
   - Contact information
4. Click **"Save"**

### 11.3 Default Exam Settings

1. Navigate to **Settings**
2. Go to **"Exam Defaults"** section
3. Configure:
   - Default duration (minutes)
   - Default passing grade (%)
   - Default randomization settings
4. Click **"Save"**

### 11.4 Notification Settings

1. Navigate to **Settings**
2. Go to **"Notifications"** section
3. Configure:
   - Exam reminders (time before exam)
   - Result notifications
   - System announcements
4. Click **"Save"**

### 11.5 Maintenance Mode

1. Navigate to **Settings**
2. Go to **"System"** section
3. Toggle **"Maintenance Mode"**
4. Students will see maintenance message
5. Use during system updates

### 11.6 Security Settings

1. Navigate to **Settings**
2. Go to **"Security"** section
3. Configure:
   - Session timeout (minutes)
   - Violation threshold (number)
   - Allowed email domains
4. Click **"Save"**

---

## 12. Troubleshooting

### 12.1 Common Issues

**Issue: Students cannot see the exam**
- **Solution:** Check if exam is published
- **Solution:** Verify student is in allowed class
- **Solution:** Check if exam is within scheduled time

**Issue: Cannot import students from Excel**
- **Solution:** Verify Excel format matches template
- **Solution:** Check for required columns
- **Solution:** Ensure email addresses are valid

**Issue: Exam not publishing**
- **Solution:** Ensure exam has at least one question
- **Solution:** Check all required fields are filled
- **Solution:** Verify internet connection

**Issue: Results not showing**
- **Solution:** Check if students have submitted
- **Solution:** Verify "Show Results" setting is enabled
- **Solution:** Check if scoring is complete

### 12.2 Getting Help

If you encounter issues not covered here:

1. Check the **Deployment Guide** for technical issues
2. Contact **Technical Support:** techsupport@easyexam.com
3. Include:
   - Your name and school
   - Description of the issue
   - Steps to reproduce
   - Screenshots if applicable

### 12.3 Best Practices

**For Exam Creation:**
- Create exams well in advance
- Test exams before publishing
- Use clear, age-appropriate language
- Include a variety of question types
- Review questions for accuracy

**For Student Management:**
- Keep student information up to date
- Use bulk import for large classes
- Regularly backup student data
- Monitor student activity

**For Security:**
- Use strong passwords for your Google account
- Don't share your login credentials
- Regularly review security settings
- Monitor for suspicious activity

---

## 13. Tips and Tricks

### 13.1 Time-Saving Tips

- **Duplicate Exams:** Use duplicate feature to create similar exams quickly
- **Question Bank:** Reuse questions across multiple exams
- **Bulk Import:** Import students in bulk rather than one by one
- **Templates:** Create exam templates for common question types

### 13.2 Effective Exam Design

- **Mix Difficulty:** Include easy, medium, and hard questions
- **Clear Instructions:** Provide clear exam instructions
- **Appropriate Timing:** Set realistic duration based on question count
- **Review Process:** Always review exams before publishing

### 13.3 Student Engagement

- **Variety:** Use different question types to keep students engaged
- **Feedback:** Enable result review to help students learn
- **Timely Results:** Publish results quickly after exams
- **Communication:** Notify students about upcoming exams

---

## 14. Glossary

- **Draft:** Exam in creation, not yet visible to students
- **Published:** Exam visible and available to students
- **Closed:** Exam no longer active, archived
- **Violation:** Anti-cheat rule broken by student
- **Auto-Submit:** Automatic submission when time expires or violations occur
- **Question Bank:** Repository of reusable questions
- **Passing Grade:** Minimum score required to pass

---

## 15. Contact Information

**Technical Support:**
- Email: techsupport@easyexam.com
- Response Time: 24-48 hours

**Training Requests:**
- Email: training@easyexam.com
- Subject: Easy Exam Training Request

**General Inquiries:**
- Email: support@easyexam.com

---

## End of Teacher User Guide
