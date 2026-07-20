import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../core/error/failures.dart';
import '../../entities/class_room.dart';
import '../../repositories/class_repository.dart';
import '../base_usecase.dart';

class GetClassesByGradeParams extends Equatable {
  final int grade;
  const GetClassesByGradeParams(this.grade);

  @override
  List<Object?> get props => [grade];
}

class GetClassesByGradeUseCase extends BaseUseCase<List<ClassRoom>, GetClassesByGradeParams> {
  final ClassRepository repository;
  const GetClassesByGradeUseCase(this.repository);
  
  @override
  Future<Either<Failure, List<ClassRoom>>> call(GetClassesByGradeParams params) =>
      repository.getClassesByGrade(params.grade);
}
