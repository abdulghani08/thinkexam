import 'package:cloud_firestore/cloud_firestore.dart';
import '../../core/constants/collection_names.dart';
import '../../core/error/exceptions.dart';
import '../../core/logging/app_logger.dart';
import '../models/student_model.dart';
import 'base_datasource.dart';

/// Firestore access for student administration records.
class FirestoreStudentDataSource extends BaseDataSource {
  final FirebaseFirestore _firestore;
  FirestoreStudentDataSource(this._firestore);

  CollectionReference<Map<String, dynamic>> get _students =>
      _firestore.collection(CollectionNames.students);

  Future<StudentModel> createStudent(StudentModel student) async {
    try {
      final reference = _students.doc(student.id);
      if ((await reference.get()).exists) {
        throw const ConflictException(
          'A student with this ID already exists',
        );
      }
      await reference.set(student.toCreateMap());
      AppLogger.i('Student ${student.id} created');
      return _getStudent(student.id);
    } on FirebaseException catch (e) {
      throw ServerException(
        e.message ?? 'Failed to create student',
        code: e.code,
      );
    }
  }

  Future<StudentModel> getStudentById(String id) => _getStudent(id);

  Future<List<StudentModel>> getStudents({
    String? cursor,
    int limit = 20,
    String? classId,
  }) => _queryStudents(cursor: cursor, limit: limit, classId: classId);

  Future<List<StudentModel>> searchStudents(
    String query, {
    String? cursor,
    int limit = 20,
    String? classId,
  }) => _queryStudents(
        query: query,
        cursor: cursor,
        limit: limit,
        classId: classId,
      );

  Future<List<StudentModel>> getStudentsByClassId(String classId) async {
    try {
      final snapshot = await _students
          .where('classId', isEqualTo: classId)
          .where('isActive', isEqualTo: true)
          .orderBy('fullName')
          .get();
      return snapshot.docs.map(StudentModel.fromFirestore).toList();
    } on FirebaseException catch (e) {
      throw ServerException(
        e.message ?? 'Failed to get students by class',
        code: e.code,
      );
    }
  }

  Future<StudentModel> updateStudent(StudentModel student) async {
    try {
      final reference = _students.doc(student.id);
      if (!(await reference.get()).exists) {
        throw const NotFoundException('Student not found');
      }
      await reference.update(student.toUpdateMap());
      AppLogger.i('Student ${student.id} updated');
      return _getStudent(student.id);
    } on FirebaseException catch (e) {
      throw ServerException(
        e.message ?? 'Failed to update student',
        code: e.code,
      );
    }
  }

  Future<void> deleteStudent(String id) async {
    try {
      final reference = _students.doc(id);
      if (!(await reference.get()).exists) {
        throw const NotFoundException('Student not found');
      }
      await reference.delete();
      AppLogger.i('Student $id deleted');
    } on FirebaseException catch (e) {
      throw ServerException(
        e.message ?? 'Failed to delete student',
        code: e.code,
      );
    }
  }

  Future<StudentModel> _getStudent(String id) async {
    try {
      final document = await _students.doc(id).get();
      if (!document.exists) throw const NotFoundException('Student not found');
      return StudentModel.fromFirestore(document);
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? 'Failed to get student', code: e.code);
    }
  }

  Future<List<StudentModel>> _queryStudents({
    String? query,
    String? cursor,
    required int limit,
    String? classId,
  }) async {
    try {
      Query<Map<String, dynamic>> request = _students;
      
      if (classId != null && classId.isNotEmpty) {
        request = request.where('classId', isEqualTo: classId);
      }

      request = request.orderBy('fullName');
      
      final term = query?.trim();
      if (term != null && term.isNotEmpty) {
        request = request.startAt([term]).endAt(['$term\uf8ff']);
      }
      
      if (cursor != null) {
        final cursorDocument = await _students.doc(cursor).get();
        if (cursorDocument.exists)
          request = request.startAfterDocument(cursorDocument);
      }
      
      final snapshot = await request.limit(limit + 1).get();
      return snapshot.docs.map(StudentModel.fromFirestore).toList();
    } on FirebaseException catch (e) {
      throw ServerException(
        e.message ?? 'Failed to get students',
        code: e.code,
      );
    }
  }
}
