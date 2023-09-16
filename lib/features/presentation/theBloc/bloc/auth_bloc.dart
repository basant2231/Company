import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import 'package:uuid/uuid.dart';
import '../../../../core/helpingFunctions.dart';
import '../../../models/Registermodel.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final uuid = Uuid(); // Create a UUID instance

  AuthBloc() : super(AuthInitial()) {
    // Register event handlers
    on<CameragalleryEvent>(_handleCameraGalleryEvent);
    on<RegisterUserEvent>(_handleRegisterUserEvent);
    on<LoginEvent>(_handleLoginEvent); 
  }

  // Event handler for CameragalleryEvent
  void _handleCameraGalleryEvent(
      CameragalleryEvent event, Emitter<AuthState> emit) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? pickedFile = await picker.pickImage(
        source: event.source,
        maxHeight: 1080,
        maxWidth: 1080,
      );
      final croppedFile = await CropFunction.cropImage(pickedFile!.path);

      emit(ImagePickedSuccess(imageFile: File(croppedFile!.path)));
    } catch (e) {
      emit(Error(errorMessage: 'Error: $e'));
    }
  }

  // Event handler for RegisterUserEvent
  void _handleRegisterUserEvent(
      RegisterUserEvent event, Emitter<AuthState> emit) async {
    try {
      // Generate a UUID for the user
      final String userId = uuid.v4();

      // Register the user with Firebase Authentication
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
        emit(RegistrationLoaded(registrationModel: event.registrationModel));
      });
    } catch (e) {
      emit(RegistrationFailure(errorMessage: 'Registration Error: $e'));
    }
  }
// Inside AuthBloc class

// Event handler for LoginEvent
void _handleLoginEvent(LoginEvent event, Emitter<AuthState> emit) async {
  try {
    // Sign in the user with Firebase Authentication
    final UserCredential authResult = await _auth.signInWithEmailAndPassword(
      email: event.email,
      password: event.password,
    );

    // Check if the user is signed in successfully
    if (authResult.user != null) {
      // You can also fetch additional user information if needed

      // Emit Authenticated state
      emit(Authenticated(user: authResult.user!));
    } else {
      emit(LoginFailure(errorMessage: 'Login failed'));
    }
  } catch (e) {
    emit(LoginFailure(errorMessage: 'Login Error: $e'));
  }
}
}

