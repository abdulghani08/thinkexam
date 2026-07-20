import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../core/error/failures.dart';
import '../../entities/exam_page.dart';
import '../../repositories/exam_repository.dart';
import '../base_usecase.dart';

class SearchExamsParams extends Equatable {
  final String query;
  final String? cursor;
  final int limit;
  final String? status;
  const SearchExamsParams({
    required this.query,
    this.cursor,
    this.limit = 20,
    this.status,
  });

  @override
  List<Object?> get props => [query, cursor, limit, status];
}

class SearchExamsUseCase extends BaseUseCase<ExamPage, SearchExamsParams> {
  final ExamRepository repository;
  const SearchExamsUseCase(this.repository);

  @override
  Future<Either<Failure, ExamPage>> call(SearchExamsParams params) =>
      repository.searchExams(
        params.query,
        cursor: params.cursor,
        limit: params.limit,
        status: params.status,
      );
}
