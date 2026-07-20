import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/error/failures.dart';
import '../../../domain/entities/exam.dart';
import '../../../domain/entities/exam_page.dart';
import '../../../domain/repositories/exam_repository.dart';
import '../../../domain/usecases/exam/create_exam_usecase.dart';
import '../../../domain/usecases/exam/delete_exam_usecase.dart';
import '../../../domain/usecases/exam/duplicate_exam_usecase.dart';
import '../../../domain/usecases/exam/get_exam_by_id_usecase.dart';
import '../../../domain/usecases/exam/get_exams_usecase.dart';
import '../../../domain/usecases/exam/publish_exam_usecase.dart';
import '../../../core/di/exam_providers.dart';
import '../../../domain/usecases/exam/archive_exam_usecase.dart';
import '../../../domain/usecases/exam/search_exams_usecase.dart';
import '../../../domain/usecases/exam/update_exam_usecase.dart';

enum ExamListStatus { initial, loading, success, error }

class ExamListState {
  final ExamListStatus status;
  final List<Exam> exams;
  final String? errorMessage;
  final bool hasMore;
  final String? nextCursor;
  final String? currentQuery;
  final String? currentStatus;

  const ExamListState({
    this.status = ExamListStatus.initial,
    this.exams = const [],
    this.errorMessage,
    this.hasMore = false,
    this.nextCursor,
    this.currentQuery,
    this.currentStatus,
  });

  ExamListState copyWith({
    ExamListStatus? status,
    List<Exam>? exams,
    String? errorMessage,
    bool? hasMore,
    String? nextCursor,
    String? currentQuery,
    String? currentStatus,
  }) => ExamListState(
    status: status ?? this.status,
    exams: exams ?? this.exams,
    errorMessage: errorMessage ?? this.errorMessage,
    hasMore: hasMore ?? this.hasMore,
    nextCursor: nextCursor ?? this.nextCursor,
    currentQuery: currentQuery ?? this.currentQuery,
    currentStatus: currentStatus ?? this.currentStatus,
  );
}

class ExamListNotifier extends StateNotifier<ExamListState> {
  final GetExamsUseCase _getExamsUseCase;
  final SearchExamsUseCase _searchExamsUseCase;

  ExamListNotifier(this._getExamsUseCase, this._searchExamsUseCase)
    : super(const ExamListState());

  Future<void> loadExams({String? status, bool refresh = false}) async {
    if (refresh) {
      state = state.copyWith(
        status: ExamListStatus.loading,
        exams: [],
        nextCursor: null,
      );
    } else if (state.status == ExamListStatus.loading) {
      return;
    }

    final result = await _getExamsUseCase(
      GetExamsParams(
        cursor: refresh ? null : state.nextCursor,
        limit: 20,
        status: status ?? state.currentStatus,
      ),
    );

    result.fold(
      (failure) => state = state.copyWith(
        status: ExamListStatus.error,
        errorMessage: failure.message,
      ),
      (page) => state = state.copyWith(
        status: ExamListStatus.success,
        exams: refresh ? page.exams : [...state.exams, ...page.exams],
        hasMore: page.hasMore,
        nextCursor: page.nextCursor,
        currentStatus: status ?? state.currentStatus,
      ),
    );
  }

  Future<void> searchExams(String query, {String? status}) async {
    state = state.copyWith(
      status: ExamListStatus.loading,
      exams: [],
      nextCursor: null,
      currentQuery: query,
      currentStatus: status,
    );

    final result = await _searchExamsUseCase(
      SearchExamsParams(query: query, limit: 20, status: status),
    );

    result.fold(
      (failure) => state = state.copyWith(
        status: ExamListStatus.error,
        errorMessage: failure.message,
      ),
      (page) => state = state.copyWith(
        status: ExamListStatus.success,
        exams: page.exams,
        hasMore: page.hasMore,
        nextCursor: page.nextCursor,
      ),
    );
  }

  Future<void> loadMore() async {
    if (!state.hasMore || state.status == ExamListStatus.loading) return;

    if (state.currentQuery != null && state.currentQuery!.isNotEmpty) {
      final result = await _searchExamsUseCase(
        SearchExamsParams(
          query: state.currentQuery!,
          cursor: state.nextCursor,
          limit: 20,
          status: state.currentStatus,
        ),
      );

      result.fold(
        (failure) => state = state.copyWith(
          status: ExamListStatus.error,
          errorMessage: failure.message,
        ),
        (page) => state = state.copyWith(
          status: ExamListStatus.success,
          exams: [...state.exams, ...page.exams],
          hasMore: page.hasMore,
          nextCursor: page.nextCursor,
        ),
      );
    } else {
      await loadExams();
    }
  }
}

enum ExamDetailStatus { initial, loading, success, error }

class ExamDetailState {
  final ExamDetailStatus status;
  final Exam? exam;
  final String? errorMessage;

  const ExamDetailState({
    this.status = ExamDetailStatus.initial,
    this.exam,
    this.errorMessage,
  });

