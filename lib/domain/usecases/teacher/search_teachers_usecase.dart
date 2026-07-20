import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../core/error/failures.dart';
import '../../entities/teacher_page.dart';
import '../../repositories/teacher_repository.dart';
import '../base_usecase.dart';

class SearchTeachersParams extends Equatable {
  final String query;
  final String? cursor;
  final int limit;
  const SearchTeachersParams({
    required this.query,
    this.cursor,
    this.limit = 20,
  });
  @override
  List<Object?> get props => [query, cursor, limit];
}

class SearchTeachersUseCase
    extends BaseUseCase<TeacherPage, SearchTeachersParams> {
  final TeacherRepository repository;
  const SearchTeachersUseCase(this.repository);
  @override
  Future<Either<Failure, TeacherPage>> call(SearchTeachersParams params) =>
      repository.searchTeachers(
        params.query,
        cursor: params.cursor,
        limit: params.limit,
      );
}
