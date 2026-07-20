import 'package:dartz/dartz.dart';
import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../../core/logging/app_logger.dart';
import '../../domain/entities/class_room.dart';
import '../../domain/entities/class_page.dart';
import '../../domain/repositories/class_repository.dart';
import '../datasources/firestore_class_datasource.dart';
import '../models/class_model.dart';
import 'base_repository_impl.dart';

class ClassRepositoryImpl extends BaseRepositoryImpl implements ClassRepository {
  final FirestoreClassDataSource dataSource;
  const ClassRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, ClassRoom>> createClass(ClassRoom classRoom) =>
      _runClass(
        () => dataSource.createClass(ClassModel.fromEntity(classRoom)),
        'create class',
      );

  @override
  Future<Either<Failure, ClassRoom>> getClassById(String id) =>
      _runClass(() => dataSource.getClassById(id), 'get class');

  @override
  Future<Either<Failure, ClassRoom>> updateClass(ClassRoom classRoom) =>
      _runClass(
        () => dataSource.updateClass(ClassModel.fromEntity(classRoom)),
        'update class',
      );

  @override
  Future<Either<Failure, void>> deleteClass(String id) async {
    try {
      await dataSource.deleteClass(id);
      return const Right(null);
    } catch (error, stackTrace) {
      return Left(_mapFailure(error, 'delete class', stackTrace));
    }
  }

  @override
  Future<Either<Failure, ClassPage>> getClasses({
    String? cursor,
    int limit = 20,
    bool includeArchived = false,
  }) =>
      _runPage(
        () => dataSource.getClasses(cursor: cursor, limit: limit),
        limit,
        'get classes',
      );

  @override
  Future<Either<Failure, ClassPage>> searchClasses(
    String query, {
    String? cursor,
    int limit = 20,
  }) => _runPage(
        () => dataSource.searchClasses(query, cursor: cursor, limit: limit),
        limit,
        'search classes',
      );

  @override
  Future<Either<Failure, List<ClassRoom>>> getClassesByGrade(
    int grade,
  ) async {
    try {
      final results = await dataSource.getClassesByGrade(grade);
      return Right(results.map((model) => model.toEntity()).toList());
    } catch (error, stackTrace) {
      return Left(_mapFailure(error, 'get classes by grade', stackTrace));
    }
  }

  Future<Either<Failure, ClassRoom>> _runClass(
    Future<ClassModel> Function() action,
    String operation,
  ) async {
    try {
      return Right((await action()).toEntity());
    } catch (error, stackTrace) {
      return Left(_mapFailure(error, operation, stackTrace));
    }
  }

  Future<Either<Failure, ClassPage>> _runPage(
    Future<List<ClassModel>> Function() action,
    int limit,
    String operation,
  ) async {
    try {
      final results = await action();
      final hasMore = results.length > limit;
      final classes = results
          .take(limit)
          .map((model) => model.toEntity())
          .toList();
      return Right(
        ClassPage(
          classes: classes,
          hasMore: hasMore,
          nextCursor: classes.isEmpty ? null : classes.last.id,
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
