import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/error/failures.dart';
import '../../../domain/entities/exam.dart';
import '../../../domain/entities/exam_page.dart';
import '../../../domain/entities/student.dart';
import '../../../domain/repositories/exam_repository.dart';
import '../../../domain/repositories/student_repository.dart';
import '../../../core/di/exam_providers.dart';
import '../../../core/di/student_providers.dart';
import '../../../domain/usecases/exam/get_exams_usecase.dart';
import '../../../domain/usecases/student/get_student_by_id_usecase.dart';

enum StudentDashboardStatus { initial, loading, success, error }

class StudentDashboardState {
  final StudentDashboardStatus status;
  final Student? student;
  final List<Exam> availableExams;
  final List<Exam> completedExams;
  final String? errorMessage;

  const StudentDashboardState({
    this.status = StudentDashboardStatus.initial,
    this.student,
    this.availableExams = const [],
    this.completedExams = const [],
    this.errorMessage,
  });

  StudentDashboardState copyWith({
    StudentDashboardStatus? status,
    Student? student,
    List<Exam>? availableExams,
    List<Exam>? completedExams,
    String? errorMessage,
  }) => StudentDashboardState(
    status: status ?? this.status,
    student: student ?? this.student,
    availableExams: availableExams ?? this.availableExams,
    completedExams: completedExams ?? this.completedExams,
    errorMessage: errorMessage ?? this.errorMessage,
  );
}

class StudentDashboardNotifier extends StateNotifier<StudentDashboardState> {
  final GetStudentByIdUseCase _getStudentByIdUseCase;
  final GetExamsUseCase _getExamsUseCase;

  StudentDashboardNotifier(this._getStudentByIdUseCase, this._getExamsUseCase)
    : super(const StudentDashboardState());

  Future<void> loadDashboard(String studentId) async {
    state = state.copyWith(status: StudentDashboardStatus.loading);

    final studentResult = await _getStudentByIdUseCase(
      GetStudentByIdParams(studentId),
    );
    final examsResult = await _getExamsUseCase(
      GetExamsParams(status: 'published', limit: 50),
    );

    studentResult.fold(
      (failure) => state = state.copyWith(
        status: StudentDashboardStatus.error,
        errorMessage: failure.message,
      ),
      (student) {
        examsResult.fold(
          (failure) => state = state.copyWith(
            status: StudentDashboardStatus.error,
            errorMessage: failure.message,
            student: student,
          ),
          (page) {
            final availableExams = page.exams
                .where((exam) => exam.allowedClassIds.contains(student.classId))
                .toList();

            state = state.copyWith(
              status: StudentDashboardStatus.success,
              student: student,
              availableExams: availableExams,
            );
          },
        );
      },
    );
  }
}

final studentDashboardProvider =
    StateNotifierProvider<StudentDashboardNotifier, StudentDashboardState>((
      ref,
    ) {
      final studentRepository = ref.watch(studentRepositoryProvider);
      final examRepository = ref.watch(examRepositoryProvider);
      final getStudentByIdUseCase = GetStudentByIdUseCase(studentRepository);
      final getExamsUseCase = GetExamsUseCase(examRepository);
      return StudentDashboardNotifier(getStudentByIdUseCase, getExamsUseCase);
    });
