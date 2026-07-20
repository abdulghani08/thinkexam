import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../core/error/failures.dart';
import '../../repositories/question_repository.dart';
import '../base_usecase.dart';

class DeleteQuestionParams extends Equatable {
  final String id;
  const DeleteQuestionParams(this.id);

  @override
  List<Object?> get props => [id];
}

class DeleteQuestionUseCase extends BaseUseCase<void, DeleteQuestionParams> {
  final QuestionRepository repository;
  const DeleteQuestionUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(DeleteQuestionParams params) =>
      repository.deleteQuestion(params.id);
}
