import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/Registermodel.dart';

class ProfileViewModel {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<Either<String, RegistrationModel>> handleFetchProfileEvent() async {
    try {
      final user = _auth.currentUser;

      if (user != null) {
        final userData =
            await _firestore.collection('users').doc(user.uid).get();

        if (userData.exists) {
          final registrationData = userData.data();
          if (registrationData != null &&
              registrationData is Map<String, dynamic>) {
            final registrationModel = RegistrationModel(
              fullName: registrationData['fullName'],
              imagePath: registrationData['imagePath'] as String,
              phoneNumber: registrationData['phoneNumber'],
              position: registrationData['position'],
              emailAddress: user.email ?? '', password: '',
              
            );
            print("-------------------------------${user.uid}");
            print(" =====================${registrationData['imagePath']}");
            return right(registrationModel);
          } else {
            return left('User profile data is not valid or null.');
          }
        } else {
          return left('User profile not found.');
        }
      } else {
        return left('User not signed in.');
      }
    } catch (e) {
      return left('Error fetching user profile: $e');
    }
  }
}
