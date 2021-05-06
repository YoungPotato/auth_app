import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthBaseRepository {
  Future<void> signInWithEmailAndPassword({
    String email,
    String password,
  });

  Future<void> signUpWithEmailAndPassword({
    String email,
    String password,
  });

  Future<void> signInWithGoogle();

  Future<void> signOut();

  Future<void> updatePassword(String newPassword);

  Future<void> sendPasswordResetEmail(String email);

  User get user;
}
