import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../core/error/failures.dart';
import '../../entities/exam.dart';
import '../../repositories/exam_repository.dart';
import '../base_usecase.dart';

class GetExamByIdParams extends Equatable {
  final String id;
  const GetExamByIdParams(this.id);

  @override
  List<Object?> get props => [id];
}

class GetExamByIdUseCase extends BaseUseCase<Exam, GetExamByIdParams> {
  final ExamRepository repository;
  const GetExamByIdUseCase(this.repository);

  @override
  Future<Either<Failure, Exam>> call(GetExamByIdParams params) =>
      repository.getExamById(params.id);
}
