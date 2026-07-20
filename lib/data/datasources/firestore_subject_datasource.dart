import 'package:cloud_firestore/cloud_firestore.dart';
import '../../core/constants/collection_names.dart';
import '../../core/error/exceptions.dart';
import '../../core/logging/app_logger.dart';
import '../models/subject_model.dart';
import 'base_datasource.dart';

/// Firestore access for subject administration records.
class FirestoreSubjectDataSource extends BaseDataSource {
  final FirebaseFirestore _firestore;
  FirestoreSubjectDataSource(this._firestore);

  CollectionReference<Map<String, dynamic>> get _subjects =>
      _firestore.collection(CollectionNames.subjects);

  Future<SubjectModel> createSubject(SubjectModel subject) async {
    try {
      final reference = _subjects.doc(subject.id);
      if ((await reference.get()).exists) {
        throw const ConflictException(
          'A subject with this ID already exists',
        );
      }
      await reference.set(subject.toCreateMap());
      AppLogger.i('Subject ${subject.id} created');
      return _getSubject(subject.id);
    } on FirebaseException catch (e) {
      throw ServerException(
        e.message ?? 'Failed to create subject',
        code: e.code,
      );
    }
  }

  Future<SubjectModel> getSubjectById(String id) => _getSubject(id);

  Future<List<SubjectModel>> getSubjects({
    String? cursor,
    int limit = 20,
  }) => _querySubjects(cursor: cursor, limit: limit);

  Future<List<SubjectModel>> searchSubjects(
    String query, {
    String? cursor,
    int limit = 20,
  }) => _querySubjects(query: query, cursor: cursor, limit: limit);

  Future<SubjectModel> updateSubject(SubjectModel subject) async {
    try {
      final reference = _subjects.doc(subject.id);
      if (!(await reference.get()).exists) {
        throw const NotFoundException('Subject not found');
      }
      await reference.update(subject.toUpdateMap());
      AppLogger.i('Subject ${subject.id} updated');
      return _getSubject(subject.id);
    } on FirebaseException catch (e) {
      throw ServerException(
        e.message ?? 'Failed to update subject',
        code: e.code,
      );
    }
  }

  Future<void> deleteSubject(String id) async {
    try {
      final reference = _subjects.doc(id);
      if (!(await reference.get()).exists) {
        throw const NotFoundException('Subject not found');
      }
      await reference.delete();
      AppLogger.i('Subject $id deleted');
    } on FirebaseException catch (e) {
      throw ServerException(
        e.message ?? 'Failed to delete subject',
        code: e.code,
      );
    }
  }

  Future<SubjectModel> _getSubject(String id) async {
    try {
      final document = await _subjects.doc(id).get();
      if (!document.exists) throw const NotFoundException('Subject not found');
      return SubjectModel.fromFirestore(document);
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? 'Failed to get subject', code: e.code);
    }
  }

  Future<List<SubjectModel>> _querySubjects({
    String? query,
    String? cursor,
    required int limit,
  }) async {
    try {
      Query<Map<String, dynamic>> request = _subjects.orderBy('subjectName');
      
      final term = query?.trim();
      if (term != null && term.isNotEmpty) {
        request = request.startAt([term]).endAt(['$term\uf8ff']);
      }
      
      if (cursor != null) {
        final cursorDocument = await _subjects.doc(cursor).get();
        if (cursorDocument.exists)
          request = request.startAfterDocument(cursorDocument);
      }
      
      final snapshot = await request.limit(limit + 1).get();
      return snapshot.docs.map(SubjectModel.fromFirestore).toList();
    } on FirebaseException catch (e) {
      throw ServerException(
        e.message ?? 'Failed to get subjects',
        code: e.code,
      );
    }
  }
}
