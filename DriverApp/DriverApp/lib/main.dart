import 'dart:convert';
import 'dart:io';
import 'package:driverapp/view/BookingPage/RidesPage/ConfirmPickup/ConfirmPickup.dart';
import 'package:driverapp/view/BookingPage/RidesPage/HeadToClient/HeadToClient.dart';
import 'package:driverapp/view/LoginPage/AddingCar.dart';
import 'package:driverapp/view/LoginPage/CreateProfile.dart';
import 'package:driverapp/view/BookingPage/RidesPage/EndRide/EndRides.dart';
import 'package:driverapp/view/LoginPage/WelcomeLogin/WelcomeLogin.dart';
import 'package:driverapp/view/SplashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'Getx/api/ApiConstants.dart';
import 'Getx/api/ControllerBinding.dart';
import 'Getx/api/NavigationService.dart';
import 'NotificationServices.dart';
import 'SharedPref.dart';
import 'drawer/Contact.dart';
import 'drawer/HomeAllTask/Home.dart';
import 'drawer/LiveTracking/LiveTrackingDemo.dart';
import 'drawer/Logout.dart';
import 'drawer/driverRequirment/DriverRequerment.dart';
import 'drawer/NavigatinPage.dart';
import 'drawer/NearestRequest/NearestRequest.dart';
import 'drawer/Online/OnlinePage.dart';
import 'drawer/RateAndReviewv/RateAndReview.dart';
import 'drawer/Setting.dart';
import 'drawer/wallest/payout/Payout.dart';
import 'drawer/Profile/Profile.dart';
import 'drawer/Supports.dart';
import 'drawer/TaskHistory/TaskHistory.dart';
import 'drawer/AddToBanksAccount/AddBankAccount.dart';
import 'drawer/wallest/addWallet.dart';
import 'drawer/navmain.dart';
import 'package:http/http.dart' as http;

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
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
}

Future<void> updateTocken(String fcm_token) async {
  try {
    int driverid = await SharedPref.getDriverId();
    Map data = {
      "d_id": driverid,
      "fcm_token": fcm_token,
    };
    var url = ApiConstants.updateToken;
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



@override
void initState() {
  // TODO: implement initState
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: ControllerBinding(),
      title: 'Driver App',
      debugShowCheckedModeBanner: false,
      navigatorKey: NavigationService.navigatorKey,
      //locale: Locale('en',"US"),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      getPages: [
        GetPage(name: "/", page: () => const SplashScreen()),
        GetPage(name: "/Home", page: () => const Home()),
        GetPage(name: "/TaskHistory", page: () => const TaskHistory()),
        GetPage(name: "/Profile", page: () => const Profile()),
        GetPage(name: "/DriverRequerment", page: () => DriverRequerment()),
        GetPage(name: "/Setting", page: () => const Setting()),
        GetPage(name: "/addWallet", page: () => const addWallet()),
        GetPage(name: "/Payout", page: () => const Payout()),
        GetPage(name: "/Contact", page: () => const Contact()),
        GetPage(name: "/Supports", page: () => const Supports()),
        GetPage(name: "/Logout", page: () => const Logout()),
        GetPage(name: "/AddBankAccount", page: () => const AddBankAccount()),
        GetPage(name: "/NearestRequest", page: () => const NearestRequest()),
        GetPage(name: "/navmain", page: () => const navmain()),
        GetPage(name: "/CreateProfile", page: () => const CreateProfile()),
        GetPage(name: "/AddingCar", page: () => const AddingCar()),
        GetPage(name: "/OnlinePage", page: () => const OnlinePage()),
        GetPage(name: "/RateAndReview", page: () => const RateAndReview()),
        GetPage(name: "/NavigatinPage", page: () => const NavigatinPage()),
        GetPage(name: "/EndRides", page: () => const EndRides()),
        GetPage(name: "/ConfirmPickup", page: () => const ConfirmPickup()),
        GetPage(name: "/HeadToClient", page: () => const HeadToClient()),
        GetPage(
            name: "/LiveTrackingDemo", page: () => const LiveTrackingDemo()),
        GetPage(name: "/WelcomeLogin", page: () => const WelcomeLogin()),
      ],
    );
  }
}
