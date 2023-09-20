


import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LogoutViewModel {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<Either<String, Unit>> handleLogoutEvent() async {
    try {
      await _auth.signOut();
      return right(unit);
    } catch (e) {
      return left('Logout Error: $e');
    }
  }
}