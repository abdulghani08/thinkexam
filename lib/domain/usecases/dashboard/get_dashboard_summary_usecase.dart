import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';
import '../../entities/dashboard_summary.dart';
import '../../repositories/dashboard_repository.dart';
import '../base_usecase.dart';

class GetDashboardSummaryUseCase extends BaseUseCase<DashboardSummary, NoParams> {
  final DashboardRepository repository;
  const GetDashboardSummaryUseCase(this.repository);

  @override
  Future<Either<Failure, DashboardSummary>> call(NoParams params) =>
      repository.getDashboardSummary();
}
