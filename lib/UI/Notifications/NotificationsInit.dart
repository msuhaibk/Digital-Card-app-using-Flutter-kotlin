import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:fliqcard/Helpers/constants.dart';
import 'package:flutter/material.dart';

awesome_notification_init() {
  AwesomeNotifications().initialize(
      'resource://drawable/ic_launcher',
    [
      NotificationChannel(
          channelKey: '10000',
          channelName: 'High Importance Notifications',
          channelDescription:
              'This channel is used for important notifications.',
          defaultColor: Color(COLOR_PRIMARY),
          ledColor: Color(COLOR_PRIMARY),
          enableVibration: true,
          importance: NotificationImportance.High)
    ],
  );
}

