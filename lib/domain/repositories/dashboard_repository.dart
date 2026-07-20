import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/dashboard_summary.dart';
import 'base_repository.dart';

abstract class DashboardRepository extends BaseRepository {
  Future<Either<Failure, DashboardSummary>> getDashboardSummary();
}
