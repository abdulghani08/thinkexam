import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';
import '../../entities/teacher.dart';
import '../../repositories/teacher_repository.dart';
import '../base_usecase.dart';

class CreateTeacherUseCase extends BaseUseCase<Teacher, Teacher> {
  final TeacherRepository repository;
  const CreateTeacherUseCase(this.repository);
  @override
  Future<Either<Failure, Teacher>> call(Teacher params) =>
      repository.createTeacher(params);
}
