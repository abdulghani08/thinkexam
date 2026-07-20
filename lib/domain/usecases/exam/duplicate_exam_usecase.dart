import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../core/error/failures.dart';
import '../../entities/exam.dart';
import '../../repositories/exam_repository.dart';
import '../base_usecase.dart';

class DuplicateExamParams extends Equatable {
  final String examId;
  final String createdBy;
  const DuplicateExamParams({required this.examId, required this.createdBy});

  @override
  List<Object?> get props => [examId, createdBy];
}

class DuplicateExamUseCase extends BaseUseCase<Exam, DuplicateExamParams> {
  final ExamRepository repository;
  const DuplicateExamUseCase(this.repository);

  @override
  Future<Either<Failure, Exam>> call(DuplicateExamParams params) =>
      repository.duplicateExam(params.examId, params.createdBy);
}
