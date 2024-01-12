import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../NotificationServices.dart';
import '../SharedPref.dart';
import '../drawer/navmain.dart';
import 'LoginPage/WelcomeLogin/WelcomeLogin.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  NotificationServices NotificationServic = NotificationServices();
  @override
  void initState() {
    super.initState();
    asyncMethod();
  }

  void asyncMethod() async {
    NotificationServic.requestnotificationPersmission();
    // NotificationServic.istokenRefres();
    NotificationServic.firebaseInit();

    NotificationServic.getdevicetoken().then((value){
      print(value);

    });

    int count = await SharedPref.getDriverId();
    if (count == 0) {
      Timer(const Duration(seconds: 5), () {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => WelcomeLogin()));
      });
    } else {
      Timer(const Duration(seconds: 5), () {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => navmain()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        color: const Color(0xFFe8ce89),
        height: double.infinity,
        width: double.infinity,
        child:Image.asset('assets/images/splash.jpeg'),
      ),
    );
  }
}