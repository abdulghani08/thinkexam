import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'firebase_providers.dart';
import '../../data/datasources/firestore_class_datasource.dart';
import '../../data/repositories/class_repository_impl.dart';
import '../../domain/repositories/class_repository.dart';

// Firestore Class Data Source
final firestoreClassDataSourceProvider =
    Provider<FirestoreClassDataSource>((ref) {
  return FirestoreClassDataSource(ref.watch(FirebaseProviders.firestoreProvider));
});

// Class Repository
final classRepositoryProvider = Provider<ClassRepository>((ref) {
  return ClassRepositoryImpl(
    dataSource: ref.watch(firestoreClassDataSourceProvider),
  );
});
