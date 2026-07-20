import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'firebase_providers.dart';
import '../../data/datasources/firestore_question_datasource.dart';
import '../../data/repositories/question_repository_impl.dart';
import '../../domain/repositories/question_repository.dart';

// Firestore Question Data Source
final firestoreQuestionDataSourceProvider =
    Provider<FirestoreQuestionDataSource>((ref) {
  return FirestoreQuestionDataSource(ref.watch(FirebaseProviders.firestoreProvider));
});

// Question Repository
final questionRepositoryProvider = Provider<QuestionRepository>((ref) {
  return QuestionRepositoryImpl(
    dataSource: ref.watch(firestoreQuestionDataSourceProvider),
  );
});
