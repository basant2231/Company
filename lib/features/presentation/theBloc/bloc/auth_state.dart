part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class Error extends AuthState {
  final String errorMessage;

  const Error({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

class ImagePickedSuccess extends AuthState {
  final File imageFile;

  const ImagePickedSuccess({
    required this.imageFile,
  });

  @override
  List<Object> get props => [imageFile];
}

/*********************************************************************************************************** */
class RegistrationLoading extends AuthState {}

class RegistrationFailure extends AuthState {
  final String errorMessage;

  const RegistrationFailure({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

class RegistrationLoaded extends AuthState {
  final RegistrationModel registrationModel; // Change this to RegistrationModel

  const RegistrationLoaded({
    required this.registrationModel,
  });
}

/*********************************************************************************************************** */
class Authenticated extends AuthState {
  final User
      user; // Replace 'User' with the actual user class from Firebase or your user model

  Authenticated({required this.user});

  //@override
  //List<Object?> get props => [user];
}

class LoginFailure extends AuthState {
  final String errorMessage;

  const LoginFailure({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
