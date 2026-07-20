import 'package:dartz/dartz.dart';
import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../../core/logging/app_logger.dart';
import '../../domain/entities/question.dart';
import '../../domain/entities/question_bank_item.dart';
import '../../domain/entities/question_bank_page.dart';
import '../../domain/repositories/question_repository.dart';
import '../datasources/firestore_question_datasource.dart';
import '../models/question_model.dart';
import 'base_repository_impl.dart';

class QuestionRepositoryImpl extends BaseRepositoryImpl
    implements QuestionRepository {
  final FirestoreQuestionDataSource dataSource;
  const QuestionRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, Question>> createQuestion(Question question) =>
      _runQuestion(
        () => dataSource.createQuestion(QuestionModel.fromEntity(question)),
        'create question',
      );

  @override
  Future<Either<Failure, Question>> getQuestionById(String id) =>
      _runQuestion(() => dataSource.getQuestionById(id), 'get question');

  @override
  Future<Either<Failure, Question>> updateQuestion(Question question) =>
      _runQuestion(
        () => dataSource.updateQuestion(QuestionModel.fromEntity(question)),
        'update question',
      );

  @override
  Future<Either<Failure, void>> deleteQuestion(String id) async {
    try {
      await dataSource.deleteQuestion(id);
      return const Right(null);
    } catch (error, stackTrace) {
      return Left(_mapFailure(error, 'delete question', stackTrace));
    }
  }

  @override
  Future<Either<Failure, QuestionBankPage>> getQuestionsByExamId(
    String examId, {
    String? cursor,
    int limit = 20,
  }) =>
      _runPage(
        () => dataSource.getQuestionsByExamId(examId),
        limit,
        'get questions by exam',
      );

  @override
  Future<Either<Failure, int>> countQuestionsByExamId(String examId) async {
    try {
      final questions = await dataSource.getQuestionsByExamId(examId);
      return Right(questions.length);
    } catch (error, stackTrace) {
      return Left(_mapFailure(error, 'count questions by exam', stackTrace));
    }
  }

  @override
  Future<Either<Failure, QuestionBankItem>> createBankItem(
    QuestionBankItem item,
  ) async {
    // TODO: implement when bank feature is ready
    return Left(
      const UnknownFailure('Bank item creation not yet implemented'),
    );
  }

  @override
  Future<Either<Failure, QuestionBankPage>> getBankItems({
    String? cursor,
    int limit = 20,
    String? subjectId,
  }) async {
    // TODO: implement when bank feature is ready
    return Left(
      const UnknownFailure('Bank items not yet implemented'),
    );
  }

  @override
  Future<Either<Failure, QuestionBankItem>> getBankItemById(String id) async {
    // TODO: implement when bank feature is ready
    return Left(
      const UnknownFailure('Bank item not yet implemented'),
    );
  }

  @override
  Future<Either<Failure, QuestionBankItem>> updateBankItem(
    QuestionBankItem item,
  ) async {
    // TODO: implement when bank feature is ready
    return Left(
      const UnknownFailure('Bank item update not yet implemented'),
    );
  }

  @override
  Future<Either<Failure, void>> deleteBankItem(String id) async {
    // TODO: implement when bank feature is ready
    return Left(
      const UnknownFailure('Bank item deletion not yet implemented'),
    );
  }

  @override
  Future<Either<Failure, QuestionBankPage>> searchBankItems(
    String query, {
    String? cursor,
    int limit = 20,
    String? subjectId,
  }) async {
    // TODO: implement when bank feature is ready
    return Left(
      const UnknownFailure('Bank item search not yet implemented'),
    );
  }

  @override
  Future<Either<Failure, Question>> importFromBank({
    required String examId,
    required String bankItemId,
    required int order,
  }) async {
    // TODO: implement when bank feature is ready
    return Left(
      const UnknownFailure('Import from bank not yet implemented'),
    );
  }

  @override
  Future<Either<Failure, void>> deleteQuestionsByExamId(String examId) async {
    try {
      await dataSource.deleteQuestionsByExamId(examId);
      return const Right(null);
    } catch (error, stackTrace) {
      return Left(_mapFailure(error, 'delete questions by exam', stackTrace));
    }
  }

  @override
  Future<Either<Failure, void>> reorderQuestions(
    List<Question> questions,
  ) async {
    try {
      await dataSource.reorderQuestions(
        questions.map((q) => QuestionModel.fromEntity(q)).toList(),
      );
      return const Right(null);
    } catch (error, stackTrace) {
      return Left(_mapFailure(error, 'reorder questions', stackTrace));
    }
  }

  Future<Either<Failure, Question>> _runQuestion(
    Future<QuestionModel> Function() action,
    String operation,
  ) async {
    try {
      return Right((await action()).toEntity());
    } catch (error, stackTrace) {
      return Left(_mapFailure(error, operation, stackTrace));
    }
  }

  Future<Either<Failure, QuestionBankPage>> _runPage(
    Future<List<QuestionModel>> Function() action,
    int limit,
    String operation,
  ) async {
    try {
      final results = await action();
      final hasMore = results.length > limit;
      final questions = results
          .take(limit)
          .map((model) => model.toEntity())
          .toList();
      return Right(
        QuestionBankPage(
          questions: questions,
          hasMore: hasMore,
          nextCursor: questions.isEmpty ? null : questions.last.id,
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
