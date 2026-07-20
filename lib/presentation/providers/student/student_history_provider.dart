import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/error/failures.dart';
import '../../../domain/entities/exam_session.dart';
import '../../../domain/repositories/exam_session_repository.dart';
import '../../../core/di/exam_providers.dart';

enum StudentHistoryStatus { initial, loading, success, error }

class StudentHistoryState {
  final StudentHistoryStatus status;
  final List<ExamSession> sessions;
  final String? errorMessage;
  final String? filterStatus;

  const StudentHistoryState({
    this.status = StudentHistoryStatus.initial,
    this.sessions = const [],
    this.errorMessage,
    this.filterStatus,
  });

  StudentHistoryState copyWith({
    StudentHistoryStatus? status,
    List<ExamSession>? sessions,
    String? errorMessage,
    String? filterStatus,
  }) =>
      StudentHistoryState(
        status: status ?? this.status,
        sessions: sessions ?? this.sessions,
        errorMessage: errorMessage ?? this.errorMessage,
        filterStatus: filterStatus ?? this.filterStatus,
      );

  List<ExamSession> get filteredSessions {
    if (filterStatus == null || filterStatus == 'all') return sessions;
    return sessions.where((s) => s.status.name == filterStatus).toList();
  }
}

class StudentHistoryNotifier extends StateNotifier<StudentHistoryState> {
  final ExamSessionRepository _sessionRepository;

  StudentHistoryNotifier(this._sessionRepository)
      : super(const StudentHistoryState());

  Future<void> loadHistory(String studentId) async {
    state = state.copyWith(status: StudentHistoryStatus.loading);

    final result = await _sessionRepository.getSessionsByStudent(studentId);

    result.fold(
      (failure) => state = state.copyWith(
        status: StudentHistoryStatus.error,
        errorMessage: failure.message,
      ),
      (sessions) => state = state.copyWith(
        status: StudentHistoryStatus.success,
        sessions: sessions,
      ),
    );
  }

  void setFilter(String? status) {
    state = state.copyWith(filterStatus: status);
  }
}

final studentHistoryProvider =
    StateNotifierProvider.autoDispose<StudentHistoryNotifier, StudentHistoryState>(
  (ref) {
    final sessionRepository = ref.watch(examSessionRepositoryProvider);
    return StudentHistoryNotifier(sessionRepository);
  },
);
