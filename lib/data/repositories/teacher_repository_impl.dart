import 'package:dartz/dartz.dart';
import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../../core/logging/app_logger.dart';
import '../../domain/entities/teacher.dart';
import '../../domain/entities/teacher_page.dart';
import '../../domain/repositories/teacher_repository.dart';
import '../datasources/firestore_teacher_datasource.dart';
import '../models/teacher_model.dart';
import 'base_repository_impl.dart';

class TeacherRepositoryImpl extends BaseRepositoryImpl
    implements TeacherRepository {
  final FirestoreTeacherDataSource dataSource;
  const TeacherRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, Teacher>> createTeacher(Teacher teacher) =>
      _runTeacher(
        () => dataSource.createTeacher(TeacherModel.fromEntity(teacher)),
        'create teacher',
      );

  @override
  Future<Either<Failure, Teacher>> getTeacherById(String id) =>
      _runTeacher(() => dataSource.getTeacherById(id), 'get teacher');

  @override
  Future<Either<Failure, Teacher>> updateTeacher(Teacher teacher) =>
      _runTeacher(
        () => dataSource.updateTeacher(TeacherModel.fromEntity(teacher)),
        'update teacher',
      );

  @override
  Future<Either<Failure, void>> deleteTeacher(String id) async {
    try {
      await dataSource.deleteTeacher(id);
      return const Right(null);
    } catch (error, stackTrace) {
      return Left(_mapFailure(error, 'delete teacher', stackTrace));
    }
  }

  @override
  Future<Either<Failure, TeacherPage>> getTeachers({
    String? cursor,
    int limit = 20,
  }) => _runPage(
    () => dataSource.getTeachers(cursor: cursor, limit: limit),
    limit,
    'get teachers',
  );

  @override
  Future<Either<Failure, TeacherPage>> searchTeachers(
    String query, {
    String? cursor,
    int limit = 20,
  }) => _runPage(
    () => dataSource.searchTeachers(query, cursor: cursor, limit: limit),
    limit,
    'search teachers',
  );

  Future<Either<Failure, Teacher>> _runTeacher(
    Future<TeacherModel> Function() action,
    String operation,
  ) async {
    try {
      return Right((await action()).toEntity());
    } catch (error, stackTrace) {
      return Left(_mapFailure(error, operation, stackTrace));
    }
  }

  Future<Either<Failure, TeacherPage>> _runPage(
    Future<List<TeacherModel>> Function() action,
    int limit,
    String operation,
  ) async {
    try {
      final results = await action();
      final hasMore = results.length > limit;
      final teachers = results
          .take(limit)
          .map((model) => model.toEntity())
          .toList();
      return Right(
        TeacherPage(
          teachers: teachers,
          hasMore: hasMore,
          nextCursor: teachers.isEmpty ? null : teachers.last.id,
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
