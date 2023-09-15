
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/helpingFunctions.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit)async {
     if (event is CameragalleryEvent) {
        try {
          final ImagePicker picker = ImagePicker();
          final XFile? pickedFile = await picker.pickImage(
            source: event.source,
            maxHeight: 1080,
            maxWidth: 1080,
          );
          final croppedFile = await CropFunction.cropImage(pickedFile!.path);

          emit(ImagePickedSuccess(imageFile: File(croppedFile!.path)));
        } catch (e) {
          emit(Error(errorMessage: 'Error: $e'));
        }
      }
    });
  }
}


