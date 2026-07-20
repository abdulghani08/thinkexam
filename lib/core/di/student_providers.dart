import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'firebase_providers.dart';
import '../../data/datasources/firestore_student_datasource.dart';
import '../../data/repositories/student_repository_impl.dart';
import '../../domain/repositories/student_repository.dart';

// Firestore Student Data Source
final firestoreStudentDataSourceProvider =
    Provider<FirestoreStudentDataSource>((ref) {
  return FirestoreStudentDataSource(ref.watch(FirebaseProviders.firestoreProvider));
});

// Student Repository
final studentRepositoryProvider = Provider<StudentRepository>((ref) {
  return StudentRepositoryImpl(
    dataSource: ref.watch(firestoreStudentDataSourceProvider),
  );
});
