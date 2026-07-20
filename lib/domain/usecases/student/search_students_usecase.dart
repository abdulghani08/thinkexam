import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../core/error/failures.dart';
import '../../entities/student_page.dart';
import '../../repositories/student_repository.dart';
import '../base_usecase.dart';

class SearchStudentsParams extends Equatable {
  final String query;
  final String? cursor;
  final int limit;
  final String? classId;
  const SearchStudentsParams({
    required this.query,
    this.cursor,
    this.limit = 20,
    this.classId,
  });

  @override
  List<Object?> get props => [query, cursor, limit, classId];
}

class SearchStudentsUseCase
    extends BaseUseCase<StudentPage, SearchStudentsParams> {
  final StudentRepository repository;
  const SearchStudentsUseCase(this.repository);

  @override
  Future<Either<Failure, StudentPage>> call(SearchStudentsParams params) =>
      repository.searchStudents(
        params.query,
        cursor: params.cursor,
        limit: params.limit,
        classId: params.classId,
      );
}
