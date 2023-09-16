// models/registration_data.dart
import 'dart:io';

class RegistrationModel {
  final String emailAddress;
  final String password;

  final String fullName;
  final String phoneNumber;
  final String position;
  final File imageFile;
  RegistrationModel({
    required this.emailAddress,
    required this.password,
   
    required this.fullName,
    required this.phoneNumber,
    required this.position,
    required this.imageFile,
  });
 
}
