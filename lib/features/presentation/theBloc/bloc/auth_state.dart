part of 'auth_bloc.dart';



class AuthState {}

class AuthInitial extends AuthState {}

class Error extends AuthState {
  final String errorMessage;

  Error({required this.errorMessage});
}

class ImagePickedSuccess extends AuthState {
  final File imageFile;

  ImagePickedSuccess({
    required this.imageFile,
  });
}
