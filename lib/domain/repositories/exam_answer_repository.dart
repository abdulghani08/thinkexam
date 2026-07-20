import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/exam_answer.dart';
import 'base_repository.dart';

abstract class ExamAnswerRepository extends BaseRepository {
  Future<Either<Failure, ExamAnswer>> createAnswer(ExamAnswer answer);
  Future<Either<Failure, void>> updateAnswer(ExamAnswer answer);
  Future<Either<Failure, List<ExamAnswer>>> getAnswersBySession(
    String sessionId,
  );
  Future<Either<Failure, ExamAnswer?>> getAnswerBySessionAndQuestion(
    String sessionId,
    String questionId,
  );
  Future<Either<Failure, void>> createAnswersBatch(
    List<ExamAnswer> answers,
  );
  Future<Either<Failure, void>> deleteAnswersBySession(String sessionId);
}
