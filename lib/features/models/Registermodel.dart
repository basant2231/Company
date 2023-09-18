// models/registration_data.dart
import 'dart:io';
import 'package:equatable/equatable.dart';

class RegistrationModel extends Equatable {
  final String emailAddress;
  final String password;
  final String fullName;
  final String phoneNumber;
  final String position;
 File imageFile;

  RegistrationModel({
    required this.emailAddress,
    required this.password,
    required this.fullName,
    required this.phoneNumber,
    required this.position,
    required this.imageFile,
  });

  @override
  List<Object?> get props => [
        emailAddress,
        password,
        fullName,
        phoneNumber,
        position,
        imageFile,
      ];
}
