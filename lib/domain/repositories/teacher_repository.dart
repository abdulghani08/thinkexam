import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/teacher.dart';
import '../entities/teacher_page.dart';
import 'base_repository.dart';

/// Repository contract for teacher administration.
abstract class TeacherRepository extends BaseRepository {
  Future<Either<Failure, Teacher>> createTeacher(Teacher teacher);
  Future<Either<Failure, TeacherPage>> getTeachers({
    String? cursor,
    int limit = 20,
  });
  Future<Either<Failure, Teacher>> getTeacherById(String id);
  Future<Either<Failure, Teacher>> updateTeacher(Teacher teacher);
  Future<Either<Failure, void>> deleteTeacher(String id);
  Future<Either<Failure, TeacherPage>> searchTeachers(
    String query, {
    String? cursor,
    int limit = 20,
  });
}
