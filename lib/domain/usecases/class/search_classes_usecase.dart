import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../core/error/failures.dart';
import '../../entities/class_page.dart';
import '../../repositories/class_repository.dart';
import '../base_usecase.dart';

class SearchClassesParams extends Equatable {
  final String query;
  final String? cursor;
  final int limit;
  const SearchClassesParams({
    required this.query,
    this.cursor,
    this.limit = 20,
  });

  @override
  List<Object?> get props => [query, cursor, limit];
}

class SearchClassesUseCase extends BaseUseCase<ClassPage, SearchClassesParams> {
  final ClassRepository repository;
  const SearchClassesUseCase(this.repository);

  @override
  Future<Either<Failure, ClassPage>> call(SearchClassesParams params) =>
      repository.searchClasses(
        params.query,
        cursor: params.cursor,
        limit: params.limit,
      );
}
