import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/error/failures.dart';
import '../../../domain/entities/subject.dart';
import '../../../domain/entities/subject_page.dart';
import '../../../domain/repositories/subject_repository.dart';
import '../../../core/di/subject_providers.dart';
import '../../../domain/usecases/subject/create_subject_usecase.dart';
import '../../../domain/usecases/subject/delete_subject_usecase.dart';
import '../../../domain/usecases/subject/get_subject_by_id_usecase.dart';
import '../../../domain/usecases/subject/get_subjects_usecase.dart';
import '../../../domain/usecases/subject/search_subjects_usecase.dart';
import '../../../domain/usecases/subject/update_subject_usecase.dart';

enum SubjectListStatus { initial, loading, success, error }

class SubjectListState {
  final SubjectListStatus status;
  final List<Subject> subjects;
  final String? errorMessage;
  final bool hasMore;
  final String? nextCursor;
  final String? currentQuery;

  const SubjectListState({
    this.status = SubjectListStatus.initial,
    this.subjects = const [],
    this.errorMessage,
    this.hasMore = false,
    this.nextCursor,
    this.currentQuery,
  });

  SubjectListState copyWith({
    SubjectListStatus? status,
    List<Subject>? subjects,
    String? errorMessage,
    bool? hasMore,
    String? nextCursor,
    String? currentQuery,
  }) => SubjectListState(
    status: status ?? this.status,
    subjects: subjects ?? this.subjects,
    errorMessage: errorMessage ?? this.errorMessage,
    hasMore: hasMore ?? this.hasMore,
    nextCursor: nextCursor ?? this.nextCursor,
    currentQuery: currentQuery ?? this.currentQuery,
  );
}

class SubjectListNotifier extends StateNotifier<SubjectListState> {
  final GetSubjectsUseCase _getSubjectsUseCase;
  final SearchSubjectsUseCase _searchSubjectsUseCase;

  SubjectListNotifier(this._getSubjectsUseCase, this._searchSubjectsUseCase)
    : super(const SubjectListState());

  Future<void> loadSubjects({bool refresh = false}) async {
    if (refresh) {
      state = state.copyWith(
        status: SubjectListStatus.loading,
        subjects: [],
        nextCursor: null,
      );
    } else if (state.status == SubjectListStatus.loading) {
      return;
    }

    final result = await _getSubjectsUseCase(
      GetSubjectsParams(cursor: refresh ? null : state.nextCursor, limit: 20),
    );

    result.fold(
      (failure) => state = state.copyWith(
        status: SubjectListStatus.error,
        errorMessage: failure.message,
      ),
      (page) => state = state.copyWith(
        status: SubjectListStatus.success,
        subjects: refresh
            ? page.subjects
            : [...state.subjects, ...page.subjects],
        hasMore: page.hasMore,
        nextCursor: page.nextCursor,
      ),
    );
  }

  Future<void> searchSubjects(String query) async {
    state = state.copyWith(
      status: SubjectListStatus.loading,
      subjects: [],
      nextCursor: null,
      currentQuery: query,
    );

    final result = await _searchSubjectsUseCase(
      SearchSubjectsParams(query: query, limit: 20),
    );

    result.fold(
      (failure) => state = state.copyWith(
        status: SubjectListStatus.error,
        errorMessage: failure.message,
      ),
      (page) => state = state.copyWith(
        status: SubjectListStatus.success,
        subjects: page.subjects,
        hasMore: page.hasMore,
        nextCursor: page.nextCursor,
      ),
    );
  }

  Future<void> loadMore() async {
    if (!state.hasMore || state.status == SubjectListStatus.loading) return;

    if (state.currentQuery != null && state.currentQuery!.isNotEmpty) {
      final result = await _searchSubjectsUseCase(
        SearchSubjectsParams(
          query: state.currentQuery!,
          cursor: state.nextCursor,
          limit: 20,
        ),
      );

      result.fold(
        (failure) => state = state.copyWith(
          status: SubjectListStatus.error,
          errorMessage: failure.message,
        ),
        (page) => state = state.copyWith(
          status: SubjectListStatus.success,
          subjects: [...state.subjects, ...page.subjects],
          hasMore: page.hasMore,
          nextCursor: page.nextCursor,
        ),
      );
    } else {
      await loadSubjects();
    }
  }
}

