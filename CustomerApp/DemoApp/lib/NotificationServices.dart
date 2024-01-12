import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {

  // make sure you call `initializeApp` before using other Firebase services.

  print('Handling a background message ${message.messageId}');
}

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  importance: Importance.high,
);
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

class NotificationServices {
  FirebaseMessaging messaging = FirebaseMessaging.instance;



  void requestnotificationPersmission() async {
    NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: true,
        criticalAlert: true,
        provisional: true,
        sound: true);
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("permission granted");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {} else {
      print("permission not granted");
    }
  }
  Future<String> getdevicetoken() async {
    String? TOCKEN = await messaging.getToken();
    print("shiv::" + TOCKEN!);
    return TOCKEN!;
  }

  Future<void> firebaseInit() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Notification caught");
      RemoteNotification? notification = message.notification;
      print(notification?.title.toString());

      AndroidNotification? android = message.notification?.android;

      print("android ");
      print(android);
      if (notification != null && android != null) {
        print("Notification in if");

        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                enableVibration: true,
                channel.id,
                channel.name,
                color: Colors.blue,
                // TODO add a proper drawable resource to android, for now using
                //      one that already exists in example app.
                icon: "@mipmap/ic_launcher",
              ),
            ));
      }
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
     flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
     FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message)  {
      print("App opened on noti click");
      print(message.data);

      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
    });
  }

  void istokenRefres() async {
    messaging.onTokenRefresh.listen((event) {
      event.toString();
    });
  }
}
