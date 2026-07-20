import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../core/error/failures.dart';
import '../../entities/class_page.dart';
import '../../repositories/class_repository.dart';
import '../base_usecase.dart';

class GetClassesParams extends Equatable {
  final String? cursor;
  final int limit;
  const GetClassesParams({this.cursor, this.limit = 20});

  @override
  List<Object?> get props => [cursor, limit];
}

class GetClassesUseCase extends BaseUseCase<ClassPage, GetClassesParams> {
  final ClassRepository repository;
  const GetClassesUseCase(this.repository);

  @override
  Future<Either<Failure, ClassPage>> call(GetClassesParams params) =>
      repository.getClasses(cursor: params.cursor, limit: params.limit);
}