  ExamDetailState copyWith({
    ExamDetailStatus? status,
    Exam? exam,
    String? errorMessage,
  }) => ExamDetailState(
    status: status ?? this.status,
    exam: exam ?? this.exam,
    errorMessage: errorMessage ?? this.errorMessage,
  );
}

class ExamDetailNotifier extends StateNotifier<ExamDetailState> {
  final GetExamByIdUseCase _getExamByIdUseCase;
  final CreateExamUseCase _createExamUseCase;
  final UpdateExamUseCase _updateExamUseCase;
  final DeleteExamUseCase _deleteExamUseCase;
  final PublishExamUseCase _publishExamUseCase;
  final ArchiveExamUseCase _archiveExamUseCase;
  final DuplicateExamUseCase _duplicateExamUseCase;

  ExamDetailNotifier(
    this._getExamByIdUseCase,
    this._createExamUseCase,
    this._updateExamUseCase,
    this._deleteExamUseCase,
    this._publishExamUseCase,
    this._archiveExamUseCase,
    this._duplicateExamUseCase,
  ) : super(const ExamDetailState());

  Future<void> loadExam(String id) async {
    state = state.copyWith(status: ExamDetailStatus.loading);
    final result = await _getExamByIdUseCase(GetExamByIdParams(id));
    result.fold(
      (failure) => state = state.copyWith(
        status: ExamDetailStatus.error,
        errorMessage: failure.message,
      ),
      (exam) =>
          state = state.copyWith(status: ExamDetailStatus.success, exam: exam),
    );
  }

  Future<void> createExam(Exam exam) async {
    final result = await _createExamUseCase(exam);
    result.fold(
      (failure) => state = state.copyWith(
        status: ExamDetailStatus.error,
        errorMessage: failure.message,
      ),
      (created) => state = state.copyWith(
        status: ExamDetailStatus.success,
        exam: created,
      ),
    );
  }

  Future<void> updateExam(Exam exam) async {
    final result = await _updateExamUseCase(exam);
    result.fold(
      (failure) => state = state.copyWith(
        status: ExamDetailStatus.error,
        errorMessage: failure.message,
      ),
      (updated) => state = state.copyWith(
        status: ExamDetailStatus.success,
        exam: updated,
      ),
    );
  }

  Future<void> deleteExam(String id) async {
    final result = await _deleteExamUseCase(DeleteExamParams(id));
    return result.fold(
      (failure) => state = state.copyWith(
        status: ExamDetailStatus.error,
        errorMessage: failure.message,
      ),
      (_) => state = state.copyWith(status: ExamDetailStatus.success),
    );
  }

  Future<void> publishExam(String id) async {
    final result = await _publishExamUseCase(PublishExamParams(id));
    result.fold(
      (failure) => state = state.copyWith(
        status: ExamDetailStatus.error,
        errorMessage: failure.message,
      ),
      (updated) => state = state.copyWith(
        status: ExamDetailStatus.success,
        exam: updated,
      ),
    );
  }

  Future<void> archiveExam(String id) async {
    final result = await _archiveExamUseCase(ArchiveExamParams(id));
    result.fold(
      (failure) => state = state.copyWith(
        status: ExamDetailStatus.error,
        errorMessage: failure.message,
      ),
      (updated) => state = state.copyWith(
        status: ExamDetailStatus.success,
        exam: updated,
      ),
    );
  }

  Future<void> duplicateExam(String id, String createdBy) async {
    final result = await _duplicateExamUseCase(
      DuplicateExamParams(examId: id, createdBy: createdBy),
    );
    result.fold(
      (failure) => state = state.copyWith(
        status: ExamDetailStatus.error,
        errorMessage: failure.message,
      ),
      (duplicated) => state = state.copyWith(
        status: ExamDetailStatus.success,
        exam: duplicated,
      ),
    );
  }
}

final examListProvider = StateNotifierProvider<ExamListNotifier, ExamListState>(
  (ref) {
    final examRepository = ref.watch(examRepositoryProvider);
    final getExamsUseCase = GetExamsUseCase(examRepository);
    final searchExamsUseCase = SearchExamsUseCase(examRepository);
    return ExamListNotifier(getExamsUseCase, searchExamsUseCase);
  },
);

final examDetailProvider =
    StateNotifierProvider<ExamDetailNotifier, ExamDetailState>((ref) {
      final examRepository = ref.watch(examRepositoryProvider);
      final getExamByIdUseCase = GetExamByIdUseCase(examRepository);
      final createExamUseCase = CreateExamUseCase(examRepository);
      final updateExamUseCase = UpdateExamUseCase(examRepository);
      final deleteExamUseCase = DeleteExamUseCase(examRepository);
      final publishExamUseCase = PublishExamUseCase(examRepository);
      final archiveExamUseCase = ArchiveExamUseCase(examRepository);
      final duplicateExamUseCase = DuplicateExamUseCase(examRepository);
      return ExamDetailNotifier(
        getExamByIdUseCase,
        createExamUseCase,
        updateExamUseCase,
        deleteExamUseCase,
        publishExamUseCase,
        archiveExamUseCase,
        duplicateExamUseCase,
      );
    });
