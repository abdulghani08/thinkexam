import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'firebase_providers.dart';
import '../../data/datasources/firestore_exam_datasource.dart';
import '../../data/datasources/firestore_exam_session_datasource.dart';
import '../../data/datasources/firestore_exam_answer_datasource.dart';
import '../../data/repositories/exam_repository_impl.dart';
import '../../data/repositories/exam_session_repository_impl.dart';
import '../../data/repositories/exam_answer_repository_impl.dart';
import '../../domain/repositories/exam_repository.dart';
import '../../domain/repositories/exam_session_repository.dart';
import '../../domain/repositories/exam_answer_repository.dart';

// Firestore Exam Data Source
final firestoreExamDataSourceProvider =
    Provider<FirestoreExamDataSource>((ref) {
  return FirestoreExamDataSource(ref.watch(FirebaseProviders.firestoreProvider));
});

// Exam Session Data Source
final firestoreExamSessionDataSourceProvider =
    Provider<FirestoreExamSessionDataSource>((ref) {
  return FirestoreExamSessionDataSource(ref.watch(FirebaseProviders.firestoreProvider));
});

// Exam Answer Data Source
final firestoreExamAnswerDataSourceProvider =
    Provider<FirestoreExamAnswerDataSource>((ref) {
  return FirestoreExamAnswerDataSource(ref.watch(FirebaseProviders.firestoreProvider));
});

// Exam Repository
final examRepositoryProvider = Provider<ExamRepository>((ref) {
  return ExamRepositoryImpl(
    dataSource: ref.watch(firestoreExamDataSourceProvider),
  );
});

// Exam Session Repository
final examSessionRepositoryProvider = Provider<ExamSessionRepository>((ref) {
  return ExamSessionRepositoryImpl(
    ref.watch(firestoreExamSessionDataSourceProvider),
  );
});

// Exam Answer Repository
final examAnswerRepositoryProvider = Provider<ExamAnswerRepository>((ref) {
  return ExamAnswerRepositoryImpl(
    ref.watch(firestoreExamAnswerDataSourceProvider),
  );
});
