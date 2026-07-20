import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../core/error/failures.dart';
import '../../repositories/exam_repository.dart';
import '../base_usecase.dart';

class DeleteExamParams extends Equatable {
  final String id;
  const DeleteExamParams(this.id);

  @override
  List<Object?> get props => [id];
}

class DeleteExamUseCase extends BaseUseCase<void, DeleteExamParams> {
  final ExamRepository repository;
  const DeleteExamUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(DeleteExamParams params) =>
      repository.deleteExam(params.id);
}
