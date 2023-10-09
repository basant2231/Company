import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import '../../../models/Registermodel.dart';
import '../../../viewmodel/forgotpassword_view_model.dart';
import '../../../viewmodel/logOut_view_model.dart';
import '../../../viewmodel/login_view_model.dart';
import '../../../viewmodel/registration_view_model.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final RegisterViewModel _registerViewModel = RegisterViewModel();
  final LoginViewModel _loginViewModel = LoginViewModel();
  final ForgotPasswordViewModel _forgotPasswordViewModel =
      ForgotPasswordViewModel();
  final LogoutViewModel _logoutViewModel =
      LogoutViewModel(); // Define _logoutViewModel

  AuthBloc() : super(AuthInitial()) {
    on<CameragalleryEvent>(_handleCameraGalleryEvent);
    on<RegisterUserEvent>(_handleRegisterUserEvent);
    on<LoginEvent>(_handleLoginEvent);
    on<ForgotPasswordEvent>(_handleForgotPasswordEvent);
    on<LogOutEvent>(_handleLogoutEvent);
    on<GoogleSigninEvent>(_handleGoogleSigninEvent);
  }

  void _handleCameraGalleryEvent(
    CameragalleryEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(ImagePickedLoadingState());
    final result = await _registerViewModel.handleCameraGalleryEvent(event);

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
    final result = await _registerViewModel.handleRegisterUserEvent(event);

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
    final result = await _loginViewModel.handleLoginEvent(event);

    result.fold(
      (error) {
        emit(LoginFailureState(errorMessage: error));
      },
      (authResult) {
        emit(LoginSuccessState(user: authResult.user!));
      },
    );
  }

  void _handleForgotPasswordEvent(
    ForgotPasswordEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(ForgotPasswordLoadingState());
    final result =
        await _forgotPasswordViewModel.handleForgotPasswordEvent(event);

    result.fold(
      (error) {
        emit(ForgotPasswordFailureState(error: error));
      },
      (_) {
        emit(ForgotPasswordSuccessState());
      },
    );
  }

  void _handleLogoutEvent(
    LogOutEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(LogoutLoadingState());
    final result = await _logoutViewModel.handleLogoutEvent();

    result.fold(
      (error) {
        emit(LogoutErrorState(errorMessage: error));
      },
      (_) {
        emit(LogoutSuccessState());
      },
    );
  }
  void _handleGoogleSigninEvent(
    GoogleSigninEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(LogoutLoadingState());
    final result = await _loginViewModel.signInWithGoogle();

    result.fold(
      (error) {
        emit(LoginGoogleFailureState(errorMessage: error));
      },
      (userCredential) {
        emit(LoginGoogleSuccessState(userCredential: userCredential));
      },
    );
  }
}
