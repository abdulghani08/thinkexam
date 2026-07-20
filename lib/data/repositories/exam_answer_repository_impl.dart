import 'package:dartz/dartz.dart';
import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../../core/logging/app_logger.dart';
import '../../domain/entities/exam_answer.dart';
import '../../domain/repositories/exam_answer_repository.dart';
import '../datasources/firestore_exam_answer_datasource.dart';
import '../models/exam_answer_model.dart';
import 'base_repository_impl.dart';

class ExamAnswerRepositoryImpl extends BaseRepositoryImpl
    implements ExamAnswerRepository {
  final FirestoreExamAnswerDataSource _dataSource;

  const ExamAnswerRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, ExamAnswer>> createAnswer(ExamAnswer answer) async {
    try {
      final model = ExamAnswerModel(
        id: answer.id,
        sessionId: answer.sessionId,
        questionId: answer.questionId,
        selectedAnswer: answer.selectedAnswer,
        isCorrect: answer.isCorrect,
        answeredAt: answer.answeredAt,
      );
      final data = await _dataSource.createAnswer(model.toCreateMap());
      final createdModel = ExamAnswerModel.fromFirestore(data, data['id'] as String);
      return Right(createdModel.toEntity());
    } catch (error, stackTrace) {
      AppLogger.e('Failed to create exam answer', error, stackTrace);
      return Left(_mapFailure(error));
    }
  }

  @override
  Future<Either<Failure, void>> updateAnswer(ExamAnswer answer) async {
    try {
      final model = ExamAnswerModel(
        id: answer.id,
        sessionId: answer.sessionId,
        questionId: answer.questionId,
        selectedAnswer: answer.selectedAnswer,
        isCorrect: answer.isCorrect,
        answeredAt: answer.answeredAt,
      );
      await _dataSource.updateAnswer(answer.id, model.toUpdateMap());
      return const Right(null);
    } catch (error, stackTrace) {
      AppLogger.e('Failed to update exam answer', error, stackTrace);
      return Left(_mapFailure(error));
    }
  }

  @override
  Future<Either<Failure, List<ExamAnswer>>> getAnswersBySession(
    String sessionId,
  ) async {
    try {
      final dataList = await _dataSource.getAnswersBySession(sessionId);
      final answers = dataList.map((data) {
        final model = ExamAnswerModel.fromFirestore(data, data['id'] as String);
        return model.toEntity();
      }).toList();
      return Right(answers);
    } catch (error, stackTrace) {
      AppLogger.e('Failed to get exam answers by session', error, stackTrace);
      return Left(_mapFailure(error));
    }
  }

  @override
  Future<Either<Failure, ExamAnswer?>> getAnswerBySessionAndQuestion(
    String sessionId,
    String questionId,
  ) async {
    try {
      final data = await _dataSource.getAnswerBySessionAndQuestion(
        sessionId,
        questionId,
      );
      if (data == null) {
        return const Right(null);
      }
      final model = ExamAnswerModel.fromFirestore(data, data['id'] as String);
      return Right(model.toEntity());
    } catch (error, stackTrace) {
      AppLogger.e('Failed to get exam answer', error, stackTrace);
      return Left(_mapFailure(error));
    }
  }

  @override
  Future<Either<Failure, void>> createAnswersBatch(
    List<ExamAnswer> answers,
  ) async {
    try {
      final dataList = answers.map((answer) {
        final model = ExamAnswerModel(
          id: answer.id,
          sessionId: answer.sessionId,
          questionId: answer.questionId,
          selectedAnswer: answer.selectedAnswer,
          isCorrect: answer.isCorrect,
          answeredAt: answer.answeredAt,
        );
        return model.toCreateMap();
      }).toList();
      await _dataSource.createAnswersBatch(dataList);
      return const Right(null);
    } catch (error, stackTrace) {
      AppLogger.e('Failed to batch create exam answers', error, stackTrace);
      return Left(_mapFailure(error));
    }
  }

  @override
  Future<Either<Failure, void>> deleteAnswersBySession(String sessionId) async {
    try {
      await _dataSource.deleteAnswersBySession(sessionId);
      return const Right(null);
    } catch (error, stackTrace) {
      AppLogger.e('Failed to delete exam answers', error, stackTrace);
      return Left(_mapFailure(error));
    }
  }

  Failure _mapFailure(Object error) {
    if (error is NotFoundException)
      return NotFoundFailure(error.message, code: error.code);
    if (error is ServerException)
      return ServerFailure(error.message, code: error.code);
    return UnknownFailure('Failed to process exam answer');
  }
}
