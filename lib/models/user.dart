import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class User {
  final String uid;
  final String? email;
  final String? username;

  User({required this.uid, this.email, this.username});

  factory User.fromFirebaseUser(firebase_auth.User user) {
    return User(uid: user.uid, email: user.email, username: user.displayName);
  }
}
