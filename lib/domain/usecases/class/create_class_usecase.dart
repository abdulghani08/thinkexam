import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';
import '../../entities/class_room.dart';
import '../../repositories/class_repository.dart';
import '../base_usecase.dart';

class CreateClassUseCase extends BaseUseCase<ClassRoom, ClassRoom> {
  final ClassRepository repository;
  const CreateClassUseCase(this.repository);
  
  @override
  Future<Either<Failure, ClassRoom>> call(ClassRoom params) =>
      repository.createClass(params);
}
