import 'dart:convert';

import 'package:get/get.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../../Getx/api/NavigationService.dart';
import '../../SharedPref.dart';
import '../../constants.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:flutter/material.dart';

class NearestController extends GetxController {
  //**
  String customer_name = "",
      pickup_location = "",
      drop_location = "",
      distance = "",
      requested_bid = "",
      prev_booking_id = "",

      option_bids1 = "",
      option_bids2 = "",
      option_bids3 = "";

  var items = [].obs;
  var isLoading = false.obs;
  var driverRequest;
  var channel;
  var jsonString;
  var jsonResponse;

  ///****Validation****//
  RxString password = "".obs;

  void acceptdriver() async {
    int id = await SharedPref.getDriverId();
    try {
      jsonString = {
        "request": "requestBookingAccepted",
        "data": {"prev_booking_id": prev_booking_id, "d_id": id}
      };
      String convertedJsonStr = json.encode(jsonString);
      final wsUrl = Uri.parse('wss://ridewithlex.com:7070');
      channel = WebSocketChannel.connect(wsUrl);
      channel.sink.add(convertedJsonStr);
      channel.stream.listen((message)  {
        //channel.sink.close(status.goingAway);
        jsonResponse = json.decode(message);
        var response = jsonResponse['response'];
        var data = jsonResponse['data'];
        if (response == "requestBookingAccepted_resp") {
         /* print("data"+jsonResponse['data'].toString());
          String serverid = jsonResponse['data']['driver_details']["d_id"].toString();
          String  idpass = id.toString().trim();

          print("serverid= "+serverid.toString());
          print("driverid= "+idpass.toString());

          if(idpass == serverid) {
            Get.toNamed("/HeadToClient", arguments: {
              'data': jsonResponse['data'],
            });
          }
          else{
            Get.toNamed("/OnlinePage", arguments: [id]);
            print("else= "+id.toString());

          }*/

        }
      });
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
  void acceptdriver1() async {
    int id = await SharedPref.getDriverId();
    try {
      final wsUrl = Uri.parse('wss://ridewithlex.com:7070');
      channel = WebSocketChannel.connect(wsUrl);
      channel.stream.listen((message)  {
        // channel.sink.close(status.goingAway);
        jsonResponse = json.decode(message);
        var response = jsonResponse['response'];
        var data = jsonResponse['data'];
        if (response == "requestBookingAccepted_resp") {
          print("data${jsonResponse['data']}");
          String serverid = jsonResponse['data']['driver_details']["d_id"].toString();
          String  idpass = id.toString().trim();
          print("serverid= "+serverid.toString());
          print("driverid= "+idpass.toString());
          if(idpass == serverid) {
            Get.toNamed("/HeadToClient", arguments: {
              'data': jsonResponse['data'],
            });
          }
          else{
            print("else= "+id.toString());
            print("elsedata="+data.toString());
            Navigator.of(NavigationService
                .navigatorKey.currentContext!).pushNamedAndRemoveUntil("/OnlinePage", arguments: [id],(route) => false);

          }

        }
      });
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

  void bid1(String bid) async {
    try {
      int id = await SharedPref.getDriverId();
      jsonString = {
        "request": "driverBidBookingRequest",
        "data": {"prev_booking_id": prev_booking_id, "d_id": id, "bid": bid}
      };
      String convertedJsonStr = json.encode(jsonString);
      final wsUrl = Uri.parse('wss://ridewithlex.com:7070');
      channel = WebSocketChannel.connect(wsUrl);
      channel.sink.add(convertedJsonStr);
      channel.stream.listen((message) {

        jsonResponse = json.decode(message);
        var response = jsonResponse['response'];
        var data = jsonResponse['data'];

        if (data != null && data.toString().isNotEmpty && data.toString() != "[]") {
          if (response == "driverBidBookingAccepted_resp") {

            String serverid = jsonResponse['data']['driver_details']["d_id"].toString();
            String  idpass = id.toString().trim();

            print("serverid= "+serverid.toString());
            print("driverid= "+idpass.toString());

            if(idpass == serverid) {
              Get.toNamed("/HeadToClient", arguments: {
                'data': jsonResponse['data'],
              });
            }
            else{
              print("else= "+id.toString());
              print("elsedata="+data.toString());
              Navigator.of(NavigationService
                  .navigatorKey.currentContext!).pushNamedAndRemoveUntil("/OnlinePage", arguments: [id],(route) => false);

            }

          }
          else{
            if (response == "requestBookingCancelled_resp") {
              Navigator.of(NavigationService
                  .navigatorKey.currentContext!).pushNamedAndRemoveUntil("/OnlinePage", arguments: [id],(route) => false);
            }
          }

        }
      });
    } finally {
      isLoading(false);
    }
  }

  @override
  void onInit() {
    super.onInit();
    var data = Get.arguments['data'] ?? "";
    if (data != "") {
      customer_name = data['customer_details']['full_name'].toString();
      var profile_image = data['customer_details']['profile_image'].toString();
      profile_image_view = profile_image;

      pickup_location = data['pickup_location'].toString();
      drop_location = data['drop_location'].toString();
      distance = data['distance'].toString();
      requested_bid = data['requested_bid'].toString();
      prev_booking_id = data['prev_booking_id'].toString();
      var droplongitude1 = data['customer_longitude'].toString();
      var droplattidude1 = data['customer_latitude'].toString();

      droplongitude = double.parse(droplongitude1);
      droplattidude = double.parse(droplattidude1);

      option_bids1 = data['option_bids'][0].toString();
      var long2 = double.parse(option_bids1);
      option_bids1 = long2.toStringAsFixed(2);

      option_bids2 = data['option_bids'][1].toString();
      option_bids3 = data['option_bids'][2].toString();

      var long22 = double.parse(option_bids2);
      option_bids2 = long22.toStringAsFixed(2);

      var long222 = double.parse(option_bids3);
      option_bids3 = long222.toStringAsFixed(2);
      acceptdriver1();
    }
  }

  @override
  void dispose() {
    super.dispose();
    channel.sink.close(status.goingAway);
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
