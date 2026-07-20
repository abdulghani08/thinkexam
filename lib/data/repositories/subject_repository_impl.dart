import 'package:dartz/dartz.dart';
import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../../core/logging/app_logger.dart';
import '../../domain/entities/subject.dart';
import '../../domain/entities/subject_page.dart';
import '../../domain/repositories/subject_repository.dart';
import '../datasources/firestore_subject_datasource.dart';
import '../models/subject_model.dart';
import 'base_repository_impl.dart';

class SubjectRepositoryImpl extends BaseRepositoryImpl
    implements SubjectRepository {
  final FirestoreSubjectDataSource dataSource;
  const SubjectRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, Subject>> createSubject(Subject subject) =>
      _runSubject(
        () => dataSource.createSubject(SubjectModel.fromEntity(subject)),
        'create subject',
      );

  @override
  Future<Either<Failure, Subject>> getSubjectById(String id) =>
      _runSubject(() => dataSource.getSubjectById(id), 'get subject');

  @override
  Future<Either<Failure, Subject>> updateSubject(Subject subject) =>
      _runSubject(
        () => dataSource.updateSubject(SubjectModel.fromEntity(subject)),
        'update subject',
      );

  @override
  Future<Either<Failure, void>> deleteSubject(String id) async {
    try {
      await dataSource.deleteSubject(id);
      return const Right(null);
    } catch (error, stackTrace) {
      return Left(_mapFailure(error, 'delete subject', stackTrace));
    }
  }

  @override
  Future<Either<Failure, SubjectPage>> getSubjects({
    String? cursor,
    int limit = 20,
    bool includeArchived = false,
  }) =>
      _runPage(
        () => dataSource.getSubjects(cursor: cursor, limit: limit),
        limit,
        'get subjects',
      );

  @override
  Future<Either<Failure, SubjectPage>> searchSubjects(
    String query, {
    String? cursor,
    int limit = 20,
  }) => _runPage(
        () => dataSource.searchSubjects(query, cursor: cursor, limit: limit),
        limit,
        'search subjects',
      );

  Future<Either<Failure, Subject>> _runSubject(
    Future<SubjectModel> Function() action,
    String operation,
  ) async {
    try {
      return Right((await action()).toEntity());
    } catch (error, stackTrace) {
      return Left(_mapFailure(error, operation, stackTrace));
    }
  }

  Future<Either<Failure, SubjectPage>> _runPage(
    Future<List<SubjectModel>> Function() action,
    int limit,
    String operation,
  ) async {
    try {
      final results = await action();
      final hasMore = results.length > limit;
      final subjects = results
          .take(limit)
          .map((model) => model.toEntity())
          .toList();
      return Right(
        SubjectPage(
          subjects: subjects,
          hasMore: hasMore,
          nextCursor: subjects.isEmpty ? null : subjects.last.id,
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
