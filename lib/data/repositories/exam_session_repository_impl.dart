import 'package:dartz/dartz.dart';
import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../../core/logging/app_logger.dart';
import '../../domain/entities/exam_session.dart';
import '../../domain/repositories/exam_session_repository.dart';
import '../datasources/firestore_exam_session_datasource.dart';
import '../models/exam_session_model.dart';
import 'base_repository_impl.dart';

class ExamSessionRepositoryImpl extends BaseRepositoryImpl
    implements ExamSessionRepository {
  final FirestoreExamSessionDataSource _dataSource;

  const ExamSessionRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, ExamSession>> createSession(ExamSession session) async {
    try {
      final model = ExamSessionModel(
        id: session.id,
        examId: session.examId,
        studentId: session.studentId,
        status: session.status.name,
        startTime: session.startTime,
        endTime: session.endTime,
        remainingTime: session.remainingTime,
        violationCount: session.violationCount,
        deviceId: session.deviceId,
      );
      final data = await _dataSource.createSession(model.toCreateMap());
      final createdModel = ExamSessionModel.fromFirestore(data, data['id'] as String);
      return Right(createdModel.toEntity());
    } catch (error, stackTrace) {
      AppLogger.e('Failed to create exam session', error, stackTrace);
      return Left(_mapFailure(error));
    }
  }

  @override
  Future<Either<Failure, ExamSession>> getSession(String id) async {
    try {
      final data = await _dataSource.getSession(id);
      final model = ExamSessionModel.fromFirestore(data, id);
      return Right(model.toEntity());
    } catch (error, stackTrace) {
      AppLogger.e('Failed to get exam session', error, stackTrace);
      return Left(_mapFailure(error));
    }
  }

  @override
  Future<Either<Failure, void>> updateSession(ExamSession session) async {
    try {
      final model = ExamSessionModel(
        id: session.id,
        examId: session.examId,
        studentId: session.studentId,
        status: session.status.name,
        startTime: session.startTime,
        endTime: session.endTime,
        remainingTime: session.remainingTime,
        violationCount: session.violationCount,
        deviceId: session.deviceId,
      );
      await _dataSource.updateSession(session.id, model.toUpdateMap());
      return const Right(null);
    } catch (error, stackTrace) {
      AppLogger.e('Failed to update exam session', error, stackTrace);
      return Left(_mapFailure(error));
    }
  }

  @override
  Future<Either<Failure, List<ExamSession>>> getSessionsByStudent(
    String studentId, {
    int limit = 20,
  }) async {
    try {
      final dataList = await _dataSource.getSessionsByStudent(studentId, limit: limit);
      final sessions = dataList.map((data) {
        final model = ExamSessionModel.fromFirestore(data, data['id'] as String);
        return model.toEntity();
      }).toList();
      return Right(sessions);
    } catch (error, stackTrace) {
      AppLogger.e('Failed to get exam sessions by student', error, stackTrace);
      return Left(_mapFailure(error));
    }
  }

  @override
  Future<Either<Failure, List<ExamSession>>> getSessionsByExam(
    String examId, {
    int limit = 20,
  }) async {
    try {
      final dataList = await _dataSource.getSessionsByExam(examId, limit: limit);
      final sessions = dataList.map((data) {
        final model = ExamSessionModel.fromFirestore(data, data['id'] as String);
        return model.toEntity();
      }).toList();
      return Right(sessions);
    } catch (error, stackTrace) {
      AppLogger.e('Failed to get exam sessions by exam', error, stackTrace);
      return Left(_mapFailure(error));
    }
  }

  Failure _mapFailure(Object error) {
    if (error is NotFoundException)
      return NotFoundFailure(error.message, code: error.code);
    if (error is ServerException)
      return ServerFailure(error.message, code: error.code);
    return UnknownFailure('Failed to process exam session');
  }
}
