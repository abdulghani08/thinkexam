import 'dart:ui';

import 'package:flutter/foundation.dart';

enum LifecycleState { resumed, inactive, paused, detached }

class LifecycleEvent {
  final LifecycleState state;
  final DateTime timestamp;

  LifecycleEvent({required this.state, required this.timestamp});
}

class LifecycleMonitor extends ChangeNotifier {
  LifecycleState _currentState = LifecycleState.resumed;
  final List<LifecycleEvent> _events = [];
  DateTime? _lastResumedTime;
  int _pauseCount = 0;

  LifecycleState get currentState => _currentState;
  List<LifecycleEvent> get events => List.unmodifiable(_events);
  DateTime? get lastResumedTime => _lastResumedTime;
  int get pauseCount => _pauseCount;
  bool get isInBackground => _currentState != LifecycleState.resumed;

  void onLifecycleChanged(AppLifecycleState state) {
    final lifecycleState = _mapLifecycleState(state);
    _currentState = lifecycleState;

    final event = LifecycleEvent(
      state: lifecycleState,
      timestamp: DateTime.now(),
    );
    _events.add(event);

    if (lifecycleState == LifecycleState.resumed) {
      _lastResumedTime = DateTime.now();
    } else if (lifecycleState == LifecycleState.paused) {
      _pauseCount++;
    }

    notifyListeners();
  }

  LifecycleState _mapLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        return LifecycleState.resumed;
      case AppLifecycleState.inactive:
        return LifecycleState.inactive;
      case AppLifecycleState.paused:
        return LifecycleState.paused;
      case AppLifecycleState.detached:
        return LifecycleState.detached;
      case AppLifecycleState.hidden:
        return LifecycleState.inactive;
    }
  }

  Duration? getTimeInBackground() {
    if (_lastResumedTime == null) return null;
    final lastEvent = _events.lastWhere(
      (e) => e.state == LifecycleState.paused,
      orElse: () => _events.first,
    );
    return _lastResumedTime!.difference(lastEvent.timestamp);
  }

  void reset() {
    _events.clear();
    _pauseCount = 0;
    _lastResumedTime = null;
    notifyListeners();
  }
}
