import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../core/error/failures.dart';
import '../../entities/exam.dart';
import '../../repositories/exam_repository.dart';
import '../base_usecase.dart';

class PublishExamParams extends Equatable {
  final String examId;
  const PublishExamParams(this.examId);

  @override
  List<Object?> get props => [examId];
}

class PublishExamUseCase extends BaseUseCase<Exam, PublishExamParams> {
  final ExamRepository repository;
  const PublishExamUseCase(this.repository);

  @override
  Future<Either<Failure, Exam>> call(PublishExamParams params) =>
      repository.publishExam(params.examId);
}
