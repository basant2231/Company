
import 'package:company/features/viewmodel/profile_view_model.dart';

import '../../core/helpingFunctions.dart';
import '../../core/user_manager.dart';
import '../models/Registermodel.dart';

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

import 'package:uuid/uuid.dart';
import 'package:dartz/dartz.dart';

import '../view/theBloc/authBloc/auth_bloc.dart';


final uuid = const Uuid();

class RegisterViewModel {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Either<String, File>> handleCameraGalleryEvent(
    CameragalleryEvent event,
  ) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? pickedFile = await picker.pickImage(
        source: event.source,
        maxHeight: 1080,
        maxWidth: 1080,
      );
      final croppedFile = await CropFunction.cropImage(pickedFile!.path);

      return right(File(croppedFile!.path));
    } catch (e) {
      return left('Error: $e');
    }
  }

  Future<Either<String, RegistrationModel>> handleRegisterUserEvent(
    RegisterUserEvent event,
  ) async {
    try {
      final UserCredential authResult = await _auth.createUserWithEmailAndPassword(
        email: event.registrationModel.emailAddress,
        password: event.registrationModel.password,
      );

      final String userIdd = authResult.user!.uid;

      // Set the document data
      final String imageFileName = 'profile_images/$userIdd.jpg';
      final Reference storageRef = _storage.ref().child(imageFileName);
      final UploadTask uploadTask = storageRef.putFile(event.registrationModel.imageFile!);

      await uploadTask.whenComplete(() async {
        final imageUrl = await storageRef.getDownloadURL();

        // Set the document data in Firestore
        final DocumentReference userDocRef =
            _firestore.collection('users').doc(userIdd);
        await userDocRef.set({
          'uid': userIdd,
          'fullName': event.registrationModel.fullName,
          'phoneNumber': event.registrationModel.phoneNumber,
          'position': event.registrationModel.position,
          'imagePath': imageUrl,
          "email":event.registrationModel.emailAddress
        });

        // Retrieve the document to get the 'uid' value
        final userData = await userDocRef.get();

        final Map<String, dynamic>? userDataMap = userData.data() as Map<String, dynamic>?;

        if (userDataMap != null && userDataMap.containsKey('uid')) {
          final uid = userDataMap['uid'] as String;
          print('Retrieved UID from Firestore: $uid');

          final registrationModel = event.registrationModel;
          registrationModel.imageFile = File(imageUrl);

          return right(registrationModel);
        } else {
          return left('User document not found in Firestore or does not contain UID.');
        }
      });

      return right(event.registrationModel);
    } catch (e) {
      return left('Registration Error: $e');
    }


    
  }
}
