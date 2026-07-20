import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/error/failures.dart';
import '../../../domain/entities/dashboard_summary.dart';
import '../../../core/di/dashboard_providers.dart';
import '../../../domain/repositories/dashboard_repository.dart';
import '../../../domain/usecases/base_usecase.dart';
import '../../../domain/usecases/dashboard/get_dashboard_summary_usecase.dart';

enum DashboardStatus { initial, loading, success, error }

class DashboardState {
  final DashboardStatus status;
  final DashboardSummary? summary;
  final String? errorMessage;

  const DashboardState({
    this.status = DashboardStatus.initial,
    this.summary,
    this.errorMessage,
  });

  DashboardState copyWith({
    DashboardStatus? status,
    DashboardSummary? summary,
    String? errorMessage,
  }) => DashboardState(
    status: status ?? this.status,
    summary: summary ?? this.summary,
    errorMessage: errorMessage ?? this.errorMessage,
  );
}

class DashboardNotifier extends StateNotifier<DashboardState> {
  final GetDashboardSummaryUseCase _getSummaryUseCase;

  DashboardNotifier(this._getSummaryUseCase) : super(const DashboardState());

  Future<void> loadSummary() async {
    state = state.copyWith(status: DashboardStatus.loading);
    final result = await _getSummaryUseCase(const NoParams());
    result.fold(
      (failure) => state = state.copyWith(
        status: DashboardStatus.error,
        errorMessage: failure.message,
      ),
      (summary) => state = state.copyWith(
        status: DashboardStatus.success,
        summary: summary,
      ),
    );
  }
}

final dashboardProvider =
    StateNotifierProvider<DashboardNotifier, DashboardState>((ref) {
      final dashboardRepository = ref.watch(dashboardRepositoryProvider);
      final getSummaryUseCase = GetDashboardSummaryUseCase(dashboardRepository);
      return DashboardNotifier(getSummaryUseCase);
    });
