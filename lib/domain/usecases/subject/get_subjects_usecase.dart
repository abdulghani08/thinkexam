import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';
import '../../entities/subject_page.dart';
import '../../repositories/subject_repository.dart';
import '../base_usecase.dart';

class GetSubjectsParams extends Equatable {
  final String? cursor;
  final int limit;
  const GetSubjectsParams({
    this.cursor,
    this.limit = 20,
  });

  @override
  List<Object?> get props => [cursor, limit];
}

class GetSubjectsUseCase extends BaseUseCase<SubjectPage, GetSubjectsParams> {
  final SubjectRepository repository;
  const GetSubjectsUseCase(this.repository);
  
  @override
  Future<Either<Failure, SubjectPage>> call(GetSubjectsParams params) =>
      repository.getSubjects(
        cursor: params.cursor,
        limit: params.limit,
      );
}
