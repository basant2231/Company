


import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';


import '../presentation/theBloc/bloc/auth_bloc.dart';

class LoginViewModel {
  final FirebaseAuth _auth = FirebaseAuth.instance;
    Future<Either<String, UserCredential>> handleLoginEvent(
    LoginEvent event,
  ) async {
    try {
      final UserCredential authResult = await _auth.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );

      return right(authResult);
    } catch (e) {
      return left('Login Error: $e');
    }
  }
}
