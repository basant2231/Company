part of 'register_bloc.dart';

@immutable

@immutable
class RegisterState {}

class RegisterInitial extends RegisterState {}

class ImagePickedSuccess extends RegisterState {
  final File imageFile;

  ImagePickedSuccess({required this.imageFile});
}

class ImagePickedError extends RegisterState {
  final String errorMessage;

  ImagePickedError({required this.errorMessage});
}
