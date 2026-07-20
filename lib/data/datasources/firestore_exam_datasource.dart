import 'package:cloud_firestore/cloud_firestore.dart';
import '../../core/constants/collection_names.dart';
import '../../core/error/exceptions.dart';
import '../../core/logging/app_logger.dart';
import '../models/exam_model.dart';
import 'base_datasource.dart';

/// Firestore access for exam administration records.
class FirestoreExamDataSource extends BaseDataSource {
  final FirebaseFirestore _firestore;
  FirestoreExamDataSource(this._firestore);

  CollectionReference<Map<String, dynamic>> get _exams =>
      _firestore.collection(CollectionNames.exams);

  Future<ExamModel> createExam(ExamModel exam) async {
    try {
      final reference = _exams.doc(exam.id);
      if ((await reference.get()).exists) {
        throw const ConflictException(
          'An exam with this ID already exists',
        );
      }
      await reference.set(exam.toCreateMap());
      AppLogger.i('Exam ${exam.id} created');
      return _getExam(exam.id);
    } on FirebaseException catch (e) {
      throw ServerException(
        e.message ?? 'Failed to create exam',
        code: e.code,
      );
    }
  }

  Future<ExamModel> getExamById(String id) => _getExam(id);

  Future<List<ExamModel>> getExams({
    String? cursor,
    int limit = 20,
    String? status,
  }) => _queryExams(cursor: cursor, limit: limit, status: status);

  Future<List<ExamModel>> searchExams(
    String query, {
    String? cursor,
    int limit = 20,
    String? status,
  }) => _queryExams(
        query: query,
        cursor: cursor,
        limit: limit,
        status: status,
      );

  Future<ExamModel> updateExam(ExamModel exam) async {
    try {
      final reference = _exams.doc(exam.id);
      if (!(await reference.get()).exists) {
        throw const NotFoundException('Exam not found');
      }
      await reference.update(exam.toUpdateMap());
      AppLogger.i('Exam ${exam.id} updated');
      return _getExam(exam.id);
    } on FirebaseException catch (e) {
      throw ServerException(
        e.message ?? 'Failed to update exam',
        code: e.code,
      );
    }
  }

  Future<void> deleteExam(String id) async {
    try {
      final reference = _exams.doc(id);
      if (!(await reference.get()).exists) {
        throw const NotFoundException('Exam not found');
      }
      await reference.delete();
      AppLogger.i('Exam $id deleted');
    } on FirebaseException catch (e) {
      throw ServerException(
        e.message ?? 'Failed to delete exam',
        code: e.code,
      );
    }
  }

  Future<ExamModel> duplicateExam(String examId, String createdBy) async {
    try {
      final original = await _getExam(examId);
      final newId = _exams.doc().id;
      final duplicated = ExamModel(
        id: newId,
        title: '${original.title} (Copy)',
        description: original.description,
        subjectId: original.subjectId,
        allowedClassIds: original.allowedClassIds,
        durationMinutes: original.durationMinutes,
        startTime: null,
        endTime: null,
        status: 'draft',
        randomQuestion: original.randomQuestion,
        randomOption: original.randomOption,
        showResult: original.showResult,
        passingGrade: original.passingGrade,
        createdBy: createdBy,
      );
      await _exams.doc(newId).set(duplicated.toCreateMap());
      AppLogger.i('Exam $examId duplicated to $newId');
      return _getExam(newId);
    } on FirebaseException catch (e) {
      throw ServerException(
        e.message ?? 'Failed to duplicate exam',
        code: e.code,
      );
    }
  }

  Future<ExamModel> publishExam(String examId) async {
    try {
      final exam = await _getExam(examId);
      final updated = ExamModel(
        id: exam.id,
        title: exam.title,
        description: exam.description,
        subjectId: exam.subjectId,
        allowedClassIds: exam.allowedClassIds,
        durationMinutes: exam.durationMinutes,
        startTime: exam.startTime,
        endTime: exam.endTime,
        status: 'published',
        randomQuestion: exam.randomQuestion,
        randomOption: exam.randomOption,
        showResult: exam.showResult,
        passingGrade: exam.passingGrade,
        createdBy: exam.createdBy,
        createdAt: exam.createdAt,
        updatedAt: exam.updatedAt,
      );
      await _exams.doc(examId).update(updated.toUpdateMap());
      AppLogger.i('Exam $examId published');
      return _getExam(examId);
    } on FirebaseException catch (e) {
      throw ServerException(
        e.message ?? 'Failed to publish exam',
        code: e.code,
      );
    }
  }

  Future<ExamModel> archiveExam(String examId) async {
    try {
      final exam = await _getExam(examId);
      final updated = ExamModel(
        id: exam.id,
        title: exam.title,
        description: exam.description,
        subjectId: exam.subjectId,
        allowedClassIds: exam.allowedClassIds,
        durationMinutes: exam.durationMinutes,
        startTime: exam.startTime,
        endTime: exam.endTime,
        status: 'archived',
        randomQuestion: exam.randomQuestion,
        randomOption: exam.randomOption,
        showResult: exam.showResult,
        passingGrade: exam.passingGrade,
        createdBy: exam.createdBy,
        createdAt: exam.createdAt,
        updatedAt: exam.updatedAt,
      );
      await _exams.doc(examId).update(updated.toUpdateMap());
      AppLogger.i('Exam $examId archived');
      return _getExam(examId);
    } on FirebaseException catch (e) {
      throw ServerException(
        e.message ?? 'Failed to archive exam',
        code: e.code,
      );
    }
  }

  Future<ExamModel> _getExam(String id) async {
    try {
      final document = await _exams.doc(id).get();
      if (!document.exists) throw const NotFoundException('Exam not found');
      return ExamModel.fromFirestore(document);
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? 'Failed to get exam', code: e.code);
    }
  }

  Future<List<ExamModel>> _queryExams({
    String? query,
    String? cursor,
    required int limit,
    String? status,
  }) async {
    try {
      Query<Map<String, dynamic>> request = _exams;
      
      if (status != null && status.isNotEmpty) {
        request = request.where('status', isEqualTo: status);
      }

      request = request.orderBy('createdAt', descending: true);
      
      final term = query?.trim();
      if (term != null && term.isNotEmpty) {
        request = request.startAt([term]).endAt(['$term\uf8ff']);
      }
      
      if (cursor != null) {
        final cursorDocument = await _exams.doc(cursor).get();
        if (cursorDocument.exists)
          request = request.startAfterDocument(cursorDocument);
      }
      
      final snapshot = await request.limit(limit + 1).get();
      return snapshot.docs.map(ExamModel.fromFirestore).toList();
    } on FirebaseException catch (e) {
      throw ServerException(
        e.message ?? 'Failed to get exams',
        code: e.code,
      );
    }
  }
}
