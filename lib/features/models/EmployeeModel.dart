

import 'package:equatable/equatable.dart';

class EmployeeModel extends Equatable {
  final String fullName;
  final String imagePath;
  final String phoneNumber;
  final String position;
  final String email;

  EmployeeModel({
    required this.fullName,
    required this.imagePath,
    required this.phoneNumber,
    required this.position,
    required this.email,
  });

  @override
  List<Object?> get props => [fullName, imagePath, phoneNumber, position, email];
}
