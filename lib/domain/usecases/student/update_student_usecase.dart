import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';
import '../../entities/student.dart';
import '../../repositories/student_repository.dart';
import '../base_usecase.dart';

class UpdateStudentUseCase extends BaseUseCase<Student, Student> {
  final StudentRepository repository;
  const UpdateStudentUseCase(this.repository);
  
  @override
  Future<Either<Failure, Student>> call(Student params) =>
      repository.updateStudent(params);
}
