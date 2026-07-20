import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';
import '../../entities/class_room.dart';
import '../../repositories/class_repository.dart';
import '../base_usecase.dart';

class UpdateClassUseCase extends BaseUseCase<ClassRoom, ClassRoom> {
  final ClassRepository repository;
  const UpdateClassUseCase(this.repository);
  
  @override
  Future<Either<Failure, ClassRoom>> call(ClassRoom params) =>
      repository.updateClass(params);
}
