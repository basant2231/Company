import 'package:company/features/presentation/widgets/Dialogs/errorsuccessDialog.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:image_cropper/image_cropper.dart';

class CropFunction {
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

class LaunchUtilsFunctions {
  static Future<void> openWhatsAppChat(String phoneNumber, context) async {
    var whatsappUrl = Uri.parse(
        "https://wa.me/$phoneNumber?text=${Uri.encodeQueryComponent('Hello')}");
    
    if (await canLaunchUrl(whatsappUrl)) {
      await launchUrl(whatsappUrl);
    } else {
      showErrorDialog(context, 'Unable to open WhatsApp');
    }
  }

  static Future<void> mailTo(String email, context) async {
    var url = Uri.parse('mailto:$email');
    
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      showErrorDialog(context, 'Unable to open email');
    }
  }

  static Future<void> callPhoneNumber(String phoneNumber, context) async {
    var phoneUrl = Uri.parse('tel:$phoneNumber');
    
    if (await canLaunchUrl(phoneUrl)) {
      await launchUrl(phoneUrl);
    } else {
      showErrorDialog(context, 'Unable to make a phone call');
    }
  }

 
}
