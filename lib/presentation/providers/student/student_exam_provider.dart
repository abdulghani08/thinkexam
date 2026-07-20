import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/error/failures.dart';
import '../../../domain/entities/exam.dart';
import '../../../domain/entities/exam_page.dart';
import '../../../domain/repositories/exam_repository.dart';
import '../../../core/di/exam_providers.dart';
import '../../../domain/usecases/exam/get_exam_by_id_usecase.dart';
import '../../../domain/usecases/exam/get_exams_usecase.dart';

enum StudentExamListStatus { initial, loading, success, error }

class StudentExamListState {
  final StudentExamListStatus status;
  final List<Exam> exams;
  final String? errorMessage;
  final bool hasMore;
  final String? nextCursor;

  const StudentExamListState({
    this.status = StudentExamListStatus.initial,
    this.exams = const [],
    this.errorMessage,
    this.hasMore = false,
    this.nextCursor,
  });

  StudentExamListState copyWith({
    StudentExamListStatus? status,
    List<Exam>? exams,
    String? errorMessage,
    bool? hasMore,
    String? nextCursor,
  }) => StudentExamListState(
    status: status ?? this.status,
    exams: exams ?? this.exams,
    errorMessage: errorMessage ?? this.errorMessage,
    hasMore: hasMore ?? this.hasMore,
    nextCursor: nextCursor ?? this.nextCursor,
  );
}

class StudentExamListNotifier extends StateNotifier<StudentExamListState> {
  final GetExamsUseCase _getExamsUseCase;

  StudentExamListNotifier(this._getExamsUseCase)
    : super(const StudentExamListState());

  Future<void> loadExams({String? classId, bool refresh = false}) async {
    if (refresh) {
      state = state.copyWith(
        status: StudentExamListStatus.loading,
        exams: [],
        nextCursor: null,
      );
    } else if (state.status == StudentExamListStatus.loading) {
      return;
    }

    final result = await _getExamsUseCase(
      GetExamsParams(
        status: 'published',
        cursor: refresh ? null : state.nextCursor,
        limit: 20,
      ),
    );

    result.fold(
      (failure) => state = state.copyWith(
        status: StudentExamListStatus.error,
        errorMessage: failure.message,
      ),
      (page) => state = state.copyWith(
        status: StudentExamListStatus.success,
        exams: refresh ? page.exams : [...state.exams, ...page.exams],
        hasMore: page.hasMore,
        nextCursor: page.nextCursor,
      ),
    );
  }

  Future<void> loadMore() async {
    if (!state.hasMore || state.status == StudentExamListStatus.loading) return;
    await loadExams();
  }
}

enum StudentExamDetailStatus { initial, loading, success, error }

class StudentExamDetailState {
  final StudentExamDetailStatus status;
  final Exam? exam;
  final String? errorMessage;

  const StudentExamDetailState({
    this.status = StudentExamDetailStatus.initial,
    this.exam,
    this.errorMessage,
  });

  StudentExamDetailState copyWith({
    StudentExamDetailStatus? status,
    Exam? exam,
    String? errorMessage,
  }) => StudentExamDetailState(
    status: status ?? this.status,
    exam: exam ?? this.exam,
    errorMessage: errorMessage ?? this.errorMessage,
  );
}

class StudentExamDetailNotifier extends StateNotifier<StudentExamDetailState> {
  final GetExamByIdUseCase _getExamByIdUseCase;

  StudentExamDetailNotifier(this._getExamByIdUseCase)
    : super(const StudentExamDetailState());

  Future<void> loadExam(String examId) async {
    state = state.copyWith(status: StudentExamDetailStatus.loading);
    final result = await _getExamByIdUseCase(GetExamByIdParams(examId));
    result.fold(
      (failure) => state = state.copyWith(
        status: StudentExamDetailStatus.error,
        errorMessage: failure.message,
      ),
      (exam) => state = state.copyWith(
        status: StudentExamDetailStatus.success,
        exam: exam,
      ),
    );
  }
}

final studentExamListProvider =
    StateNotifierProvider<StudentExamListNotifier, StudentExamListState>((ref) {
      final examRepository = ref.watch(examRepositoryProvider);
      final getExamsUseCase = GetExamsUseCase(examRepository);
      return StudentExamListNotifier(getExamsUseCase);
    });

final studentExamDetailProvider =
    StateNotifierProvider<StudentExamDetailNotifier, StudentExamDetailState>((
      ref,
    ) {
      final examRepository = ref.watch(examRepositoryProvider);
      final getExamByIdUseCase = GetExamByIdUseCase(examRepository);
      return StudentExamDetailNotifier(getExamByIdUseCase);
    });
