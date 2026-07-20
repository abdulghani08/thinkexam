import 'package:dartz/dartz.dart';
import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../../core/logging/app_logger.dart';
import '../../domain/entities/student.dart';
import '../../domain/entities/student_page.dart';
import '../../domain/repositories/student_repository.dart';
import '../datasources/firestore_student_datasource.dart';
import '../models/student_model.dart';
import 'base_repository_impl.dart';

class StudentRepositoryImpl extends BaseRepositoryImpl
    implements StudentRepository {
  final FirestoreStudentDataSource dataSource;
  const StudentRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, Student>> createStudent(Student student) =>
      _runStudent(
        () => dataSource.createStudent(StudentModel.fromEntity(student)),
        'create student',
      );

  @override
  Future<Either<Failure, Student>> getStudentById(String id) =>
      _runStudent(() => dataSource.getStudentById(id), 'get student');

  @override
  Future<Either<Failure, Student>> updateStudent(Student student) =>
      _runStudent(
        () => dataSource.updateStudent(StudentModel.fromEntity(student)),
        'update student',
      );

  @override
  Future<Either<Failure, void>> deleteStudent(String id) async {
    try {
      await dataSource.deleteStudent(id);
      return const Right(null);
    } catch (error, stackTrace) {
      return Left(_mapFailure(error, 'delete student', stackTrace));
    }
  }

  @override
  Future<Either<Failure, StudentPage>> getStudents({
    String? cursor,
    int limit = 20,
    String? classId,
  }) => _runPage(
        () => dataSource.getStudents(cursor: cursor, limit: limit, classId: classId),
        limit,
        'get students',
      );

  @override
  Future<Either<Failure, StudentPage>> searchStudents(
    String query, {
    String? cursor,
    int limit = 20,
    String? classId,
  }) => _runPage(
        () => dataSource.searchStudents(query, cursor: cursor, limit: limit, classId: classId),
        limit,
        'search students',
      );

  @override
  Future<Either<Failure, List<Student>>> getStudentsByClassId(
    String classId,
  ) async {
    try {
      final results = await dataSource.getStudentsByClassId(classId);
      return Right(results.map((model) => model.toEntity()).toList());
    } catch (error, stackTrace) {
      return Left(_mapFailure(error, 'get students by class', stackTrace));
    }
  }

  Future<Either<Failure, Student>> _runStudent(
    Future<StudentModel> Function() action,
    String operation,
  ) async {
    try {
      return Right((await action()).toEntity());
    } catch (error, stackTrace) {
      return Left(_mapFailure(error, operation, stackTrace));
    }
  }

  Future<Either<Failure, StudentPage>> _runPage(
    Future<List<StudentModel>> Function() action,
    int limit,
    String operation,
  ) async {
    try {
      final results = await action();
      final hasMore = results.length > limit;
      final students = results
          .take(limit)
          .map((model) => model.toEntity())
          .toList();
      return Right(
        StudentPage(
          students: students,
          hasMore: hasMore,
          nextCursor: students.isEmpty ? null : students.last.id,
        ),
      );
    } catch (error, stackTrace) {
      return Left(_mapFailure(error, operation, stackTrace));
    }
  }

  Failure _mapFailure(Object error, String operation, StackTrace stackTrace) {
    AppLogger.e('Failed to $operation', error, stackTrace);
    if (error is NotFoundException)
      return NotFoundFailure(error.message, code: error.code);
    if (error is ConflictException)
      return ConflictFailure(error.message, code: error.code);
    if (error is ServerException)
      return ServerFailure(error.message, code: error.code);
    return UnknownFailure('Failed to $operation');
  }
}
