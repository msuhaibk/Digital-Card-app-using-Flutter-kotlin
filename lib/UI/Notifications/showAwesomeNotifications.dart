import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

showAwesomeNotifications(RemoteMessage message) {
  print(message.data);

    if((message.data['type'] ?? "")=="event"){
      AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: Random().nextInt(1000),
          channelKey: '10000',
          title: (message.data['organizer'] ?? "organizer"),
          body: "Invited you to " +(message.data['title'] ?? "")+"\nScheduled On "+(message.data['schedued_at'] ?? ""),
        ),
      );

    }else{
      AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: Random().nextInt(1000),
          channelKey: '10000',
          title: (message.data['title'] ?? "title"),
          body: (message.data['message'] ?? "message"),
        ),
      );
    }

}
