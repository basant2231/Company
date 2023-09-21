import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../models/Registermodel.dart';
import '../../../viewmodel/profile_view_model.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileViewModel viewModel = ProfileViewModel();

  ProfileBloc() : super(ProfileInitial()) {
    
    on<FetchProfileEvent>(_handleFetchProfileEvent);
  }

 void _handleFetchProfileEvent(
  FetchProfileEvent event,
  Emitter<ProfileState> emit,
) async {
  emit(ProfileLoadingState());

  try {
    final eitherProfile = await viewModel.handleFetchProfileEvent(
      
    );
    final profileState = eitherProfile.fold(
      (error) => ProfileErrorState(error),
      (registrationModel) => ProfileSuccessState(registrationModel),
    );
    emit(profileState);
  } catch (e) {
    emit(ProfileErrorState('Error: $e'));
  }
}

}
