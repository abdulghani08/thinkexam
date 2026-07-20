import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/subject.dart';
import '../entities/subject_page.dart';
import 'base_repository.dart';

abstract class SubjectRepository extends BaseRepository {
  Future<Either<Failure, Subject>> createSubject(Subject subject);
  Future<Either<Failure, SubjectPage>> getSubjects({
    String? cursor,
    int limit = 20,
    bool includeArchived = false,
  });
  Future<Either<Failure, Subject>> getSubjectById(String id);
  Future<Either<Failure, Subject>> updateSubject(Subject subject);
  Future<Either<Failure, void>> deleteSubject(String id);
  Future<Either<Failure, SubjectPage>> searchSubjects(
    String query, {
    String? cursor,
    int limit = 20,
  });
}
