import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:company/features/presentation/widgets/Dialogs/errorsuccessDialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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

 String calculateTimeLeft(String deadlineDate) {
  try {
    final now = DateTime.now();
    
    // Define the date format you expect from the date picker dialog
    final expectedDateFormat = DateFormat('yyyy-MM-dd'); // Adjust the format as needed
    
    // Parse the date using the expected format
    final parsedDeadlineDate = expectedDateFormat.parse(deadlineDate);

    if (now.isBefore(parsedDeadlineDate)) {
      final difference = parsedDeadlineDate.difference(now);
      final days = difference.inDays;
      final hours = difference.inHours.remainder(24);
      final minutes = difference.inMinutes.remainder(60);

      return 'Still have time: $days days, $hours hours, $minutes minutes';
    } else {
      return 'No time left!';
    }
  } catch (e) {
    return 'Invalid date format: $deadlineDate';
  }
}

