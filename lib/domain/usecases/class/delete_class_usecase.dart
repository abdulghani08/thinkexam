import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../core/error/failures.dart';
import '../../repositories/class_repository.dart';
import '../base_usecase.dart';

class DeleteClassParams extends Equatable {
  final String id;
  const DeleteClassParams(this.id);

  @override
  List<Object?> get props => [id];
}

class DeleteClassUseCase extends BaseUseCase<void, DeleteClassParams> {
  final ClassRepository repository;
  const DeleteClassUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(DeleteClassParams params) =>
      repository.deleteClass(params.id);
}
