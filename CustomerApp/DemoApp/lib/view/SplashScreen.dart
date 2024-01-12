import 'dart:async';
import 'package:demoapp/NotificationServices.dart';
import 'package:demoapp/SharedPref.dart';
import 'package:demoapp/constants.dart';
import 'package:demoapp/drawer/navmain.dart';
import 'package:demoapp/view/profile/WelcomeLogin/WelcomeLogin.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

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


  //final SoketActivity SoketActivityobj = Get.put(SoketActivity());
//  SoketActivityobj.intitzation();

    NotificationServic.requestnotificationPersmission();
   // NotificationServic.istokenRefres();
    NotificationServic.firebaseInit();

    NotificationServic.getdevicetoken().then((value){
    print(value);

    });


    getLocation();
    SharedPref.getcustmerid().then((value) {
      if(value==0){
        Timer(const Duration(seconds: 5), () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => WelcomeLogin()));
        });

      }
      else{
        Timer(const Duration(seconds: 5), () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => navmain()));
        });
      }
    });



  }
  getLocation() async {
    Position  position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    lattidude =position.latitude ;
    longitude = position.longitude ;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/splash.png'),
          ],
        ),
      ),
    );
  }
}
