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
import '../../../viewmodel/registration_view_model.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthViewModel _authViewModel = AuthViewModel();

  AuthBloc() : super(AuthInitial()) {
    on<CameragalleryEvent>(_handleCameraGalleryEvent);
    on<RegisterUserEvent>(_handleRegisterUserEvent);
    on<LoginEvent>(_handleLoginEvent);
  }

  void _handleCameraGalleryEvent(
    CameragalleryEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(ImagePickedLoadingState());
    final result = await _authViewModel.handleCameraGalleryEvent(event);

    result.fold(
      (error) {
        emit(ImagePickedFailedState(errorMessage: error));
      },
      (imageFile) {
        emit(ImagePickedSuccessState(imageFile: imageFile));
      },
    );
  }

  void _handleRegisterUserEvent(
    RegisterUserEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(RegistrationLoadingState());
    final result = await _authViewModel.handleRegisterUserEvent(event);

    result.fold(
      (error) {
        emit(RegistrationFailureState(errorMessage: error));
      },
      (registrationModel) {
        emit(RegistrationSuccessState(registrationModel: registrationModel));
      },
    );
  }

  void _handleLoginEvent(
    LoginEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(LoginLoadingState());
    final result = await _authViewModel.handleLoginEvent(event);

    result.fold(
      (error) {
        emit(LoginFailureState(errorMessage: error));
      },
      (authResult) {
        emit(LoginSuccessState(user: authResult.user!));
      },
    );
  }
}
