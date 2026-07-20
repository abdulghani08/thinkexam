import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../core/error/failures.dart';
import '../../entities/exam.dart';
import '../../repositories/exam_repository.dart';
import '../base_usecase.dart';

class ArchiveExamParams extends Equatable {
  final String examId;
  const ArchiveExamParams(this.examId);

  @override
  List<Object?> get props => [examId];
}

class ArchiveExamUseCase extends BaseUseCase<Exam, ArchiveExamParams> {
  final ExamRepository repository;
  const ArchiveExamUseCase(this.repository);

  @override
  Future<Either<Failure, Exam>> call(ArchiveExamParams params) =>
      repository.archiveExam(params.examId);
}
