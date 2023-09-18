import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../presentation/theBloc/bloc/auth_bloc.dart';

class ForgotPasswordViewModel {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<Either<String, bool>> handleForgotPasswordEvent(
    ForgotPasswordEvent event,
  ) async {
    try {
      await _auth.sendPasswordResetEmail(email: event.email);
      return right(true); // Password reset email sent successfully.
    } catch (e) {
      return left('Password reset failed: $e'); // Error occurred during password reset.
    }
  }
}
