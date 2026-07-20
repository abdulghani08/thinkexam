import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/error/failures.dart';
import '../../../domain/entities/exam_session.dart';
import '../../../domain/repositories/exam_session_repository.dart';
import '../../../core/di/exam_providers.dart';

enum ResultStatus { initial, loading, success, error }

class ResultState {
  final ResultStatus status;
  final List<ExamSession> sessions;
  final int completedCount;
  final int inProgressCount;
  final String? errorMessage;

  const ResultState({
    this.status = ResultStatus.initial,
    this.sessions = const [],
    this.completedCount = 0,
    this.inProgressCount = 0,
    this.errorMessage,
  });

  ResultState copyWith({
    ResultStatus? status,
    List<ExamSession>? sessions,
    int? completedCount,
    int? inProgressCount,
    String? errorMessage,
  }) =>
      ResultState(
        status: status ?? this.status,
        sessions: sessions ?? this.sessions,
        completedCount: completedCount ?? this.completedCount,
        inProgressCount: inProgressCount ?? this.inProgressCount,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}

class ResultNotifier extends StateNotifier<ResultState> {
  final ExamSessionRepository _sessionRepository;

  ResultNotifier(this._sessionRepository) : super(const ResultState());

  Future<void> loadResults(String examId) async {
    state = state.copyWith(status: ResultStatus.loading);

    final result = await _sessionRepository.getSessionsByExam(examId);

    result.fold(
      (failure) => state = state.copyWith(
        status: ResultStatus.error,
        errorMessage: failure.message,
      ),
      (sessions) {
        final completed = sessions
            .where((s) => s.status == ExamSessionStatus.completed)
            .length;
        final inProgress = sessions
            .where((s) => s.status == ExamSessionStatus.running)
            .length;
        state = state.copyWith(
          status: ResultStatus.success,
          sessions: sessions,
          completedCount: completed,
          inProgressCount: inProgress,
        );
      },
    );
  }
}

final resultProvider =
    StateNotifierProvider.autoDispose<ResultNotifier, ResultState>((ref) {
  final sessionRepository = ref.watch(examSessionRepositoryProvider);
  return ResultNotifier(sessionRepository);
});
