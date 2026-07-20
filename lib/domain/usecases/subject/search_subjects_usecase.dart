import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../core/error/failures.dart';
import '../../entities/subject_page.dart';
import '../../repositories/subject_repository.dart';
import '../base_usecase.dart';

class SearchSubjectsParams extends Equatable {
  final String query;
  final String? cursor;
  final int limit;
  const SearchSubjectsParams({
    required this.query,
    this.cursor,
    this.limit = 20,
  });

  @override
  List<Object?> get props => [query, cursor, limit];
}

class SearchSubjectsUseCase
    extends BaseUseCase<SubjectPage, SearchSubjectsParams> {
  final SubjectRepository repository;
  const SearchSubjectsUseCase(this.repository);

  @override
  Future<Either<Failure, SubjectPage>> call(SearchSubjectsParams params) =>
      repository.searchSubjects(
        params.query,
        cursor: params.cursor,
        limit: params.limit,
      );
}
