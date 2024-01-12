import 'dart:convert';
import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
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



Future<void> sendData() async {
  try {
    var jsonResponse;
    Map data = {
      "message": {
        "token": "eeDnjBA6R0OQbKKCYUIEN6:APA91bFEuIhj2zthSUdB6CAkM1ybw9k-3eCeigXcS9HmMBPS1XYttWwLPkk0Fg-E7ntE6mreSQuP0X4t3WhZA-IC_MATkuLFW-MNbi9g3XiTBvZr7Fnpte2P9wAGJovt8lb4wQzYjbVg",
        "notification": {
          "body": "This is an FCM notification message!",
          "title": "FCM Message"
        }
      }
    };
    var url = "https://fcm.googleapis.com/v1/projects/myproject-b5ae1/messages:send HTTP/1.1";
    String body = json.encode(data);
    var response = await http.post(Uri.parse(url),
        body: body, headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body.toString());
      String jsonTutorial = jsonEncode(jsonResponse);

      var respo = jsonDecode(jsonTutorial);
      String status = respo['status'].toString();

      if (status == "404") {
        Get.showSnackbar(
          const GetSnackBar(
            title: "Confirmation",
            message: "Invalid email id and password",
            duration: Duration(seconds: 3),
          ),
        );
      } else {
        Get.showSnackbar(
          const GetSnackBar(
            title: "Confirmation",
            message: "Login successful",
            duration: Duration(seconds: 3),
          ),
        );
      }
    } else {
      Get.showSnackbar(
        const GetSnackBar(
          title: "Error",
          message: 'error fetching data',
          duration: Duration(seconds: 3),
        ),
      );
    }
  } catch (e) {
    GetSnackBar(
      title: "Error",
      message: 'Error while getting data is $e',
      duration: const Duration(seconds: 3),
    );
  } finally {

  }
}
}