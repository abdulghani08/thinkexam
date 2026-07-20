# Testing Guide - Easy Exam

## Document Information
- **Project:** Easy Exam
- **Version:** 1.0.0
- **Purpose:** Comprehensive testing guide for Phase 11 - Testing & Quality Assurance
- **Last Updated:** 2026

---

## Overview

This guide provides instructions for running all tests for the Easy Exam project, including unit tests, widget tests, integration tests, and manual testing scenarios.

---

## Prerequisites

### Flutter Environment Setup
1. Install Flutter SDK (version 3.11.0 or higher)
2. Install Android Studio / Xcode for mobile testing
3. Install Chrome for web testing
4. Configure Flutter environment:
   ```bash
   flutter doctor
   ```

### Project Setup
1. Clone the repository
2. Navigate to project directory:
   ```bash
   cd easyexam
   ```
3. Install dependencies:
   ```bash
   flutter pub get
   ```

### Firebase Setup (for integration tests)
1. Create a Firebase test project
2. Add Android app to Firebase project
3. Add Web app to Firebase project
4. Download `google-services.json` for Android
5. Download `firebaseConfig` for Web
6. Configure Firebase Security Rules for testing

---

## Automated Tests

### Unit Tests

Unit tests test individual functions, classes, and methods in isolation.

#### Running All Unit Tests
```bash
flutter test test/domain/
flutter test test/core/
```

#### Running Specific Unit Test Files
```bash
flutter test test/domain/entities/teacher_test.dart
flutter test test/domain/entities/student_test.dart
flutter test test/domain/entities/exam_test.dart
flutter test test/domain/entities/question_test.dart
flutter test test/domain/entities/class_room_test.dart
flutter test test/domain/entities/subject_test.dart
flutter test test/domain/entities/exam_session_test.dart
flutter test test/domain/entities/exam_result_test.dart
flutter test test/domain/usecases/auth/sign_in_with_google_usecase_test.dart
flutter test test/domain/usecases/auth/sign_out_usecase_test.dart
flutter test test/domain/usecases/auth/get_current_user_usecase_test.dart
flutter test test/domain/usecases/exam/create_exam_usecase_test.dart
flutter test test/domain/usecases/exam/get_exams_usecase_test.dart
flutter test test/domain/usecases/question/create_question_usecase_test.dart
flutter test test/domain/usecases/student/create_student_usecase_test.dart
flutter test test/core/error/failures_test.dart
flutter test test/core/error/exceptions_test.dart
flutter test test/core/utils/validators_test.dart
```

#### Unit Test Coverage
- **Domain Entities:** 8 test files covering all entities
- **Use Cases:** 6 test files covering critical use cases
- **Core Modules:** 3 test files covering error handling and validators

---

### Widget Tests

Widget tests test individual UI widgets in isolation.

#### Running All Widget Tests
```bash
flutter test test/presentation/widgets/
```

#### Running Specific Widget Test Files
```bash
flutter test test/presentation/widgets/common/app_button_test.dart
flutter test test/presentation/widgets/common/loading_indicator_test.dart
flutter test test/presentation/widgets/common/empty_state_test.dart
```

#### Widget Test Coverage
- **Common Widgets:** 3 test files covering reusable UI components
  - AppButton (all variants, states, interactions)
  - LoadingIndicator (standard and small variants)
  - EmptyState (custom and pre-configured states)

---

### Integration Tests

Integration tests test complete user flows and interactions between multiple components.

#### Running All Integration Tests
```bash
flutter test integration_test/
```

#### Running Specific Integration Test Files
```bash
flutter test test/integration/auth_flow_test.dart
flutter test test/integration/exam_creation_flow_test.dart
flutter test test/integration/student_exam_flow_test.dart
flutter test test/integration/anti_cheat_flow_test.dart
```

#### Integration Test Coverage
- **Authentication Flow:** Sign-in, sign-out, unauthorized user handling
- **Exam Creation Flow:** Create exam, add questions, publish exam
- **Student Exam Flow:** Start exam, navigate questions, submit exam, auto-submit
- **Anti-Cheat Flow:** Background detection, violation threshold, orientation lock

---

## Test Coverage Analysis

### Installing Coverage Tool
```bash
flutter pub global activate coverage
```

### Running Tests with Coverage
```bash
flutter test --coverage
```

### Generating Coverage Report
```bash
flutter pub global run coverage:format_coverage --lcov --in=coverage --out=coverage/lcov.info
```

### Viewing Coverage Report
1. Install a coverage viewer (e.g., lcov)
2. Open the report:
   ```bash
   genhtml coverage/lcov.info -o coverage/html
   ```
3. Open `coverage/html/index.html` in a browser

### Coverage Goals
- **Domain Layer:** 80%+ coverage
- **Core Modules:** 70%+ coverage
- **Use Cases:** 75%+ coverage
- **UI Widgets:** 50%+ coverage

---

## Manual Testing

### Manual Testing Scenarios

Refer to `docs/06_MANUAL_TESTING_SCENARIOS.md` for detailed manual testing scenarios covering:

