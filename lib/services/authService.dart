import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_demo/models/user.dart';

class AuthService {
  final firebase_auth.FirebaseAuth _auth = firebase_auth.FirebaseAuth.instance;

  Future<User?> register({
    required String email,
    required String password,
    required String username,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      await credential.user?.updateDisplayName(username);
      return User.fromFirebaseUser(credential.user!);
    } catch (e) {
      return null;
    }
  }

  Future<User?> login({required String email, required String password}) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      return User.fromFirebaseUser(credential.user!);
    } catch (e) {
      return null;
    }
  }
}
