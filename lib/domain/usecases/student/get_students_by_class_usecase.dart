import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';
import '../../entities/student_page.dart';
import '../../repositories/student_repository.dart';
import '../base_usecase.dart';

class GetStudentsByClassParams extends Equatable {
  final String classId;
  const GetStudentsByClassParams(this.classId);

  @override
  List<Object?> get props => [classId];
}

class GetStudentsByClassUseCase extends BaseUseCase<StudentPage, GetStudentsByClassParams> {
  final StudentRepository repository;
  const GetStudentsByClassUseCase(this.repository);
  
  @override
  Future<Either<Failure, StudentPage>> call(GetStudentsByClassParams params) =>
      repository.getStudents(classId: params.classId);
}
