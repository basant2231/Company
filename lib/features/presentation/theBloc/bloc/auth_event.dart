part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class CameragalleryEvent extends AuthEvent {
  final ImageSource source;

  const CameragalleryEvent({
    required this.source,
  });

  @override
  List<Object> get props => [source];
}
/*********************************************************************************** */
class RegisterUserEvent extends AuthEvent {
  final RegistrationModel registrationModel;

  const RegisterUserEvent({
    required this.registrationModel,
  });

  @override
  List<Object> get props => [registrationModel];
}
/*********************************************************************************** */

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  LoginEvent({required this.email, required this.password});

  //@override
 // List<Object?> get props => [email, password];
}