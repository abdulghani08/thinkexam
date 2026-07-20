import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../core/error/failures.dart';
import '../../entities/question_bank_page.dart';
import '../../repositories/question_repository.dart';
import '../base_usecase.dart';

class GetQuestionsByExamParams extends Equatable {
  final String examId;
  final String? cursor;
  final int limit;
  const GetQuestionsByExamParams({
    required this.examId,
    this.cursor,
    this.limit = 20,
  });

  @override
  List<Object?> get props => [examId, cursor, limit];
}

class GetQuestionsByExamUseCase
    extends BaseUseCase<QuestionBankPage, GetQuestionsByExamParams> {
  final QuestionRepository repository;
  const GetQuestionsByExamUseCase(this.repository);

  @override
  Future<Either<Failure, QuestionBankPage>> call(
    GetQuestionsByExamParams params,
  ) => repository.getQuestionsByExamId(
    params.examId,
    cursor: params.cursor,
    limit: params.limit,
  );
}
