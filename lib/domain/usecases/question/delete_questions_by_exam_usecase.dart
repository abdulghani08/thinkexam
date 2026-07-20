import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../core/error/failures.dart';
import '../../repositories/question_repository.dart';
import '../base_usecase.dart';

class DeleteQuestionsByExamParams extends Equatable {
  final String examId;
  const DeleteQuestionsByExamParams(this.examId);

  @override
  List<Object?> get props => [examId];
}

class DeleteQuestionsByExamUseCase extends BaseUseCase<void, DeleteQuestionsByExamParams> {
  final QuestionRepository repository;
  const DeleteQuestionsByExamUseCase(this.repository);
  
  @override
  Future<Either<Failure, void>> call(DeleteQuestionsByExamParams params) =>
      repository.deleteQuestionsByExamId(params.examId);
}
