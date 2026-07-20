import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../core/error/failures.dart';
import '../../repositories/student_repository.dart';
import '../base_usecase.dart';

class DeleteStudentParams extends Equatable {
  final String id;
  const DeleteStudentParams(this.id);

  @override
  List<Object?> get props => [id];
}

class DeleteStudentUseCase extends BaseUseCase<void, DeleteStudentParams> {
  final StudentRepository repository;
  const DeleteStudentUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(DeleteStudentParams params) =>
      repository.deleteStudent(params.id);
}
