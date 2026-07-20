import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';
import '../../repositories/teacher_repository.dart';
import '../base_usecase.dart';

class DeleteTeacherUseCase extends BaseUseCase<void, String> {
  final TeacherRepository repository;
  const DeleteTeacherUseCase(this.repository);
  @override
  Future<Either<Failure, void>> call(String params) =>
      repository.deleteTeacher(params);
}