enum SubjectDetailStatus { initial, loading, success, error }

class SubjectDetailState {
  final SubjectDetailStatus status;
  final Subject? subject;
  final String? errorMessage;

  const SubjectDetailState({
    this.status = SubjectDetailStatus.initial,
    this.subject,
    this.errorMessage,
  });

  SubjectDetailState copyWith({
    SubjectDetailStatus? status,
    Subject? subject,
    String? errorMessage,
  }) => SubjectDetailState(
    status: status ?? this.status,
    subject: subject ?? this.subject,
    errorMessage: errorMessage ?? this.errorMessage,
  );
}

class SubjectDetailNotifier extends StateNotifier<SubjectDetailState> {
  final GetSubjectByIdUseCase _getSubjectByIdUseCase;
  final CreateSubjectUseCase _createSubjectUseCase;
  final UpdateSubjectUseCase _updateSubjectUseCase;
  final DeleteSubjectUseCase _deleteSubjectUseCase;

  SubjectDetailNotifier(
    this._getSubjectByIdUseCase,
    this._createSubjectUseCase,
    this._updateSubjectUseCase,
    this._deleteSubjectUseCase,
  ) : super(const SubjectDetailState());

  Future<void> loadSubject(String id) async {
    state = state.copyWith(status: SubjectDetailStatus.loading);
    final result = await _getSubjectByIdUseCase(GetSubjectByIdParams(id));
    result.fold(
      (failure) => state = state.copyWith(
        status: SubjectDetailStatus.error,
        errorMessage: failure.message,
      ),
      (subject) => state = state.copyWith(
        status: SubjectDetailStatus.success,
        subject: subject,
      ),
    );
  }

  Future<void> createSubject(Subject subject) async {
    final result = await _createSubjectUseCase(subject);
    result.fold(
      (failure) => state = state.copyWith(
        status: SubjectDetailStatus.error,
        errorMessage: failure.message,
      ),
      (created) => state = state.copyWith(
        status: SubjectDetailStatus.success,
        subject: created,
      ),
    );
  }

  Future<void> updateSubject(Subject subject) async {
    final result = await _updateSubjectUseCase(subject);
    result.fold(
      (failure) => state = state.copyWith(
        status: SubjectDetailStatus.error,
        errorMessage: failure.message,
      ),
      (updated) => state = state.copyWith(
        status: SubjectDetailStatus.success,
        subject: updated,
      ),
    );
  }

  Future<void> deleteSubject(String id) async {
    final result = await _deleteSubjectUseCase(DeleteSubjectParams(id));
    return result.fold(
      (failure) => state = state.copyWith(
        status: SubjectDetailStatus.error,
        errorMessage: failure.message,
      ),
      (_) => state = state.copyWith(status: SubjectDetailStatus.success),
    );
  }
}

final subjectListProvider =
    StateNotifierProvider<SubjectListNotifier, SubjectListState>((ref) {
      final subjectRepository = ref.watch(subjectRepositoryProvider);
      final getSubjectsUseCase = GetSubjectsUseCase(subjectRepository);
      final searchSubjectsUseCase = SearchSubjectsUseCase(subjectRepository);
      return SubjectListNotifier(getSubjectsUseCase, searchSubjectsUseCase);
    });

final subjectDetailProvider =
    StateNotifierProvider<SubjectDetailNotifier, SubjectDetailState>((ref) {
      final subjectRepository = ref.watch(subjectRepositoryProvider);
      final getSubjectByIdUseCase = GetSubjectByIdUseCase(subjectRepository);
      final createSubjectUseCase = CreateSubjectUseCase(subjectRepository);
      final updateSubjectUseCase = UpdateSubjectUseCase(subjectRepository);
      final deleteSubjectUseCase = DeleteSubjectUseCase(subjectRepository);
      return SubjectDetailNotifier(
        getSubjectByIdUseCase,
        createSubjectUseCase,
        updateSubjectUseCase,
        deleteSubjectUseCase,
      );
    });
