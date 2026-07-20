import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:google_sign_in/google_sign_in.dart';
import '../../core/error/exceptions.dart';
import '../../core/logging/app_logger.dart';
import 'base_datasource.dart';

/// Firebase Authentication data source
/// Handles all Firebase Auth operations
class FirebaseAuthDataSource extends BaseDataSource {
  final auth.FirebaseAuth _firebaseAuth;
  static bool _googleSignInInitialized = false;

  FirebaseAuthDataSource(this._firebaseAuth);

  /// Get current authenticated user
  Future<auth.User?> getCurrentUser() async {
    try {
      return _firebaseAuth.currentUser;
    } catch (e) {
      AppLogger.e('Error getting current user: $e');
      throw UnknownException('Failed to get current user');
    }
  }

  /// Sign in with Google
  Future<auth.UserCredential> signInWithGoogle() async {
    try {
      late final auth.UserCredential userCredential;

      if (kIsWeb) {
        final googleProvider = auth.GoogleAuthProvider();
        googleProvider.addScope('email');
        googleProvider.addScope('profile');
        userCredential = await _firebaseAuth.signInWithPopup(googleProvider);
      } else {
        final GoogleSignIn googleSignIn = GoogleSignIn.instance;
        if (!_googleSignInInitialized) {
          await googleSignIn.initialize(
            serverClientId: '289982760199-622ob0a2kbdj7n615suqpvmoi3mnf2a0.apps.googleusercontent.com',
          );
          _googleSignInInitialized = true;
        }
        final GoogleSignInAccount account = await googleSignIn.authenticate();
        final GoogleSignInAuthentication tokens = await account.authentication;
        final credential = auth.GoogleAuthProvider.credential(
          idToken: tokens.idToken,
        );
        userCredential = await _firebaseAuth.signInWithCredential(credential);
      }

      AppLogger.i('Google sign in successful: ${userCredential.user?.email}');
      return userCredential;
    } on auth.FirebaseAuthException catch (e) {
      AppLogger.e('Firebase Auth exception during Google sign in: $e');
      throw AuthException(_getAuthErrorMessage(e.code), code: e.code);
    } catch (e) {
      AppLogger.e('Unknown error during Google sign in: $e');
      throw UnknownException('Failed to sign in with Google');
    }
  }

  /// Sign out
  Future<void> signOut() async {
    try {
      if (!kIsWeb) {
        final GoogleSignIn googleSignIn = GoogleSignIn.instance;
        await googleSignIn.signOut();
      }
      await _firebaseAuth.signOut();
      AppLogger.i('Sign out successful');
    } catch (e) {
      AppLogger.e('Error signing out: $e');
      throw UnknownException('Failed to sign out');
    }
  }

  /// Get Firebase Auth error message
  String _getAuthErrorMessage(String? code) {
    switch (code) {
      case 'user-cancelled':
        return 'Sign in was cancelled';
      case 'account-exists-with-different-credential':
        return 'An account already exists with the same email';
      case 'invalid-credential':
        return 'Invalid credential';
      case 'operation-not-allowed':
        return 'Operation not allowed';
      case 'user-disabled':
        return 'This user has been disabled';
      case 'user-not-found':
        return 'User not found';
      case 'wrong-password':
        return 'Wrong password';
      case 'invalid-email':
        return 'Invalid email';
      case 'email-already-in-use':
        return 'Email already in use';
      case 'weak-password':
        return 'Password is too weak';
      default:
        return 'An authentication error occurred';
    }
  }
}