import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/exam_session.dart';
import 'base_repository.dart';

abstract class ExamSessionRepository extends BaseRepository {
  Future<Either<Failure, ExamSession>> createSession(ExamSession session);
  Future<Either<Failure, ExamSession>> getSession(String id);
  Future<Either<Failure, void>> updateSession(ExamSession session);
  Future<Either<Failure, List<ExamSession>>> getSessionsByStudent(
    String studentId, {
    int limit,
  });
  Future<Either<Failure, List<ExamSession>>> getSessionsByExam(
    String examId, {
    int limit,
  });
}
