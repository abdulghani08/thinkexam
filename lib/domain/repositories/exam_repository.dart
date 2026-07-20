import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/exam.dart';
import '../entities/exam_page.dart';
import 'base_repository.dart';

abstract class ExamRepository extends BaseRepository {
  Future<Either<Failure, Exam>> createExam(Exam exam);
  Future<Either<Failure, ExamPage>> getExams({
    String? cursor,
    int limit = 20,
    String? status,
  });
  Future<Either<Failure, Exam>> getExamById(String id);
  Future<Either<Failure, Exam>> updateExam(Exam exam);
  Future<Either<Failure, void>> deleteExam(String id);
  Future<Either<Failure, ExamPage>> searchExams(
    String query, {
    String? cursor,
    int limit = 20,
    String? status,
  });
  Future<Either<Failure, Exam>> duplicateExam(String examId, String createdBy);
  Future<Either<Failure, Exam>> publishExam(String examId);
  Future<Either<Failure, Exam>> archiveExam(String examId);
}