1. **Authentication Module Testing** (5 test cases)
2. **Admin Module Testing** (8 test cases)
3. **Student Module Testing** (7 test cases)
4. **Security & Anti-Cheat Testing** (5 test cases)
5. **Performance Testing** (2 test cases)
6. **Network Testing** (2 test cases)
7. **UI/UX Testing** (4 test cases)
8. **Data Validation Testing** (2 test cases)
9. **Export/Import Testing** (2 test cases)
10. **Accessibility Testing** (2 test cases)

### Manual Testing Procedure

1. **Setup Test Environment**
   - Use Firebase test project
   - Create test data (teachers, students, classes, subjects, exams)
   - Prepare test devices (Android phones, tablets, web browsers)

2. **Execute Test Cases**
   - Follow each test case step-by-step
   - Record actual results
   - Mark status as Pass/Fail
   - Document any issues or deviations

3. **Report Issues**
   - Create bug reports for failed test cases
   - Include steps to reproduce
   - Include screenshots/videos if applicable
   - Assign priority and severity

---

## User Acceptance Testing (UAT)

### UAT Checklist

Refer to `docs/07_UAT_CHECKLIST.md` for the comprehensive UAT checklist covering:

1. **Authentication Module UAT** (9 items)
2. **Admin Module UAT** (45 items)
3. **Student Module UAT** (30 items)
4. **Security & Anti-Cheat UAT** (5 items)
5. **Performance UAT** (3 items)
6. **UI/UX UAT** (6 items)
7. **Network & Offline UAT** (3 items)
8. **Data Management UAT** (3 items)
9. **Cross-Platform UAT** (2 items)
10. **Overall UAT Assessment** (3 items)

### UAT Procedure

1. **Prepare UAT Environment**
   - Use staging Firebase project
   - Prepare realistic test data
   - Set up test devices for actual users

2. **Conduct UAT Sessions**
   - Schedule sessions with teachers and students
   - Guide users through test scenarios
   - Collect feedback and observations
   - Record issues and suggestions

3. **UAT Sign-Off**
   - Review all test results
   - Address critical issues
   - Obtain sign-off from stakeholders
   - Make Go/No-Go decision

---

## Continuous Integration (CI)

### GitHub Actions Configuration

Create `.github/workflows/test.yml`:

```yaml
name: Test

on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main, develop ]

jobs:
  test:
    runs-on: ubuntu-latest
    
    steps:
    - uses: actions/checkout@v3
    
    - name: Setup Flutter
      uses: subosito/flutter-action@v2
      with:
        flutter-version: '3.11.0'
        
    - name: Install dependencies
      run: flutter pub get
      
    - name: Run unit tests
      run: flutter test test/domain/ test/core/
      
    - name: Run widget tests
      run: flutter test test/presentation/widgets/
      
    - name: Run integration tests
      run: flutter test integration_test/
      
    - name: Generate coverage
      run: flutter test --coverage
      
    - name: Upload coverage
      uses: codecov/codecov-action@v3
      with:
        files: coverage/lcov.info
```

---

## Test Data Management

### Test Data Setup Script

Create a script to populate Firebase with test data:

```dart
// scripts/setup_test_data.dart
// This script would populate Firestore with test data for testing
```

### Test Data Cleanup

After testing, clean up test data:

```dart
// scripts/cleanup_test_data.dart
// This script would remove test data from Firestore
```

---

## Debugging Tests

### Running Tests in Debug Mode
```bash
flutter test --debug
```

### Running Tests with Verbose Output
```bash
flutter test --verbose
```

### Running Specific Test Group
```bash
flutter test --name "Teacher Entity"
```

### Pausing Tests for Debugging
Add `debugPrint` statements in tests or use `debugger()` statement to pause execution.

---

## Common Issues and Solutions

### Issue: Tests fail due to missing Firebase configuration
**Solution:** Ensure `google-services.json` (Android) and `firebaseConfig` (Web) are properly configured.

### Issue: Integration tests timeout
**Solution:** Increase timeout in test configuration or optimize test execution.

### Issue: Widget tests fail due to missing dependencies
**Solution:** Ensure all required providers and dependencies are mocked or provided in test setup.

### Issue: Tests pass locally but fail in CI
**Solution:** Ensure CI environment matches local environment, check for environment-specific configurations.

---

## Test Execution Summary

### Automated Tests
- **Unit Tests:** 17 test files
- **Widget Tests:** 3 test files
- **Integration Tests:** 4 test files
- **Total Automated Tests:** 24 test files

### Manual Tests
- **Manual Testing Scenarios:** 39 test cases
- **UAT Checklist:** 111 checklist items

### Total Test Coverage
- **Automated:** 24 test files
- **Manual:** 39 test cases + 111 UAT items
- **Overall:** Comprehensive coverage of all features

---

## Next Steps

1. Execute all automated tests
2. Run manual testing scenarios
3. Conduct UAT with actual users
4. Fix any identified issues
5. Re-run tests to verify fixes
6. Generate test coverage report
7. Obtain UAT sign-off
8. Proceed to Phase 12 (Deployment)

---

## Contact

For questions or issues related to testing, contact:
- **QA Team:** [qa@easyexam.com]
- **Development Team:** [dev@easyexam.com]
