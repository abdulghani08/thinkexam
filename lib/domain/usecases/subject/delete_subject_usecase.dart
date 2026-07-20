import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../core/error/failures.dart';
import '../../repositories/subject_repository.dart';
import '../base_usecase.dart';

class DeleteSubjectParams extends Equatable {
  final String id;
  const DeleteSubjectParams(this.id);

  @override
  List<Object?> get props => [id];
}

class DeleteSubjectUseCase extends BaseUseCase<void, DeleteSubjectParams> {
  final SubjectRepository repository;
  const DeleteSubjectUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(DeleteSubjectParams params) =>
      repository.deleteSubject(params.id);
}
