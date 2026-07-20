import 'package:cloud_firestore/cloud_firestore.dart';
import '../../core/constants/collection_names.dart';
import '../../core/error/exceptions.dart';
import '../../core/logging/app_logger.dart';
import '../models/question_model.dart';
import 'base_datasource.dart';

/// Firestore access for question administration records.
class FirestoreQuestionDataSource extends BaseDataSource {
  final FirebaseFirestore _firestore;
  FirestoreQuestionDataSource(this._firestore);

  CollectionReference<Map<String, dynamic>> get _questions =>
      _firestore.collection(CollectionNames.questions);

  Future<QuestionModel> createQuestion(QuestionModel question) async {
    try {
      final reference = _questions.doc(question.id);
      if ((await reference.get()).exists) {
        throw const ConflictException(
          'A question with this ID already exists',
        );
      }
      await reference.set(question.toCreateMap());
      AppLogger.i('Question ${question.id} created');
      return _getQuestion(question.id);
    } on FirebaseException catch (e) {
      throw ServerException(
        e.message ?? 'Failed to create question',
        code: e.code,
      );
    }
  }

  Future<QuestionModel> getQuestionById(String id) => _getQuestion(id);

  Future<List<QuestionModel>> getQuestionsByExamId(String examId) async {
    try {
      final snapshot = await _questions
          .where('examId', isEqualTo: examId)
          .orderBy('order')
          .get();
      return snapshot.docs.map(QuestionModel.fromFirestore).toList();
    } on FirebaseException catch (e) {
      throw ServerException(
        e.message ?? 'Failed to get questions',
        code: e.code,
      );
    }
  }

  Future<QuestionModel> updateQuestion(QuestionModel question) async {
    try {
      final reference = _questions.doc(question.id);
      if (!(await reference.get()).exists) {
        throw const NotFoundException('Question not found');
      }
      await reference.update(question.toUpdateMap());
      AppLogger.i('Question ${question.id} updated');
      return _getQuestion(question.id);
    } on FirebaseException catch (e) {
      throw ServerException(
        e.message ?? 'Failed to update question',
        code: e.code,
      );
    }
  }

  Future<void> deleteQuestion(String id) async {
    try {
      final reference = _questions.doc(id);
      if (!(await reference.get()).exists) {
        throw const NotFoundException('Question not found');
      }
      await reference.delete();
      AppLogger.i('Question $id deleted');
    } on FirebaseException catch (e) {
      throw ServerException(
        e.message ?? 'Failed to delete question',
        code: e.code,
      );
    }
  }

  Future<void> deleteQuestionsByExamId(String examId) async {
    try {
      final snapshot = await _questions.where('examId', isEqualTo: examId).get();
      final batch = _firestore.batch();
      for (final doc in snapshot.docs) {
        batch.delete(doc.reference);
      }
      await batch.commit();
      AppLogger.i('Deleted ${snapshot.docs.length} questions for exam $examId');
    } on FirebaseException catch (e) {
      throw ServerException(
        e.message ?? 'Failed to delete questions',
        code: e.code,
      );
    }
  }

  Future<void> reorderQuestions(List<QuestionModel> questions) async {
    try {
      final batch = _firestore.batch();
      for (final question in questions) {
        final reference = _questions.doc(question.id);
        batch.update(reference, {'order': question.order});
      }
      await batch.commit();
      AppLogger.i('Reordered ${questions.length} questions');
    } on FirebaseException catch (e) {
      throw ServerException(
        e.message ?? 'Failed to reorder questions',
        code: e.code,
      );
    }
  }

  Future<QuestionModel> _getQuestion(String id) async {
    try {
      final document = await _questions.doc(id).get();
      if (!document.exists) throw const NotFoundException('Question not found');
      return QuestionModel.fromFirestore(document);
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? 'Failed to get question', code: e.code);
    }
  }
}
