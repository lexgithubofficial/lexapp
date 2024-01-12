
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../../../../Getx/api/NavigationService.dart';
import '../../../../constants.dart';

class HeadToClientController extends GetxController {
  //**
  String customer_name = "",
      pickup_location = "",
      drop_location = "",
      distance = "",
      requested_bid = "",
      prev_booking_id = "",
      d_id = "";
  var items = [].obs;
  var isLoading = false.obs;
  var driverRequest;
  var channel;
  var jsonString;
  var jsonResponse;

  ///****Validation****//
  RxString password = "".obs;
  var dataPass;

  @override
  void onInit() {
    super.onInit();
    dataPass = Get.arguments['data'] ?? "";
    if (dataPass != "") {
      customer_name = dataPass['customer_details']["full_name"].toString();
      pickup_location = dataPass['pickup_location'].toString();
      drop_location = dataPass['drop_location'].toString();
      distance = dataPass['distance'].toString();
      requested_bid = dataPass['requested_bid'].toString();
      prev_booking_id = dataPass['confirm_booking_id'].toString();
      d_id = dataPass['d_id'].toString();
      d_id11 =d_id;
      customername_show = dataPass['customer_details']["full_name"].toString();
      uid = dataPass['customer_details']["uid"].toString();
      drivername = dataPass['driver_details']["full_name"].toString();
      confirm_booking_id= prev_booking_id;
       customer_longitude = double.parse(dataPass['customer_longitude'].toString());
       customer_latitude = double.parse(dataPass['customer_latitude'].toString());
      rate = dataPass['customer_details']['rate'].toString();

      final wsUrl = Uri.parse('wss://ridewithlex.com:7070');
      channel = WebSocketChannel.connect(wsUrl);
      channel.stream.listen((message) {

        jsonResponse = json.decode(message);
        var response = jsonResponse['response'];

            if (response == "requestBookingCancelled_resp") {
              Navigator.of(NavigationService
                  .navigatorKey.currentContext!).pushNamedAndRemoveUntil("/OnlinePage", arguments: [int.parse(d_id)],(route) => false);
            }

      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }


}

void validationAlert(String mgs) {
  Get.showSnackbar(
    GetSnackBar(
      message: mgs,
      duration: const Duration(seconds: 3),
    ),
  );
  return;
}
