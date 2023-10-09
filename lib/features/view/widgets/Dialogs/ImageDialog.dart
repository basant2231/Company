
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../theBloc/authBloc/auth_bloc.dart';



class ImageDialogWidget extends StatelessWidget {
  const ImageDialogWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthBloc authbloc = BlocProvider.of<AuthBloc>(context);
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return AlertDialog(
          title: const Text('Please choose an option'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () {
                  // Dispatch the Cameragallery event with "camera" option
                  authbloc
                      .add(CameragalleryEvent(source: ImageSource.camera));
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.camera,
                        color: Colors.blue, // Change to your desired color
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      Text(
                        'Camera',
                        style: TextStyle(
                            color: Colors.blue), // Change to your desired color
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  authbloc
                      .add(CameragalleryEvent(source: ImageSource.gallery));
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.image,
                        color: Colors.blue, // Change to your desired color
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      Text(
                        'Gallery',
                        style: TextStyle(
                            color: Colors.blue), // Change to your desired color
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
