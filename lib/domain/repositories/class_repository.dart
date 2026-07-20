import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/class_page.dart';
import '../entities/class_room.dart';
import 'base_repository.dart';

abstract class ClassRepository extends BaseRepository {
  Future<Either<Failure, ClassRoom>> createClass(ClassRoom classRoom);
  Future<Either<Failure, ClassPage>> getClasses({
    String? cursor,
    int limit = 20,
    bool includeArchived = false,
  });
  Future<Either<Failure, ClassRoom>> getClassById(String id);
  Future<Either<Failure, ClassRoom>> updateClass(ClassRoom classRoom);
  Future<Either<Failure, void>> deleteClass(String id);
  Future<Either<Failure, ClassPage>> searchClasses(
    String query, {
    String? cursor,
    int limit = 20,
  });
  Future<Either<Failure, List<ClassRoom>>> getClassesByGrade(int grade);
}
