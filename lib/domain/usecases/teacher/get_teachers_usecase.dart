import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../core/error/failures.dart';
import '../../entities/teacher_page.dart';
import '../../repositories/teacher_repository.dart';
import '../base_usecase.dart';

class GetTeachersParams extends Equatable {
  final String? cursor;
  final int limit;
  const GetTeachersParams({this.cursor, this.limit = 20});
  @override
  List<Object?> get props => [cursor, limit];
}

class GetTeachersUseCase extends BaseUseCase<TeacherPage, GetTeachersParams> {
  final TeacherRepository repository;
  const GetTeachersUseCase(this.repository);
  @override
  Future<Either<Failure, TeacherPage>> call(GetTeachersParams params) =>
      repository.getTeachers(cursor: params.cursor, limit: params.limit);
}
