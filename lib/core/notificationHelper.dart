
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class NotificationHelper {
  static Future<void> initializeNotifications() async {
    AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelKey: 'key1',
          channelName: 'Task Notifications',
          channelDescription: 'New task notifications',
          importance: NotificationImportance.High,
          defaultColor: Colors.blue,
          ledColor: Colors.blue,
        ),
      ],
    );
  }

  static Future<void> sendTaskNotification() async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 1,
        channelKey: 'key1',
        title: 'New Task Added!',
        body: 'A new task has been added. Check it out!',
        displayOnForeground: true, 
        largeIcon: 'assets/images/companylogo.png',
         notificationLayout: NotificationLayout.BigPicture,
          bigPicture: 'assets/images/companylogo.png',
      ),
    );
  }
}