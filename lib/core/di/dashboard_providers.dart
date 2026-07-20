import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'firebase_providers.dart';
import '../../data/datasources/firestore_class_datasource.dart';
import '../../data/datasources/firestore_exam_datasource.dart';
import '../../data/datasources/firestore_student_datasource.dart';
import '../../data/repositories/dashboard_repository_impl.dart';
import '../../domain/repositories/dashboard_repository.dart';

final firestoreExamDataSourceProviderForDashboard =
    Provider<FirestoreExamDataSource>((ref) {
      return FirestoreExamDataSource(
        ref.watch(FirebaseProviders.firestoreProvider),
      );
    });

final firestoreStudentDataSourceProviderForDashboard =
    Provider<FirestoreStudentDataSource>((ref) {
      return FirestoreStudentDataSource(
        ref.watch(FirebaseProviders.firestoreProvider),
      );
    });

final firestoreClassDataSourceProviderForDashboard =
    Provider<FirestoreClassDataSource>((ref) {
      return FirestoreClassDataSource(
        ref.watch(FirebaseProviders.firestoreProvider),
      );
    });

final dashboardRepositoryProvider = Provider<DashboardRepository>((ref) {
  return DashboardRepositoryImpl(
    examDataSource: ref.watch(firestoreExamDataSourceProviderForDashboard),
    studentDataSource: ref.watch(
      firestoreStudentDataSourceProviderForDashboard,
    ),
    classDataSource: ref.watch(firestoreClassDataSourceProviderForDashboard),
  );
});
