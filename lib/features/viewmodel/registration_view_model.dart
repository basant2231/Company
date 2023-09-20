
import '../../core/helpingFunctions.dart';
import '../models/Registermodel.dart';

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

import 'package:uuid/uuid.dart';
import 'package:dartz/dartz.dart';

import '../presentation/theBloc/bloc/auth_bloc.dart';

  const uuid = Uuid();
   final String userId = uuid.v4();
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
      final UserCredential authResult =
          await _auth.createUserWithEmailAndPassword(
        email: event.registrationModel.emailAddress,
        password: event.registrationModel.password,
      );

      final String imageFileName = 'profile_images/${authResult.user!.uid}.jpg';
      final Reference storageRef = _storage.ref().child(imageFileName);
      final UploadTask uploadTask =
          storageRef.putFile(event.registrationModel.imageFile);

      await uploadTask.whenComplete(() async {
        final imageUrl = await storageRef.getDownloadURL();

        await _firestore.collection('users').doc(userId).set({
          'uid': userId,
          'fullName': event.registrationModel.fullName,
          'phoneNumber': event.registrationModel.phoneNumber,
          'position': event.registrationModel.position,
          'imagePath': imageUrl,
        });

        final registrationModel = event.registrationModel;
        registrationModel.imageFile = File(imageUrl);

        return right(registrationModel);
      });

      return right(event.registrationModel);
    } catch (e) {
      return left('Registration Error: $e');
    }
  }



}
