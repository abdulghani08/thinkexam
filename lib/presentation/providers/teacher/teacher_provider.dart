import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/di/teacher_providers.dart';
import '../../../domain/entities/teacher.dart';
import '../../../domain/usecases/teacher/create_teacher_usecase.dart';
import '../../../domain/usecases/teacher/delete_teacher_usecase.dart';
import '../../../domain/usecases/teacher/get_teachers_usecase.dart';
import '../../../domain/usecases/teacher/search_teachers_usecase.dart';
import '../../../domain/usecases/teacher/update_teacher_usecase.dart';

enum TeacherListStatus { initial, loading, success, error }

class TeacherListState {
  final TeacherListStatus status;
  final List<Teacher> teachers;
  final String query;
  final String? nextCursor;
  final bool hasMore;
  final bool isLoadingMore;
  final String? errorMessage;

  const TeacherListState({
    this.status = TeacherListStatus.initial,
    this.teachers = const [],
    this.query = '',
    this.nextCursor,
    this.hasMore = false,
    this.isLoadingMore = false,
    this.errorMessage,
  });

  TeacherListState copyWith({
    TeacherListStatus? status,
    List<Teacher>? teachers,
    String? query,
    String? nextCursor,
    bool? hasMore,
    bool? isLoadingMore,
    String? errorMessage,
  }) => TeacherListState(
    status: status ?? this.status,
    teachers: teachers ?? this.teachers,
    query: query ?? this.query,
    nextCursor: nextCursor ?? this.nextCursor,
    hasMore: hasMore ?? this.hasMore,
    isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    errorMessage: errorMessage,
  );
}

class TeacherListNotifier extends StateNotifier<TeacherListState> {
  final GetTeachersUseCase _getTeachers;
  final SearchTeachersUseCase _searchTeachers;
  final CreateTeacherUseCase _createTeacher;
  final UpdateTeacherUseCase _updateTeacher;
  final DeleteTeacherUseCase _deleteTeacher;

  TeacherListNotifier({
    required GetTeachersUseCase getTeachers,
    required SearchTeachersUseCase searchTeachers,
    required CreateTeacherUseCase createTeacher,
    required UpdateTeacherUseCase updateTeacher,
    required DeleteTeacherUseCase deleteTeacher,
  }) : _getTeachers = getTeachers,
       _searchTeachers = searchTeachers,
       _createTeacher = createTeacher,
       _updateTeacher = updateTeacher,
       _deleteTeacher = deleteTeacher,
       super(const TeacherListState());

  Future<void> loadTeachers({String query = ''}) async {
    state = TeacherListState(status: TeacherListStatus.loading, query: query);
    final result = query.trim().isEmpty
        ? await _getTeachers(const GetTeachersParams())
        : await _searchTeachers(SearchTeachersParams(query: query));
    result.fold(
      (failure) => state = state.copyWith(
        status: TeacherListStatus.error,
        errorMessage: failure.message,
      ),
      (page) => state = state.copyWith(
        status: TeacherListStatus.success,
        teachers: page.teachers,
        nextCursor: page.nextCursor,
        hasMore: page.hasMore,
      ),
    );
  }

  Future<void> loadMore() async {
    if (!state.hasMore || state.isLoadingMore || state.nextCursor == null)
      return;
    state = state.copyWith(isLoadingMore: true, errorMessage: null);
    final result = state.query.trim().isEmpty
        ? await _getTeachers(GetTeachersParams(cursor: state.nextCursor))
        : await _searchTeachers(
            SearchTeachersParams(query: state.query, cursor: state.nextCursor),
          );
    result.fold(
      (failure) => state = state.copyWith(
        isLoadingMore: false,
        errorMessage: failure.message,
      ),
      (page) => state = state.copyWith(
        teachers: [...state.teachers, ...page.teachers],
        nextCursor: page.nextCursor,
        hasMore: page.hasMore,
        isLoadingMore: false,
      ),
    );
  }

  Future<String?> createTeacher(Teacher teacher) async {
    final result = await _createTeacher(teacher);
    String? error;
    await result.fold<Future<void>>(
      (failure) async => error = failure.message,
      (_) => loadTeachers(query: state.query),
    );
    return error;
  }

  Future<String?> updateTeacher(Teacher teacher) async {
    final result = await _updateTeacher(teacher);
    String? error;
    await result.fold<Future<void>>(
      (failure) async => error = failure.message,
      (_) => loadTeachers(query: state.query),
    );
    return error;
  }

  Future<String?> deleteTeacher(String id) async {
    final result = await _deleteTeacher(id);
    String? error;
    await result.fold<Future<void>>(
      (failure) async => error = failure.message,
      (_) => loadTeachers(query: state.query),
    );
    return error;
  }
}

final teacherListProvider =
    StateNotifierProvider<TeacherListNotifier, TeacherListState>((ref) {
      return TeacherListNotifier(
        getTeachers: ref.watch(getTeachersUseCaseProvider),
        searchTeachers: ref.watch(searchTeachersUseCaseProvider),
        createTeacher: ref.watch(createTeacherUseCaseProvider),
        updateTeacher: ref.watch(updateTeacherUseCaseProvider),
        deleteTeacher: ref.watch(deleteTeacherUseCaseProvider),
      );
    });

/// Loads one teacher record for detail and edit screens.
final teacherDetailProvider = FutureProvider.autoDispose
    .family<Teacher, String>((ref, id) async {
      final result = await ref.read(getTeacherByIdUseCaseProvider)(id);
      return result.fold<Teacher>(
        (failure) => throw StateError(failure.message),
        (teacher) => teacher,
      );
    });
