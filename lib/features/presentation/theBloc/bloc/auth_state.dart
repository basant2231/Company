part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class ImagePickedLoadingState extends AuthState {}

class ImagePickedFailedState extends AuthState {
  final String errorMessage;

  const ImagePickedFailedState({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

class ImagePickedSuccessState extends AuthState {
  final File imageFile;

  const ImagePickedSuccessState({
    required this.imageFile,
  });

  @override
  List<Object?> get props => [imageFile];
}

/*********************************************************************************************************** */
class RegistrationLoadingState extends AuthState {}

class RegistrationFailureState extends AuthState {
  final String errorMessage;

  const RegistrationFailureState({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

class RegistrationSuccessState extends AuthState {
  final RegistrationModel registrationModel; // Change this to RegistrationModel

  const RegistrationSuccessState({
    required this.registrationModel,
  });

  @override
  List<Object?> get props => [registrationModel];
}

/*********************************************************************************************************** */
class LoginLoadingState extends AuthState {}

class LoginSuccessState extends AuthState {
  final User
      user; // Replace 'User' with the actual user class from Firebase or your user model

  LoginSuccessState({required this.user});

  @override
  List<Object?> get props => [user];
}

class LoginFailureState extends AuthState {
  final String errorMessage;

  const LoginFailureState({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
/***********************************************************************************************************/
class ForgotPasswordLoadingState extends AuthState {}

class ForgotPasswordSuccessState extends AuthState {}

class ForgotPasswordFailureState extends AuthState {
  final String error;

  ForgotPasswordFailureState({required this.error});

  @override
  List<Object?> get props => [error];
}
