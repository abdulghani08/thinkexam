import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/question.dart';
import '../entities/question_bank_item.dart';
import '../entities/question_bank_page.dart';
import 'base_repository.dart';

abstract class QuestionRepository extends BaseRepository {
  Future<Either<Failure, Question>> createQuestion(Question question);
  Future<Either<Failure, QuestionBankPage>> getQuestionsByExamId(
    String examId, {
    String? cursor,
    int limit = 20,
  });
  Future<Either<Failure, Question>> getQuestionById(String id);
  Future<Either<Failure, Question>> updateQuestion(Question question);
  Future<Either<Failure, void>> deleteQuestion(String id);
  Future<Either<Failure, void>> reorderQuestions(List<Question> questions);
  Future<Either<Failure, int>> countQuestionsByExamId(String examId);

  Future<Either<Failure, QuestionBankItem>> createBankItem(
    QuestionBankItem item,
  );
  Future<Either<Failure, QuestionBankPage>> getBankItems({
    String? cursor,
    int limit = 20,
    String? subjectId,
  });
  Future<Either<Failure, QuestionBankItem>> getBankItemById(String id);
  Future<Either<Failure, QuestionBankItem>> updateBankItem(
    QuestionBankItem item,
  );
  Future<Either<Failure, void>> deleteBankItem(String id);
  Future<Either<Failure, QuestionBankPage>> searchBankItems(
    String query, {
    String? cursor,
    int limit = 20,
    String? subjectId,
  });
  Future<Either<Failure, Question>> importFromBank({
    required String examId,
    required String bankItemId,
    required int order,
  });
  Future<Either<Failure, void>> deleteQuestionsByExamId(String examId);
}
