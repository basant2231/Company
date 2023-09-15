part of 'auth_bloc.dart';


abstract class AuthEvent {}

class CameragalleryEvent extends AuthEvent {
  final ImageSource source; // Use ImageSource from image_picker package

  CameragalleryEvent({
    required this.source,
  });
}

class RegisterUserEvent extends AuthEvent {
  final String emailAddress;
  final String password;

  RegisterUserEvent({
    required this.emailAddress,
    required this.password,
  });
}