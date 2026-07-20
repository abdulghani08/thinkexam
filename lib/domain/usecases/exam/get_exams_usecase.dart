import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../core/error/failures.dart';
import '../../entities/exam_page.dart';
import '../../repositories/exam_repository.dart';
import '../base_usecase.dart';

class GetExamsParams extends Equatable {
  final String? cursor;
  final int limit;
  final String? status;
  const GetExamsParams({this.cursor, this.limit = 20, this.status});

  @override
  List<Object?> get props => [cursor, limit, status];
}

class GetExamsUseCase extends BaseUseCase<ExamPage, GetExamsParams> {
  final ExamRepository repository;
  const GetExamsUseCase(this.repository);

  @override
  Future<Either<Failure, ExamPage>> call(GetExamsParams params) =>
      repository.getExams(
        cursor: params.cursor,
        limit: params.limit,
        status: params.status,
      );
}
