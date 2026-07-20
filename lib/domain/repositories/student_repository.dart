import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/student.dart';
import '../entities/student_page.dart';
import 'base_repository.dart';

abstract class StudentRepository extends BaseRepository {
  Future<Either<Failure, Student>> createStudent(Student student);
  Future<Either<Failure, StudentPage>> getStudents({
    String? cursor,
    int limit = 20,
    String? classId,
  });
  Future<Either<Failure, Student>> getStudentById(String id);
  Future<Either<Failure, Student>> updateStudent(Student student);
  Future<Either<Failure, void>> deleteStudent(String id);
  Future<Either<Failure, StudentPage>> searchStudents(
    String query, {
    String? cursor,
    int limit = 20,
    String? classId,
  });
}
