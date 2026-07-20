import 'package:cloud_firestore/cloud_firestore.dart';
import '../../core/error/exceptions.dart';
import '../../core/constants/collection_names.dart';
import 'base_datasource.dart';

class FirestoreExamSessionDataSource extends BaseDataSource {
  final FirebaseFirestore _firestore;

  FirestoreExamSessionDataSource(this._firestore);

  Future<Map<String, dynamic>> createSession(
    Map<String, dynamic> data,
  ) async {
    try {
      final docRef = await _firestore
          .collection(CollectionNames.examSessions)
          .add(data);
      final doc = await docRef.get();
      return doc.data()!;
    } on FirebaseException catch (e) {
      if (e.code == 'not-found') {
        throw NotFoundException('Failed to create exam session');
      }
      throw ServerException(e.message ?? 'Failed to create exam session');
    }
  }

  Future<Map<String, dynamic>> getSession(String id) async {
    try {
      final doc = await _firestore
          .collection(CollectionNames.examSessions)
          .doc(id)
          .get();
      if (!doc.exists) {
        throw NotFoundException('Exam session not found');
      }
      return doc.data()!;
    } on FirebaseException catch (e) {
      if (e.code == 'not-found') {
        throw NotFoundException('Exam session not found');
      }
      throw ServerException(e.message ?? 'Failed to get exam session');
    }
  }

  Future<void> updateSession(
    String id,
    Map<String, dynamic> data,
  ) async {
    try {
      await _firestore
          .collection(CollectionNames.examSessions)
          .doc(id)
          .update(data);
    } on FirebaseException catch (e) {
      if (e.code == 'not-found') {
        throw NotFoundException('Exam session not found');
      }
      throw ServerException(e.message ?? 'Failed to update exam session');
    }
  }

  Future<List<Map<String, dynamic>>> getSessionsByStudent(
    String studentId, {
    int limit = 20,
  }) async {
    try {
      final query = await _firestore
          .collection(CollectionNames.examSessions)
          .where('studentId', isEqualTo: studentId)
          .orderBy('createdAt', descending: true)
          .limit(limit)
          .get();
      return query.docs.map((doc) => doc.data()).toList();
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? 'Failed to get exam sessions');
    }
  }

  Future<List<Map<String, dynamic>>> getSessionsByExam(
    String examId, {
    int limit = 20,
  }) async {
    try {
      final query = await _firestore
          .collection(CollectionNames.examSessions)
          .where('examId', isEqualTo: examId)
          .orderBy('createdAt', descending: true)
          .limit(limit)
          .get();
      return query.docs.map((doc) => doc.data()).toList();
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? 'Failed to get exam sessions');
    }
  }
}
