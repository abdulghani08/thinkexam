import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';
import '../../entities/question.dart';
import '../../repositories/question_repository.dart';
import '../base_usecase.dart';

class CreateQuestionUseCase extends BaseUseCase<Question, Question> {
  final QuestionRepository repository;
  const CreateQuestionUseCase(this.repository);
  
  @override
  Future<Either<Failure, Question>> call(Question params) =>
      repository.createQuestion(params);
}
