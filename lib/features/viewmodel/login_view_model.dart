import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../view/theBloc/authBloc/auth_bloc.dart';


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

Future<Either<String, UserCredential>> signInWithGoogle() async {
  try {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Check if googleUser is null
    if (googleUser == null) {
      return left('Google Sign-In Error: User cancelled the sign-in process');
    }

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser.authentication;

    // Check if googleAuth is null
    if (googleAuth == null) {
      return left('Google Sign-In Error: No authentication details available');
    }

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential as Right
    UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
    return right(userCredential);
  } catch (e) {
    // If there is an error, return the error message as Left
    return left('Google Sign-In Error: $e');
  }
}

}
