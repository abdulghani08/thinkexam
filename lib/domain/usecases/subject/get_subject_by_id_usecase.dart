import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../core/error/failures.dart';
import '../../entities/subject.dart';
import '../../repositories/subject_repository.dart';
import '../base_usecase.dart';

class GetSubjectByIdParams extends Equatable {
  final String id;
  const GetSubjectByIdParams(this.id);

  @override
  List<Object?> get props => [id];
}

class GetSubjectByIdUseCase extends BaseUseCase<Subject, GetSubjectByIdParams> {
  final SubjectRepository repository;
  const GetSubjectByIdUseCase(this.repository);

  @override
  Future<Either<Failure, Subject>> call(GetSubjectByIdParams params) =>
      repository.getSubjectById(params.id);
}
