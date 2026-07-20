import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../core/error/failures.dart';
import '../../entities/question.dart';
import '../../repositories/question_repository.dart';
import '../base_usecase.dart';

class GetQuestionByIdParams extends Equatable {
  final String id;
  const GetQuestionByIdParams(this.id);

  @override
  List<Object?> get props => [id];
}

class GetQuestionByIdUseCase
    extends BaseUseCase<Question, GetQuestionByIdParams> {
  final QuestionRepository repository;
  const GetQuestionByIdUseCase(this.repository);

  @override
  Future<Either<Failure, Question>> call(GetQuestionByIdParams params) =>
      repository.getQuestionById(params.id);
}
