import 'package:dartz/dartz.dart';
import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../../core/logging/app_logger.dart';
import '../../domain/entities/exam.dart';
import '../../domain/entities/exam_page.dart';
import '../../domain/repositories/exam_repository.dart';
import '../datasources/firestore_exam_datasource.dart';
import '../models/exam_model.dart';
import 'base_repository_impl.dart';

class ExamRepositoryImpl extends BaseRepositoryImpl implements ExamRepository {
  final FirestoreExamDataSource dataSource;
  const ExamRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, Exam>> createExam(Exam exam) => _runExam(
        () => dataSource.createExam(ExamModel.fromEntity(exam)),
        'create exam',
      );

  @override
  Future<Either<Failure, Exam>> getExamById(String id) =>
      _runExam(() => dataSource.getExamById(id), 'get exam');

  @override
  Future<Either<Failure, Exam>> updateExam(Exam exam) => _runExam(
        () => dataSource.updateExam(ExamModel.fromEntity(exam)),
        'update exam',
      );

  @override
  Future<Either<Failure, void>> deleteExam(String id) async {
    try {
      await dataSource.deleteExam(id);
      return const Right(null);
    } catch (error, stackTrace) {
      return Left(_mapFailure(error, 'delete exam', stackTrace));
    }
  }

  @override
  Future<Either<Failure, ExamPage>> getExams({
    String? cursor,
    int limit = 20,
    String? status,
  }) => _runPage(
        () => dataSource.getExams(cursor: cursor, limit: limit, status: status),
        limit,
        'get exams',
      );

  @override
  Future<Either<Failure, ExamPage>> searchExams(
    String query, {
    String? cursor,
    int limit = 20,
    String? status,
  }) => _runPage(
        () => dataSource.searchExams(query, cursor: cursor, limit: limit, status: status),
        limit,
        'search exams',
      );

  @override
  Future<Either<Failure, Exam>> duplicateExam(String examId, String createdBy) =>
      _runExam(
        () => dataSource.duplicateExam(examId, createdBy),
        'duplicate exam',
      );

  @override
  Future<Either<Failure, Exam>> publishExam(String examId) => _runExam(
        () => dataSource.publishExam(examId),
        'publish exam',
      );

  @override
  Future<Either<Failure, Exam>> archiveExam(String examId) => _runExam(
        () => dataSource.archiveExam(examId),
        'archive exam',
      );

  Future<Either<Failure, Exam>> _runExam(
    Future<ExamModel> Function() action,
    String operation,
  ) async {
    try {
      return Right((await action()).toEntity());
    } catch (error, stackTrace) {
      return Left(_mapFailure(error, operation, stackTrace));
    }
  }

  Future<Either<Failure, ExamPage>> _runPage(
    Future<List<ExamModel>> Function() action,
    int limit,
    String operation,
  ) async {
    try {
      final results = await action();
      final hasMore = results.length > limit;
      final exams = results
          .take(limit)
          .map((model) => model.toEntity())
          .toList();
      return Right(
        ExamPage(
          exams: exams,
          hasMore: hasMore,
          nextCursor: exams.isEmpty ? null : exams.last.id,
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
