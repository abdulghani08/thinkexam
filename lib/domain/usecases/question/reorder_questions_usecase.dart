import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../core/error/failures.dart';
import '../../entities/question.dart';
import '../../repositories/question_repository.dart';
import '../base_usecase.dart';

class ReorderQuestionsParams extends Equatable {
  final List<Question> questions;
  const ReorderQuestionsParams(this.questions);

  @override
  List<Object?> get props => [questions];
}

class ReorderQuestionsUseCase
    extends BaseUseCase<void, ReorderQuestionsParams> {
  final QuestionRepository repository;
  const ReorderQuestionsUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(ReorderQuestionsParams params) =>
      repository.reorderQuestions(params.questions);
}
