import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';
import '../../entities/subject.dart';
import '../../repositories/subject_repository.dart';
import '../base_usecase.dart';

class CreateSubjectUseCase extends BaseUseCase<Subject, Subject> {
  final SubjectRepository repository;
  const CreateSubjectUseCase(this.repository);
  
  @override
  Future<Either<Failure, Subject>> call(Subject params) =>
      repository.createSubject(params);
}
