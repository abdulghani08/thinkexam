import 'package:cloud_firestore/cloud_firestore.dart';
import '../../core/constants/collection_names.dart';
import '../../core/error/exceptions.dart';
import '../../core/logging/app_logger.dart';
import '../models/class_model.dart';
import 'base_datasource.dart';

/// Firestore access for class administration records.
class FirestoreClassDataSource extends BaseDataSource {
  final FirebaseFirestore _firestore;
  FirestoreClassDataSource(this._firestore);

  CollectionReference<Map<String, dynamic>> get _classes =>
      _firestore.collection(CollectionNames.classes);

  Future<ClassModel> createClass(ClassModel classRoom) async {
    try {
      final reference = _classes.doc(classRoom.id);
      if ((await reference.get()).exists) {
        throw const ConflictException(
          'A class with this ID already exists',
        );
      }
      await reference.set(classRoom.toCreateMap());
      AppLogger.i('Class ${classRoom.id} created');
      return _getClass(classRoom.id);
    } on FirebaseException catch (e) {
      throw ServerException(
        e.message ?? 'Failed to create class',
        code: e.code,
      );
    }
  }

  Future<ClassModel> getClassById(String id) => _getClass(id);

  Future<List<ClassModel>> getClasses({
    String? cursor,
    int limit = 20,
  }) => _queryClasses(cursor: cursor, limit: limit);

  Future<List<ClassModel>> searchClasses(
    String query, {
    String? cursor,
    int limit = 20,
  }) => _queryClasses(query: query, cursor: cursor, limit: limit);

  Future<List<ClassModel>> getClassesByGrade(int grade) async {
    try {
      final snapshot = await _classes
          .where('grade', isEqualTo: grade)
          .orderBy('className')
          .get();
      return snapshot.docs.map(ClassModel.fromFirestore).toList();
    } on FirebaseException catch (e) {
      throw ServerException(
        e.message ?? 'Failed to get classes by grade',
        code: e.code,
      );
    }
  }

  Future<ClassModel> updateClass(ClassModel classRoom) async {
    try {
      final reference = _classes.doc(classRoom.id);
      if (!(await reference.get()).exists) {
        throw const NotFoundException('Class not found');
      }
      await reference.update(classRoom.toUpdateMap());
      AppLogger.i('Class ${classRoom.id} updated');
      return _getClass(classRoom.id);
    } on FirebaseException catch (e) {
      throw ServerException(
        e.message ?? 'Failed to update class',
        code: e.code,
      );
    }
  }

  Future<void> deleteClass(String id) async {
    try {
      final reference = _classes.doc(id);
      if (!(await reference.get()).exists) {
        throw const NotFoundException('Class not found');
      }
      await reference.delete();
      AppLogger.i('Class $id deleted');
    } on FirebaseException catch (e) {
      throw ServerException(
        e.message ?? 'Failed to delete class',
        code: e.code,
      );
    }
  }

  Future<ClassModel> _getClass(String id) async {
    try {
      final document = await _classes.doc(id).get();
      if (!document.exists) throw const NotFoundException('Class not found');
      return ClassModel.fromFirestore(document);
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? 'Failed to get class', code: e.code);
    }
  }

  Future<List<ClassModel>> _queryClasses({
    String? query,
    String? cursor,
    required int limit,
  }) async {
    try {
      Query<Map<String, dynamic>> request = _classes.orderBy('grade').orderBy('className');
      
      final term = query?.trim();
      if (term != null && term.isNotEmpty) {
        request = request.startAt([term]).endAt(['$term\uf8ff']);
      }
      
      if (cursor != null) {
        final cursorDocument = await _classes.doc(cursor).get();
        if (cursorDocument.exists)
          request = request.startAfterDocument(cursorDocument);
      }
      
      final snapshot = await request.limit(limit + 1).get();
      return snapshot.docs.map(ClassModel.fromFirestore).toList();
    } on FirebaseException catch (e) {
      throw ServerException(
        e.message ?? 'Failed to get classes',
        code: e.code,
      );
    }
  }
}
