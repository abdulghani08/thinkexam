import 'package:cloud_firestore/cloud_firestore.dart';
import '../../core/error/exceptions.dart';
import '../../core/constants/collection_names.dart';
import 'base_datasource.dart';

class FirestoreExamAnswerDataSource extends BaseDataSource {
  final FirebaseFirestore _firestore;

  FirestoreExamAnswerDataSource(this._firestore);

  Future<Map<String, dynamic>> createAnswer(
    Map<String, dynamic> data,
  ) async {
    try {
      final docRef = await _firestore
          .collection(CollectionNames.examAnswers)
          .add(data);
      final doc = await docRef.get();
      return doc.data()!;
    } on FirebaseException catch (e) {
      if (e.code == 'not-found') {
        throw NotFoundException('Failed to create exam answer');
      }
      throw ServerException(e.message ?? 'Failed to create exam answer');
    }
  }

  Future<void> updateAnswer(
    String id,
    Map<String, dynamic> data,
  ) async {
    try {
      await _firestore
          .collection(CollectionNames.examAnswers)
          .doc(id)
          .update(data);
    } on FirebaseException catch (e) {
      if (e.code == 'not-found') {
        throw NotFoundException('Exam answer not found');
      }
      throw ServerException(e.message ?? 'Failed to update exam answer');
    }
  }

  Future<List<Map<String, dynamic>>> getAnswersBySession(
    String sessionId,
  ) async {
    try {
      final query = await _firestore
          .collection(CollectionNames.examAnswers)
          .where('sessionId', isEqualTo: sessionId)
          .get();
      return query.docs.map((doc) => doc.data()).toList();
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? 'Failed to get exam answers');
    }
  }

  Future<Map<String, dynamic>?> getAnswerBySessionAndQuestion(
    String sessionId,
    String questionId,
  ) async {
    try {
      final query = await _firestore
          .collection(CollectionNames.examAnswers)
          .where('sessionId', isEqualTo: sessionId)
          .where('questionId', isEqualTo: questionId)
          .limit(1)
          .get();
      if (query.docs.isEmpty) {
        return null;
      }
      return query.docs.first.data();
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? 'Failed to get exam answer');
    }
  }

  Future<List<String>> createAnswersBatch(
    List<Map<String, dynamic>> dataList,
  ) async {
    try {
      final batch = _firestore.batch();
      final docRefs = <DocumentReference>[];
      for (final data in dataList) {
        final docRef = _firestore
            .collection(CollectionNames.examAnswers)
            .doc();
        batch.set(docRef, data);
        docRefs.add(docRef);
      }
      await batch.commit();
      return docRefs.map((ref) => ref.id).toList();
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? 'Failed to create exam answers batch');
    }
  }

  Future<void> deleteAnswersBySession(String sessionId) async {
    try {
      final query = await _firestore
          .collection(CollectionNames.examAnswers)
          .where('sessionId', isEqualTo: sessionId)
          .get();
      final batch = _firestore.batch();
      for (var doc in query.docs) {
        batch.delete(doc.reference);
      }
      await batch.commit();
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? 'Failed to delete exam answers');
    }
  }
}
