import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';
import '../../entities/student_page.dart';
import '../../repositories/student_repository.dart';
import '../base_usecase.dart';

class GetStudentsParams extends Equatable {
  final String? cursor;
  final int limit;
  final String? classId;
  const GetStudentsParams({
    this.cursor,
    this.limit = 20,
    this.classId,
  });

  @override
  List<Object?> get props => [cursor, limit, classId];
}

class GetStudentsUseCase extends BaseUseCase<StudentPage, GetStudentsParams> {
  final StudentRepository repository;
  const GetStudentsUseCase(this.repository);
  
  @override
  Future<Either<Failure, StudentPage>> call(GetStudentsParams params) =>
      repository.getStudents(
        cursor: params.cursor,
        limit: params.limit,
        classId: params.classId,
      );
}
