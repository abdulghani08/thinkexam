import 'package:dartz/dartz.dart';
import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../../core/logging/app_logger.dart';
import '../../domain/entities/dashboard_summary.dart';
import '../../domain/repositories/dashboard_repository.dart';
import '../datasources/firestore_exam_datasource.dart';
import '../datasources/firestore_student_datasource.dart';
import '../datasources/firestore_class_datasource.dart';
import 'base_repository_impl.dart';

class DashboardRepositoryImpl extends BaseRepositoryImpl
    implements DashboardRepository {
  final FirestoreExamDataSource examDataSource;
  final FirestoreStudentDataSource studentDataSource;
  final FirestoreClassDataSource classDataSource;

  const DashboardRepositoryImpl({
    required this.examDataSource,
    required this.studentDataSource,
    required this.classDataSource,
  });

  @override
  Future<Either<Failure, DashboardSummary>> getDashboardSummary() async {
    try {
      final exams = await examDataSource.getExams(limit: 100);
      final students = await studentDataSource.getStudents(limit: 100);
      final classes = await classDataSource.getClasses(limit: 100);

      final totalExams = exams.length;
      final activeExams = exams.where((e) => e.status == 'published').length;
      final totalStudents = students.length;
      final totalClasses = classes.length;

      return Right(DashboardSummary(
        totalExams: totalExams,
        activeExams: activeExams,
        totalStudents: totalStudents,
        totalClasses: totalClasses,
      ));
    } catch (error, stackTrace) {
      AppLogger.e('Failed to get dashboard summary', error, stackTrace);
      return Left(_mapFailure(error));
    }
  }

  Failure _mapFailure(Object error) {
    if (error is NotFoundException)
      return NotFoundFailure(error.message, code: error.code);
    if (error is ServerException)
      return ServerFailure(error.message, code: error.code);
    return UnknownFailure('Failed to get dashboard summary');
  }
}
