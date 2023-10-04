import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/EmployeeModel.dart';

class EmployeeViewModel {
  Future<Either<String, List<EmployeeModel>>> fetchTasks() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      final querySnapshotUsers = await firestore.collection('users').get();

      final List<EmployeeModel> employeesList = [];

     
        for (final employeeData in querySnapshotUsers.docs) {
          final employee = EmployeeModel(
            fullName: employeeData['fullName'] ?? '',
            imagePath: employeeData['imagePath'] ?? '',
            phoneNumber: employeeData['phoneNumber'] ?? '',
            position: employeeData['position'] ?? '',
            email: employeeData['email'] ?? '',
          );

          employeesList.add(employee);
          print(employee);
        }
    
 print("111111111111111111111111111111111111111111111111"); 
      return Right(employeesList); // Return the list of employees wrapped in Right
    } catch (e) {
 print("222222222222222222222222222222222222222222222222"); 
      return Left('Error fetching employees: $e'); // Return error message wrapped in Left
    }
  }
}
