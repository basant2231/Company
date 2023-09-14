import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

import '../../../../core/helpingFunctions.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterEvent>((event, emit) async {
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
          emit(ImagePickedError(errorMessage: 'Error: $e'));
        }
      }
    });
  }
}
