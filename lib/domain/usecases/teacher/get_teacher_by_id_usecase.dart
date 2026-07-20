import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';
import '../../entities/teacher.dart';
import '../../repositories/teacher_repository.dart';
import '../base_usecase.dart';

class GetTeacherByIdUseCase extends BaseUseCase<Teacher, String> {
  final TeacherRepository repository;
  const GetTeacherByIdUseCase(this.repository);
  @override
  Future<Either<Failure, Teacher>> call(String params) =>
      repository.getTeacherById(params);
}
