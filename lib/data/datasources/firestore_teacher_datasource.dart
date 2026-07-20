import 'package:cloud_firestore/cloud_firestore.dart';
import '../../core/constants/collection_names.dart';
import '../../core/error/exceptions.dart';
import '../../core/logging/app_logger.dart';
import '../models/teacher_model.dart';
import 'base_datasource.dart';

/// Firestore access for teacher administration records.
class FirestoreTeacherDataSource extends BaseDataSource {
  final FirebaseFirestore _firestore;
  FirestoreTeacherDataSource(this._firestore);

  CollectionReference<Map<String, dynamic>> get _teachers =>
      _firestore.collection(CollectionNames.teachers);

  Future<TeacherModel> createTeacher(TeacherModel teacher) async {
    try {
      final reference = _teachers.doc(teacher.id);
      if ((await reference.get()).exists) {
        throw const ConflictException(
          'A teacher with this Firebase User ID already exists',
        );
      }
      await reference.set(teacher.toCreateMap());
      AppLogger.i('Teacher ${teacher.id} created');
      return _getTeacher(teacher.id);
    } on FirebaseException catch (e) {
      throw ServerException(
        e.message ?? 'Failed to create teacher',
        code: e.code,
      );
    }
  }

  Future<TeacherModel> getTeacherById(String id) => _getTeacher(id);

  Future<List<TeacherModel>> getTeachers({String? cursor, int limit = 20}) =>
      _queryTeachers(cursor: cursor, limit: limit);

  Future<List<TeacherModel>> searchTeachers(
    String query, {
    String? cursor,
    int limit = 20,
  }) => _queryTeachers(query: query, cursor: cursor, limit: limit);

  Future<TeacherModel> updateTeacher(TeacherModel teacher) async {
    try {
      final reference = _teachers.doc(teacher.id);
      if (!(await reference.get()).exists) {
        throw const NotFoundException('Teacher not found');
      }
      await reference.update(teacher.toUpdateMap());
      AppLogger.i('Teacher ${teacher.id} updated');
      return _getTeacher(teacher.id);
    } on FirebaseException catch (e) {
      throw ServerException(
        e.message ?? 'Failed to update teacher',
        code: e.code,
      );
    }
  }

  Future<void> deleteTeacher(String id) async {
    try {
      final reference = _teachers.doc(id);
      if (!(await reference.get()).exists) {
        throw const NotFoundException('Teacher not found');
      }
      await reference.delete();
      AppLogger.i('Teacher $id deleted');
    } on FirebaseException catch (e) {
      throw ServerException(
        e.message ?? 'Failed to delete teacher',
        code: e.code,
      );
    }
  }

  Future<TeacherModel> _getTeacher(String id) async {
    try {
      final document = await _teachers.doc(id).get();
      if (!document.exists) throw const NotFoundException('Teacher not found');
      return TeacherModel.fromFirestore(document);
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? 'Failed to get teacher', code: e.code);
    }
  }

  Future<List<TeacherModel>> _queryTeachers({
    String? query,
    String? cursor,
    required int limit,
  }) async {
    try {
      Query<Map<String, dynamic>> request = _teachers.orderBy('fullName');
      final term = query?.trim();
      if (term != null && term.isNotEmpty) {
        request = request.startAt([term]).endAt(['$term\uf8ff']);
      }
      if (cursor != null) {
        final cursorDocument = await _teachers.doc(cursor).get();
        if (cursorDocument.exists)
          request = request.startAfterDocument(cursorDocument);
      }
      final snapshot = await request.limit(limit + 1).get();
      return snapshot.docs.map(TeacherModel.fromFirestore).toList();
    } on FirebaseException catch (e) {
      throw ServerException(
        e.message ?? 'Failed to get teachers',
        code: e.code,
      );
    }
  }
}
