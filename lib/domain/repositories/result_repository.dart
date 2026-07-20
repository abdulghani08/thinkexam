import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/exam_result.dart';
import '../entities/exam_statistics.dart';
import 'base_repository.dart';

abstract class ResultRepository extends BaseRepository {
  Future<Either<Failure, List<ExamResult>>> getResultsByExamId(String examId);
  Future<Either<Failure, ExamResult>> getResultById(String id);
  Future<Either<Failure, ExamStatistics>> getExamStatistics(String examId);
  Future<Either<Failure, List<ExamResult>>> getAllResults({int limit = 50});
}
