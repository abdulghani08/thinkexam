import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';
import '../../entities/exam.dart';
import '../../repositories/exam_repository.dart';
import '../base_usecase.dart';

class CreateExamUseCase extends BaseUseCase<Exam, Exam> {
  final ExamRepository repository;
  const CreateExamUseCase(this.repository);
  
  @override
  Future<Either<Failure, Exam>> call(Exam params) =>
      repository.createExam(params);
}
