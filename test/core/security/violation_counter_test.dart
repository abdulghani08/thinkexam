import 'package:easyexam/core/security/session_guard.dart';
import 'package:easyexam/core/security/violation_counter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSessionGuard extends Mock implements SessionGuard {}

void main() {
  late MockSessionGuard mockSessionGuard;
  late ViolationCounter violationCounter;

  setUp(() {
    mockSessionGuard = MockSessionGuard();
    when(() => mockSessionGuard.violationCount).thenReturn(0);
    violationCounter = ViolationCounter(
      sessionGuard: mockSessionGuard,
      maxViolations: 3,
    );
  });

  group('ViolationCounter', () {
    test('should initialize with default values', () {
      expect(violationCounter.currentCount, 0);
      expect(violationCounter.maxCount, 3);
      expect(violationCounter.hasExceeded, false);
    });

    test('should return correct remaining violations', () {
      when(() => mockSessionGuard.violationCount).thenReturn(1);
      expect(violationCounter.remainingViolations, 2);
    });

    test('should detect when violations exceeded', () {
      when(() => mockSessionGuard.violationCount).thenReturn(3);
      expect(violationCounter.hasExceeded, true);
    });

    test('should warn at threshold 1', () {
      when(() => mockSessionGuard.violationCount).thenReturn(1);
      expect(violationCounter.shouldWarn, true);
    });

    test('should warn at threshold 2', () {
      when(() => mockSessionGuard.violationCount).thenReturn(2);
      expect(violationCounter.shouldWarn, true);
    });

    test('should not warn at threshold 0', () {
      when(() => mockSessionGuard.violationCount).thenReturn(0);
      expect(violationCounter.shouldWarn, false);
    });

    test('should not warn beyond max violations', () {
      when(() => mockSessionGuard.violationCount).thenReturn(4);
      expect(violationCounter.shouldWarn, false);
    });

    test('should return warning message for last warning', () {
      when(() => mockSessionGuard.violationCount).thenReturn(2);
      final message = violationCounter.getWarningMessage();
      expect(message, contains('last warning'));
    });

    test('should return warning message with remaining count', () {
      when(() => mockSessionGuard.violationCount).thenReturn(1);
      final message = violationCounter.getWarningMessage();
      expect(message, contains('1 violations remaining'));
    });

    test('should return empty string when not warning', () {
      when(() => mockSessionGuard.violationCount).thenReturn(0);
      final message = violationCounter.getWarningMessage();
      expect(message, isEmpty);
    });

    test('should reset violations', () {
      when(() => mockSessionGuard.violationCount).thenReturn(2);
      violationCounter.reset();
      verify(() => mockSessionGuard.clearViolations()).called(1);
    });

    test('should use custom warning thresholds', () {
      final customCounter = ViolationCounter(
        sessionGuard: mockSessionGuard,
        maxViolations: 5,
        warningThresholds: [2, 4],
      );

      when(() => mockSessionGuard.violationCount).thenReturn(2);
      expect(customCounter.shouldWarn, true);

      when(() => mockSessionGuard.violationCount).thenReturn(3);
      expect(customCounter.shouldWarn, false);
    });
  });
}
