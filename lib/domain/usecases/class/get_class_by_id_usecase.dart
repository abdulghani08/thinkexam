import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../core/error/failures.dart';
import '../../entities/class_room.dart';
import '../../repositories/class_repository.dart';
import '../base_usecase.dart';

class GetClassByIdParams extends Equatable {
  final String id;
  const GetClassByIdParams(this.id);

  @override
  List<Object?> get props => [id];
}

class GetClassByIdUseCase extends BaseUseCase<ClassRoom, GetClassByIdParams> {
  final ClassRepository repository;
  const GetClassByIdUseCase(this.repository);

  @override
  Future<Either<Failure, ClassRoom>> call(GetClassByIdParams params) =>
      repository.getClassById(params.id);
}
