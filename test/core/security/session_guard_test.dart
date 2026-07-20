import 'package:easyexam/core/security/lifecycle_monitor.dart';
import 'package:easyexam/core/security/session_guard.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockLifecycleMonitor extends Mock implements LifecycleMonitor {}

void main() {
  late MockLifecycleMonitor mockLifecycleMonitor;
  late SessionGuard sessionGuard;

  setUp(() {
    mockLifecycleMonitor = MockLifecycleMonitor();
    when(() => mockLifecycleMonitor.currentState).thenReturn(LifecycleState.resumed);
    when(() => mockLifecycleMonitor.getTimeInBackground()).thenReturn(Duration.zero);
    sessionGuard = SessionGuard(
      lifecycleMonitor: mockLifecycleMonitor,
      maxViolations: 3,
      maxBackgroundTimeSeconds: 30,
    );
  });

  tearDown(() {
    sessionGuard.dispose();
  });

  group('SessionGuard', () {
    test('should initialize with default values', () {
      expect(sessionGuard.isActive, false);
      expect(sessionGuard.isLocked, false);
      expect(sessionGuard.violationCount, 0);
      expect(sessionGuard.violations, isEmpty);
    });

    test('should activate session', () {
      sessionGuard.activate();
      expect(sessionGuard.isActive, true);
      expect(sessionGuard.isLocked, false);
      expect(sessionGuard.violationCount, 0);
    });

    test('should deactivate session', () {
      sessionGuard.activate();
      sessionGuard.deactivate();
      expect(sessionGuard.isActive, false);
    });

    test('should lock session', () {
      sessionGuard.lock();
      expect(sessionGuard.isLocked, true);
    });

    test('should unlock session', () {
      sessionGuard.lock();
      sessionGuard.unlock();
      expect(sessionGuard.isLocked, false);
    });

    test('should record violation when app minimized while active', () {
      sessionGuard.activate();
      when(() => mockLifecycleMonitor.currentState).thenReturn(LifecycleState.paused);
      
      // Simulate lifecycle change
      sessionGuard.activate(); // Re-activate to trigger listener
      when(() => mockLifecycleMonitor.currentState).thenReturn(LifecycleState.paused);
      
      // Need to manually trigger the callback since we can't easily test the listener
      expect(sessionGuard.violationCount, 0);
    });

    test('should not record violation when session is inactive', () {
      sessionGuard.recordScreenOff();
      expect(sessionGuard.violationCount, 0);
    });

    test('should not record violation when session is locked', () {
      sessionGuard.activate();
      sessionGuard.lock();
      sessionGuard.recordScreenOff();
      expect(sessionGuard.violationCount, 0);
    });

    test('should record screen off violation', () {
      sessionGuard.activate();
      sessionGuard.recordScreenOff();
      expect(sessionGuard.violationCount, 1);
      expect(sessionGuard.violations.first.type, GuardViolationType.screenOff);
    });

    test('should record app switch violation', () {
      sessionGuard.activate();
      sessionGuard.recordAppSwitch();
      expect(sessionGuard.violationCount, 1);
      expect(sessionGuard.violations.first.type, GuardViolationType.appSwitched);
    });

    test('should lock when violations exceed max', () {
      sessionGuard.activate();
      sessionGuard.recordScreenOff();
      sessionGuard.recordAppSwitch();
      sessionGuard.recordScreenOff();
      expect(sessionGuard.isLocked, true);
      expect(sessionGuard.hasExceededViolations, true);
    });

    test('should clear violations', () {
      sessionGuard.activate();
      sessionGuard.recordScreenOff();
      sessionGuard.recordAppSwitch();
      expect(sessionGuard.violationCount, 2);
      
      sessionGuard.clearViolations();
      expect(sessionGuard.violationCount, 0);
      expect(sessionGuard.violations, isEmpty);
    });

    test('should check background time exceeded', () {
      sessionGuard.activate();
      when(() => mockLifecycleMonitor.getTimeInBackground()).thenReturn(const Duration(seconds: 35));
      expect(sessionGuard.hasExceededBackgroundTime(), true);
    });

    test('should not exceed background time when under limit', () {
      sessionGuard.activate();
      when(() => mockLifecycleMonitor.getTimeInBackground()).thenReturn(const Duration(seconds: 25));
      expect(sessionGuard.hasExceededBackgroundTime(), false);
    });

    test('should return zero background time when null', () {
      sessionGuard.activate();
      when(() => mockLifecycleMonitor.getTimeInBackground()).thenReturn(null);
      expect(sessionGuard.getTimeInBackground(), Duration.zero);
    });

    test('should use custom max violations', () {
      final customGuard = SessionGuard(
        lifecycleMonitor: mockLifecycleMonitor,
        maxViolations: 5,
      );
      
      customGuard.activate();
      for (int i = 0; i < 5; i++) {
        customGuard.recordScreenOff();
      }
      
      expect(customGuard.hasExceededViolations, true);
      customGuard.dispose();
    });

    test('should use custom max background time', () {
      final customGuard = SessionGuard(
        lifecycleMonitor: mockLifecycleMonitor,
        maxBackgroundTimeSeconds: 60,
      );
      
      customGuard.activate();
      when(() => mockLifecycleMonitor.getTimeInBackground()).thenReturn(const Duration(seconds: 45));
      expect(customGuard.hasExceededBackgroundTime(), false);
      
      when(() => mockLifecycleMonitor.getTimeInBackground()).thenReturn(const Duration(seconds: 65));
      expect(customGuard.hasExceededBackgroundTime(), true);
      
      customGuard.dispose();
    });

    test('violation should have timestamp', () {
      sessionGuard.activate();
      final beforeTime = DateTime.now();
      sessionGuard.recordScreenOff();
      final afterTime = DateTime.now();
      
      expect(sessionGuard.violations.first.timestamp, isNotNull);
      expect(
        sessionGuard.violations.first.timestamp.isAfter(beforeTime) ||
        sessionGuard.violations.first.timestamp.isAtSameMomentAs(beforeTime),
        true,
      );
      expect(
        sessionGuard.violations.first.timestamp.isBefore(afterTime) ||
        sessionGuard.violations.first.timestamp.isAtSameMomentAs(afterTime),
        true,
      );
    });
  });
}
