part of 'profile_bloc.dart';


class ProfileState extends Equatable {
  const ProfileState();
  
  @override
  List<Object> get props => [];
}


class ProfileInitial extends ProfileState {}
class ProfileLoadingState extends ProfileState {}
class ProfileSuccessState extends ProfileState {
  final RegistrationModel profile;

  const ProfileSuccessState(this.profile);
}

class ProfileErrorState extends ProfileState {
  final String errorMessage;

  const ProfileErrorState(this.errorMessage);
}