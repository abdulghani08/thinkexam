import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../core/error/failures.dart';
import '../../entities/student.dart';
import '../../repositories/student_repository.dart';
import '../base_usecase.dart';

class GetStudentByIdParams extends Equatable {
  final String id;
  const GetStudentByIdParams(this.id);

  @override
  List<Object?> get props => [id];
}

class GetStudentByIdUseCase extends BaseUseCase<Student, GetStudentByIdParams> {
  final StudentRepository repository;
  const GetStudentByIdUseCase(this.repository);

  @override
  Future<Either<Failure, Student>> call(GetStudentByIdParams params) =>
      repository.getStudentById(params.id);
}
