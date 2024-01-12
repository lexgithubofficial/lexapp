import 'dart:convert';

import 'package:get/get.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../../../Getx/api/ApiConstants.dart';
import '../../../../SharedPref.dart';
import '../../../../constants.dart';
import 'package:http/http.dart' as http;
class ConfirmPickupController extends GetxController {
  //**
  String customer_name = "", phone = "", email = "", OTP = "";
  var items = [].obs;
  var isLoading = false.obs;
  var driverRequest;
  var channel;
  var jsonString;
  var jsonResponse;
  var response, data;
  var tempcheck = false.obs;

  ///****Validation****//
  RxString password = "".obs;
  void confirmStart(opt) {
    if (opt == "") {
      validationAlert("Otp cannot be blank");
      return;
    }
    jsonString = {
      "request": "driverStartTrip",
      "data": {"confirm_booking_id": confirm_booking_id, "otp": opt}
    };
    print(jsonString);
    String convertedJsonStr = json.encode(jsonString);
    final wsUrl = Uri.parse('wss://ridewithlex.com:7070');
    channel = WebSocketChannel.connect(wsUrl);
    channel.sink.add(convertedJsonStr);
    channel.stream.listen((message) {
      jsonResponse = json.decode(message);
      response = jsonResponse['response'];
      data = jsonResponse['data'].toString();
      var error = jsonResponse['error'];
      if (data == "[]") {
        if (tempcheck.isTrue) {
          tempcheck.value = false;
          validationAlert("Invalid OTP");
        }
      } else {
        if (response == "driverStartTrip_resp") {
          if (data != "[]") {

            sendNotification("Trip started");

            Get.toNamed("/EndRides", arguments: {'data': jsonResponse['data']});
          }
        }
      }
    });
  }

  @override
  void onInit() {
    super.onInit();
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
Future<void> sendNotification(String mgs) async {
  try {
    int driverid = await SharedPref.getDriverId();
    Map data = {
      "d_id": driverid,
      "message": mgs,
    };
    var url = ApiConstants.pushNotification;
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

