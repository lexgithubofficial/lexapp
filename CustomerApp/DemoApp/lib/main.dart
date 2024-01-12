
import 'dart:convert';

import 'package:demoapp/Getx/api/ApiConstants.dart';
import 'package:demoapp/Getx/api/NavigationService.dart';
import 'package:demoapp/NotificationServices.dart';
import 'package:demoapp/SharedPref.dart';
import 'package:demoapp/drawer/Logout.dart';
import 'package:demoapp/drawer/helpandsupport.dart';
import 'package:demoapp/drawer/navmain.dart';
import 'package:demoapp/drawer/paymentmethord.dart';
import 'package:demoapp/drawer/promodcode.dart';
import 'package:demoapp/view/AddCard/AddCard.dart';
import 'package:demoapp/view/AppReports/TopicChoose.dart';
import 'package:demoapp/view/AppReports/appreport.dart';
import 'package:demoapp/view/Booking/ConfirmTripStart/CompleteTrip.dart';
import 'package:demoapp/view/Booking/ConfirmTripStart/ConfirmTripStart.dart';
import 'package:demoapp/view/ConfirmPickup/ConfirmPickup.dart';
import 'package:demoapp/view/ConfirmPickup/FindDriver.dart';
import 'package:demoapp/view/ContactUs/ContactUs.dart';
import 'package:demoapp/view/DynamicallyBids/BidingList.dart';
import 'package:demoapp/view/HomePage/HomeActivity.dart';
import 'package:demoapp/view/Loyalti/loyality.dart';
import 'package:demoapp/view/RateReview/RateAndReview.dart';
import 'package:demoapp/view/RidesPage/RidesPage.dart';
import 'package:demoapp/view/Setting/Setting.dart';
import 'package:demoapp/view/ShareApp/ShareApp.dart';
import 'package:demoapp/view/SplashScreen.dart';
import 'package:demoapp/view/TrackingPage/LiveTracking.dart';
import 'package:demoapp/view/TrackingPage/TrackingPage.dart';
import 'package:demoapp/view/bookForFuture/bookforfuture.dart';
import 'package:demoapp/view/profile/Account_view.dart';
import 'package:demoapp/view/profile/LoginPage.dart';
import 'package:demoapp/view/profile/WelcomeLogin/WelcomeLogin.dart';
import 'package:demoapp/view/profile/profile.dart';
import 'package:demoapp/view/profile/updateProfile/UpdateProfile.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'init.dart';
import 'view/RidesPage/bid_ride_page.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
void main() async {
  InitControllers().initialize();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  HttpOverrides.global = MyHttpOverrides();

  NotificationServices NotificationServic = NotificationServices();
  NotificationServic.requestnotificationPersmission();
  // NotificationServic.istokenRefres();
  NotificationServic.firebaseInit();

  NotificationServic.getdevicetoken().then((value) {
    print(value);
    updateTocken(value.toString());

  });
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });

  sendNotificationForCust("Trip ended by driver");
}
Future<void> updateTocken(String fcm_token) async {
  try {
    int uid = await SharedPref.getcustmerid();
    Map data = {
      "uid": uid,
      "fcm_token": fcm_token,
    };
    var url = ApiConstants.updateTokenCustomer;
    String body = json.encode(data);
    var response = await http.post(Uri.parse(url),
        body: body, headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body.toString());
      String jsonTutorial = jsonEncode(jsonResponse);
    }
  } catch (e) {
    GetSnackBar(
      title: "Error",
      message: 'Error while getting data is $e',
      duration: const Duration(seconds: 3),
    );
  } finally {}
}
Future<void> sendNotificationForCust(String mgs) async {
  int uid = await SharedPref.getcustmerid();
  try {
    Map data = {
      "uid": uid,
      "message": mgs,
    };
    var url = ApiConstants.pushNotificationCustomer;
    String body = json.encode(data);
    var response = await http.post(Uri.parse(url),
        body: body, headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body.toString());
      String jsonTutorial = jsonEncode(jsonResponse);
    }
  } catch (e) {
    GetSnackBar(
      title: "Error",
      message: 'Error while getting data is $e',
      duration: const Duration(seconds: 3),
    );
  } finally {}
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Lex Customer',
      debugShowCheckedModeBanner: false,
      navigatorKey: NavigationService.navigatorKey,
      //locale: Locale('en',"US"),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      getPages: [
        GetPage(name: "/", page: () => const SplashScreen()),
        GetPage(name: "/navmain", page: () => const navmain()),
        GetPage(name: "/HomeActivity", page: () => const HomeActivity()),
        GetPage(name: "/RidesPage", page: () => const RidesPage()),
        GetPage(name: "/BidARidesPage", page: () => const BidARidesPage()),
        GetPage(name: "/UpdateProfile", page: () => const UpdateProfile()),
        GetPage(name: "/loyality", page: () => const loyality()),
        GetPage(name: "/paymentmethord", page: () => const paymentmethord()),
        GetPage(name: "/TrackingPage", page: () => const TrackingPage()),
        GetPage(name: "/Setting", page: () => const Setting()),
        GetPage(name: "/helpandsupport", page: () => const helpandsupport()),
        GetPage(name: "/appreport", page: () => const appreport()),
        GetPage(name: "/promodcode", page: () => const promodcode()),
        GetPage(name: "/ShareApp", page: () => const ShareApp()),
        GetPage(name: "/Logout", page: () => const Logout()),
        GetPage(name: "/AddCard", page: () => const AddCard()),
        GetPage(name: "/ConfirmPickup", page: () => const ConfirmPickup()),
        GetPage(name: "/FindDriver", page: () => const FindDriver()),
        GetPage(name: "/ContactUs", page: () => const ContactUs()),
        GetPage(name: "/LiveTracking", page: () => const LiveTracking()),
        GetPage(name: "/RateAndReview", page: () => const RateAndReview()),
        GetPage(name: "/bookforfuture", page: () => const bookforfuture()),
        GetPage(name: "/LoginPage", page: () => const LoginPage()),
        GetPage(name: "/Account_view", page: () => const Account_view()),
        GetPage(name: "/ConfirmTripStart", page: () => const ConfirmTripStart()),
        GetPage(name: "/CompleteTrip", page: () => const CompleteTrip()),
        GetPage(name: "/profile", page: () => const profile()),
        GetPage(name: "/TopicChoose", page: () => const TopicChoose()),
        GetPage(name: "/WelcomeLogin", page: () => const WelcomeLogin()),
        GetPage(name: "/BidingList", page: () => const BidingList()),
      ],
    );
  }


}
