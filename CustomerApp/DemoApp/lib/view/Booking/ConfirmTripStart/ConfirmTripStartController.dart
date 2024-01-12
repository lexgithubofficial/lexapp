import 'dart:async';
import 'dart:convert';

import 'package:demoapp/Getx/api/ApiConstants.dart';
import 'package:demoapp/SharedPref.dart';
import 'package:demoapp/constants.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/web_socket_channel.dart';

class ConfirmTripStartController extends GetxController {
  //**
  String customer_name = "", phone = "", email = "", distance = "",otp="";
  var items = [].obs;
  var isLoading = false.obs;
  var driverRequest;
  var channel;
  var jsonString;
  var jsonResponse,driveTime="";
  var car_model="",car_no="",rating="",previous_booking_id="";

  ///****Validation****//
  RxString password = "".obs;

  @override
  void onInit() {
    super.onInit();
    var data = Get.arguments['data'] ?? "";
    if (data != null && data.toString().isNotEmpty && data.toString() != "[]") {
      customer_name = data['driver_details']["full_name"].toString();
      phone = data['driver_details']["phone"].toString();
      distance = data["distance"].toString();
      previous_booking_idshow = data["previous_booking_id"].toString();
      previous_booking_id = data["previous_booking_id"].toString();
      d_idshow = data["d_id"].toString();
      drivernameShow = customer_name;
      phoneshow = phone;
      otp = data["otp"].toString();

      var profile_image = data['driver_details']["profile_image"].toString();
      profile_imageShow = ApiConstants.imgviewbasepath+profile_image;
      var latitude1 = double.parse(data['driver_details']["latitude"].toString());
      var longitude1 = double.parse( data['driver_details']["longitude"].toString());

      var  latitude2 = double.parse(data["customer_latitude"].toString());
      var  longitude2 = double.parse(data["customer_longitude"].toString());

       car_model = data['driver_details']["car_model"].toString();
       car_no = data['driver_details']["car_no"].toString();
      rating=data['driver_details']["rate"].toString();

      calculateDriveTime(latitude1,longitude1,latitude2,longitude2);
    }

    final wsUrl = Uri.parse('wss://ridewithlex.com:7070');
    channel = WebSocketChannel.connect(wsUrl);
    channel.stream.listen((message) {
      jsonResponse = json.decode(message);
    var  response = jsonResponse['response'];
      data = jsonResponse['data'].toString();
      var error = jsonResponse['error'];
      if (data == "[]") {
        return;
      } else {
        if (response == "driverStartTrip_resp") {

          sendNotificationForCust("Trip started by driver");


          Get.toNamed("/CompleteTrip", arguments: ['parameter1', 'parameter2']);
        }
      }
    });


  }

  void calculateDriveTime( double latitude1,double longitude1,double latitude2,double longitude2) async {
    try {
      final duration = await getDriveTime(latitude1,longitude1,latitude2, longitude2);
      final now = Duration(seconds: duration);
      driveTime =  _printDuration(now);
      TotaldriveTime = driveTime;

    } catch (e) {
      print("Error: $e");
    }
  }
  String _printDuration(Duration duration) {
    String negativeSign = duration.isNegative ? '-' : '';
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60).abs());
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60).abs());
    return "$negativeSign${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }
  Future<int> getDriveTime(double startLat, double startLng, double endLat, double endLng) async {
    final apiKey = ApiConstants.googleApi; // Replace with your API key
    final url = "https://maps.googleapis.com/maps/api/directions/json?origin=$startLat,$startLng&destination=$endLat,$endLng&key=$apiKey";

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final routes = data['routes'] as List;
      if (routes.isNotEmpty) {
        final legs = routes[0]['legs'] as List;
        if (legs.isNotEmpty) {
          final duration = legs[0]['duration']['value'] as int;
          return duration;
        }
      }
    }

    throw Exception('Failed to fetch drive time');
  }
  @override
  void dispose() {
    super.dispose();
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
