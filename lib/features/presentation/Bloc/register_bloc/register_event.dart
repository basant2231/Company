part of 'register_bloc.dart';

@immutable
class RegisterEvent {}
class CameragalleryEvent extends RegisterEvent {
  final ImageSource source;

  CameragalleryEvent({required this.source});
}
