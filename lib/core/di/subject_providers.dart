import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'firebase_providers.dart';
import '../../data/datasources/firestore_subject_datasource.dart';
import '../../data/repositories/subject_repository_impl.dart';
import '../../domain/repositories/subject_repository.dart';

// Firestore Subject Data Source
final firestoreSubjectDataSourceProvider =
    Provider<FirestoreSubjectDataSource>((ref) {
  return FirestoreSubjectDataSource(ref.watch(FirebaseProviders.firestoreProvider));
});

// Subject Repository
final subjectRepositoryProvider = Provider<SubjectRepository>((ref) {
  return SubjectRepositoryImpl(
    dataSource: ref.watch(firestoreSubjectDataSourceProvider),
  );
});
