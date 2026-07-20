import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';
import '../../entities/teacher.dart';
import '../../repositories/teacher_repository.dart';
import '../base_usecase.dart';

class UpdateTeacherUseCase extends BaseUseCase<Teacher, Teacher> {
  final TeacherRepository repository;
  const UpdateTeacherUseCase(this.repository);
  @override
  Future<Either<Failure, Teacher>> call(Teacher params) =>
      repository.updateTeacher(params);
}
