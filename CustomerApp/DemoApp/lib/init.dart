import 'package:demoapp/view/AccountPage/AccountController.dart';
import 'package:demoapp/view/Booking/BookingController.dart';
import 'package:demoapp/view/TrackingPage/TrackingController.dart';
import 'package:get/instance_manager.dart';

import 'Controller/HomeController.dart';
import 'Controller/LoginCantroller.dart';
import 'Controller/RidesController.dart';

class InitControllers {
  initialize() async {
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => AccountController());
    Get.lazyPut(() => RidesController());
    Get.lazyPut(() => LoginCantroller());
    Get.lazyPut(() => BookingController());
    Get.lazyPut(() => TrackingController());
    Get.lazyPut(() => TrackingController());
  }
}
