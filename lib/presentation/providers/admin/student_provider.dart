import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/error/failures.dart';
import '../../../domain/entities/student.dart';
import '../../../domain/entities/student_page.dart';
import '../../../domain/repositories/student_repository.dart';
import '../../../core/di/student_providers.dart';
import '../../../domain/usecases/student/create_student_usecase.dart';
import '../../../domain/usecases/student/delete_student_usecase.dart';
import '../../../domain/usecases/student/get_student_by_id_usecase.dart';
import '../../../domain/usecases/student/get_students_usecase.dart';
import '../../../domain/usecases/student/search_students_usecase.dart';
import '../../../domain/usecases/student/update_student_usecase.dart';

enum StudentListStatus { initial, loading, success, error }

class StudentListState {
  final StudentListStatus status;
  final List<Student> students;
  final String? errorMessage;
  final bool hasMore;
  final String? nextCursor;
  final String? currentQuery;
  final String? currentClassId;

  const StudentListState({
    this.status = StudentListStatus.initial,
    this.students = const [],
    this.errorMessage,
    this.hasMore = false,
    this.nextCursor,
    this.currentQuery,
    this.currentClassId,
  });

  StudentListState copyWith({
    StudentListStatus? status,
    List<Student>? students,
    String? errorMessage,
    bool? hasMore,
    String? nextCursor,
    String? currentQuery,
    String? currentClassId,
  }) => StudentListState(
    status: status ?? this.status,
    students: students ?? this.students,
    errorMessage: errorMessage ?? this.errorMessage,
    hasMore: hasMore ?? this.hasMore,
    nextCursor: nextCursor ?? this.nextCursor,
    currentQuery: currentQuery ?? this.currentQuery,
    currentClassId: currentClassId ?? this.currentClassId,
  );
}

class StudentListNotifier extends StateNotifier<StudentListState> {
  final GetStudentsUseCase _getStudentsUseCase;
  final SearchStudentsUseCase _searchStudentsUseCase;

  StudentListNotifier(this._getStudentsUseCase, this._searchStudentsUseCase)
    : super(const StudentListState());

  Future<void> loadStudents({String? classId, bool refresh = false}) async {
    if (refresh) {
      state = state.copyWith(
        status: StudentListStatus.loading,
        students: [],
        nextCursor: null,
      );
    } else if (state.status == StudentListStatus.loading) {
      return;
    }

    final result = await _getStudentsUseCase(
      GetStudentsParams(
        cursor: refresh ? null : state.nextCursor,
        limit: 20,
        classId: classId ?? state.currentClassId,
      ),
    );

    result.fold(
      (failure) => state = state.copyWith(
        status: StudentListStatus.error,
        errorMessage: failure.message,
      ),
      (page) => state = state.copyWith(
        status: StudentListStatus.success,
        students: refresh
            ? page.students
            : [...state.students, ...page.students],
        hasMore: page.hasMore,
        nextCursor: page.nextCursor,
        currentClassId: classId ?? state.currentClassId,
      ),
    );
  }

  Future<void> searchStudents(String query, {String? classId}) async {
    state = state.copyWith(
      status: StudentListStatus.loading,
      students: [],
      nextCursor: null,
      currentQuery: query,
      currentClassId: classId,
    );

    final result = await _searchStudentsUseCase(
      SearchStudentsParams(query: query, limit: 20, classId: classId),
    );

    result.fold(
      (failure) => state = state.copyWith(
        status: StudentListStatus.error,
        errorMessage: failure.message,
      ),
      (page) => state = state.copyWith(
        status: StudentListStatus.success,
        students: page.students,
        hasMore: page.hasMore,
        nextCursor: page.nextCursor,
      ),
    );
  }

  Future<void> loadMore() async {
    if (!state.hasMore || state.status == StudentListStatus.loading) return;

    if (state.currentQuery != null && state.currentQuery!.isNotEmpty) {
      final result = await _searchStudentsUseCase(
        SearchStudentsParams(
          query: state.currentQuery!,
          cursor: state.nextCursor,
          limit: 20,
          classId: state.currentClassId,
        ),
      );

      result.fold(
        (failure) => state = state.copyWith(
          status: StudentListStatus.error,
          errorMessage: failure.message,
        ),
        (page) => state = state.copyWith(
          status: StudentListStatus.success,
          students: [...state.students, ...page.students],
          hasMore: page.hasMore,
          nextCursor: page.nextCursor,
        ),
      );
    } else {
      await loadStudents();
    }
  }
}

