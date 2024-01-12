import 'dart:convert';

import 'package:driverapp/Getx/api/ApiConstants.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/web_socket_channel.dart';
import '../../../../SharedPref.dart';

class EndRideController extends GetxController {
  var items = [].obs;
  var isLoading = false.obs;
  var channel;
  var jsonString;
  var jsonResponse;
  var confirm_booking_id,rate="";
  void endRide()  {

    var jsonString = {
      "request": "driverEndTrip",
      "data": {"confirm_booking_id": confirm_booking_id }
    };
    String convertedJsonStr = json.encode(jsonString);
    final wsUrl = Uri.parse('wss://ridewithlex.com:7070');
    channel = WebSocketChannel.connect(wsUrl);
    channel.sink.add(convertedJsonStr);
    channel.stream.listen((message) {
      // channel.sink.close(status.goingAway);
      jsonResponse = json.decode(message);
      var response = jsonResponse['response'];
      var data = jsonResponse['data'];
      if (response == "driverEndTrip_resp") {

        sendNotification("Trip Ended");
        Get.toNamed("/RateAndReview", arguments: {'data': jsonResponse['data']});


      }
    });



  }

  @override
  void onInit() {
    var dataPass = Get.arguments['data'] ?? "";
    if (dataPass != "") {
      confirm_booking_id = dataPass["confirm_booking_id"].toString();
      rate = dataPass["customer_details"]["rate"].toString();

    // validationAlert(confirm_booking_id.toString());

    }
    super.onInit();
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
  @override
  void dispose() {
    super.dispose();
  }

  fetchData() async {
    String confirm_bookings_id = await SharedPref.getbookingid();
    try {
      isLoading(true);
      var jsonResponse;
      Map data = {
        "confirm_bookings_id": confirm_bookings_id,
      };
      var url = ApiConstants.endDriverRide;
      String body = json.encode(data);
      var response = await http.post(Uri.parse(url),
          body: body, headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        var result = json.decode(response.body.toString());
        jsonResponse = json.decode(response.body.toString());
        String status = jsonResponse['status'].toString();
        if (status == "404") {
          String error = jsonResponse['error'].toString();
          GetSnackBar(
            title: "Error",
            message: error,
            duration: const Duration(seconds: 3),
          );
        } else {
          Get.toNamed("/RateAndReview", arguments: ['parameter1', 'parameter2']);
        }
      }
    } catch (e) {
      GetSnackBar(
        title: "Error",
        message: 'Error while getting data is $e',
        duration: const Duration(seconds: 3),
      );
    } finally {
      isLoading(false);
    }
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

bool isEmail(String em) {
  String p =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = new RegExp(p);
  return regExp.hasMatch(em);
}
