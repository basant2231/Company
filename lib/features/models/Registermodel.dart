// models/registration_data.dart
import 'dart:io';

import 'package:equatable/equatable.dart';

class RegistrationModel extends Equatable {
  final String emailAddress;
  final String password;
  final String fullName;
  final String phoneNumber;
  final String position;
 File? imageFile;
final String? imagePath; 
  RegistrationModel({
    required this.emailAddress,
    required this.password,
    required this.fullName,
    required this.phoneNumber,
    required this.position,
    this.imageFile,
    this.imagePath,
  });

  @override
  List<Object?> get props => [
        emailAddress,
        password,
        fullName,
        phoneNumber,
        position,
        imageFile,
        imagePath
      ];
       factory RegistrationModel.fromJson(Map<String, dynamic> json) {
    return RegistrationModel(
      emailAddress: json['emailAddress'] as String,
      password: json['password'] as String,
      fullName: json['fullName'] as String,
      phoneNumber: json['phoneNumber'] as String,
      position: json['position'] as String,
      imagePath: json['imagePath'] as String,
      imageFile: File(json['imageFilePath'] as String), // Assuming you store the file path as a string
    );
  }

}