enum StudentDetailStatus { initial, loading, success, error }

class StudentDetailState {
  final StudentDetailStatus status;
  final Student? student;
  final String? errorMessage;

  const StudentDetailState({
    this.status = StudentDetailStatus.initial,
    this.student,
    this.errorMessage,
  });

  StudentDetailState copyWith({
    StudentDetailStatus? status,
    Student? student,
    String? errorMessage,
  }) => StudentDetailState(
    status: status ?? this.status,
    student: student ?? this.student,
    errorMessage: errorMessage ?? this.errorMessage,
  );
}

class StudentDetailNotifier extends StateNotifier<StudentDetailState> {
  final GetStudentByIdUseCase _getStudentByIdUseCase;
  final CreateStudentUseCase _createStudentUseCase;
  final UpdateStudentUseCase _updateStudentUseCase;
  final DeleteStudentUseCase _deleteStudentUseCase;

  StudentDetailNotifier(
    this._getStudentByIdUseCase,
    this._createStudentUseCase,
    this._updateStudentUseCase,
    this._deleteStudentUseCase,
  ) : super(const StudentDetailState());

  Future<void> loadStudent(String id) async {
    state = state.copyWith(status: StudentDetailStatus.loading);
    final result = await _getStudentByIdUseCase(GetStudentByIdParams(id));
    result.fold(
      (failure) => state = state.copyWith(
        status: StudentDetailStatus.error,
        errorMessage: failure.message,
      ),
      (student) => state = state.copyWith(
        status: StudentDetailStatus.success,
        student: student,
      ),
    );
  }

  Future<void> createStudent(Student student) async {
    final result = await _createStudentUseCase(student);
    result.fold(
      (failure) => state = state.copyWith(
        status: StudentDetailStatus.error,
        errorMessage: failure.message,
      ),
      (created) => state = state.copyWith(
        status: StudentDetailStatus.success,
        student: created,
      ),
    );
  }

  Future<void> updateStudent(Student student) async {
    final result = await _updateStudentUseCase(student);
    result.fold(
      (failure) => state = state.copyWith(
        status: StudentDetailStatus.error,
        errorMessage: failure.message,
      ),
      (updated) => state = state.copyWith(
        status: StudentDetailStatus.success,
        student: updated,
      ),
    );
  }

  Future<void> deleteStudent(String id) async {
    final result = await _deleteStudentUseCase(DeleteStudentParams(id));
    return result.fold(
      (failure) => state = state.copyWith(
        status: StudentDetailStatus.error,
        errorMessage: failure.message,
      ),
      (_) => state = state.copyWith(status: StudentDetailStatus.success),
    );
  }
}

final studentListProvider =
    StateNotifierProvider<StudentListNotifier, StudentListState>((ref) {
      final studentRepository = ref.watch(studentRepositoryProvider);
      final getStudentsUseCase = GetStudentsUseCase(studentRepository);
      final searchStudentsUseCase = SearchStudentsUseCase(studentRepository);
      return StudentListNotifier(getStudentsUseCase, searchStudentsUseCase);
    });

final studentDetailProvider =
    StateNotifierProvider<StudentDetailNotifier, StudentDetailState>((ref) {
      final studentRepository = ref.watch(studentRepositoryProvider);
      final getStudentByIdUseCase = GetStudentByIdUseCase(studentRepository);
      final createStudentUseCase = CreateStudentUseCase(studentRepository);
      final updateStudentUseCase = UpdateStudentUseCase(studentRepository);
      final deleteStudentUseCase = DeleteStudentUseCase(studentRepository);
      return StudentDetailNotifier(
        getStudentByIdUseCase,
        createStudentUseCase,
        updateStudentUseCase,
        deleteStudentUseCase,
      );
    });
