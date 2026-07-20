import 'package:cloud_firestore/cloud_firestore.dart';
import '../../core/constants/collection_names.dart';
import '../../core/error/exceptions.dart';
import '../../core/logging/app_logger.dart';
import '../../domain/entities/user_role.dart';
import 'base_datasource.dart';

/// Firestore Authentication data source
/// Handles role and authorization checks from Firestore
class FirestoreAuthDataSource extends BaseDataSource {
  final FirebaseFirestore _firestore;

  static const String adminEmail = 'thinkdataproject@gmail.com';

  FirestoreAuthDataSource(this._firestore);

  /// Get user role from Firestore
  /// Auto-detects admin by email, auto-creates student if not found
  Future<UserRole?> getUserRole(String userId, {String? email}) async {
    try {
      AppLogger.i('Checking user role for userId: $userId, email: $email');

      // Auto-detect admin by email (no Firestore lookup needed)
      if (email != null && email == adminEmail) {
        AppLogger.i('User $userId is admin (detected by email)');
        return UserRole(
          id: userId,
          userId: userId,
          role: 'ADMIN',
        );
      }

      // Check teachers collection (for manually added admins)
      AppLogger.i('Checking teachers collection...');
      final teacherDoc = await _firestore
          .collection(CollectionNames.teachers)
          .doc(userId)
          .get();

      if (teacherDoc.exists) {
        AppLogger.i('User found in teachers collection');
        final data = teacherDoc.data()!;
        if (data['isActive'] == false) {
          AppLogger.w('Inactive teacher $userId attempted to authenticate');
          return null;
        }
        AppLogger.i('User $userId is a teacher (admin)');
        return UserRole(
          id: teacherDoc.id,
          userId: userId,
          role: 'ADMIN',
          createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
          updatedAt: (data['updatedAt'] as Timestamp?)?.toDate(),
        );
      }

      // Check students collection
      AppLogger.i('Checking students collection...');
      final studentDoc = await _firestore
          .collection(CollectionNames.students)
          .doc(userId)
          .get();

      if (studentDoc.exists) {
        AppLogger.i('User found in students collection');
        final data = studentDoc.data()!;
        if (data['isActive'] == false) {
          AppLogger.w('Inactive student $userId attempted to authenticate');
          return null;
        }
        AppLogger.i('User $userId is a student');
        return UserRole(
          id: studentDoc.id,
          userId: userId,
          role: 'STUDENT',
          createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
          updatedAt: (data['updatedAt'] as Timestamp?)?.toDate(),
        );
      }

      // Auto-create student record for new users
      AppLogger.i('User not found, auto-creating student record for $userId');
      final now = FieldValue.serverTimestamp();
      final studentData = {
        'email': email ?? '',
        'isActive': true,
        'role': 'STUDENT',
        'createdAt': now,
        'updatedAt': now,
      };

      await _firestore
          .collection(CollectionNames.students)
          .doc(userId)
          .set(studentData);

      AppLogger.i('Student record created for $userId');
      return UserRole(
        id: userId,
        userId: userId,
        role: 'STUDENT',
      );
    } on FirebaseException catch (e) {
      AppLogger.e('Firestore exception getting user role: $e');
      throw ServerException(
        'Failed to get user role: ${e.message}',
        code: e.code,
      );
    } catch (e) {
      AppLogger.e('Unknown error getting user role: $e');
      throw UnknownException('Failed to get user role');
    }
  }

  /// Check if user is authorized (always true - everyone can sign in)
  Future<bool> isUserAuthorized(String userId, {String? email}) async {
    try {
      final role = await getUserRole(userId, email: email);
      return role != null;
    } catch (e) {
      AppLogger.e('Error checking user authorization: $e');
      return false;
    }
  }
}