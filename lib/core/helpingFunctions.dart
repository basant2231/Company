



import 'package:image_cropper/image_cropper.dart';

class Functions{
 static Future<CroppedFile?> cropImage(String filePath) async {
  try {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: filePath,
      maxHeight: 1080,
      maxWidth: 1080,
    );
    return croppedFile;
  } catch (e) {
    return null;
  }
}

}