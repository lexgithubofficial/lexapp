
import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../Getx/api/ApiConstants.dart';
import '../../SharedPref.dart';
import 'package:flutter_sms/flutter_sms.dart';

class RateAndReviewController extends GetxController {
  var items = [].obs;
  var isLoading = false.obs;
  String rating = "1";
  var dfull_name = "", dprofile_image = "", cprofile_image = "", cfull_name,phone="",confirm_booking_id="",d_id="";

  @override
  void onInit() {
    super.onInit();
    var dataPass = Get.arguments['data'] ?? "";

    if (dataPass != "") {
      dfull_name = dataPass["driver_details"]["full_name"].toString();
      dprofile_image = dataPass["driver_details"]["profile_image"].toString();
      cprofile_image = dataPass["customer_details"]["profile_image"].toString();
      cfull_name = dataPass["customer_details"]["full_name"].toString();
      phone = dataPass["driver_details"]["phone"].toString();
      confirm_booking_id = dataPass["confirm_booking_id"].toString();
      d_id = dataPass["d_id"].toString();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }


  savereview(BuildContext context, String rate,String comment ) async {
    int uid = await SharedPref.getcustmerid();
    try {
      isLoading(true);
      Map data = {
        "d_id": d_id,
        "uid": uid.toString(),
        "rate": rate,
        "comment": comment,
        "rate_by":"Customer",
        "confirm_booking_id":confirm_booking_id

      };
      var url=ApiConstants.addRate;
      String body = json.encode(data);
      var response = await http.post(Uri.parse(url),
          body: body, headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        var  result = json.decode(response.body.toString());
        String status       = result['status'].toString();
        if (status == "404") {
          String error       = result['error'].toString();
          GetSnackBar(
            title: "Error",
            message: error,
            duration: const Duration(seconds: 3),
          );
        }
        else{
          validationAlert("Rating done");
          Navigator.of(context) .pushNamedAndRemoveUntil("/navmain", (route) => false);

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

  void send() {
    String message = "This is a test message!";
    List<String> recipents = [phone.toString()];

    _sendSMS(message, recipents);
  }
  void _sendSMS(String message, List<String> recipents) async {
    String _result = await sendSMS(message: message, recipients: recipents)
        .catchError((onError) {
      print(onError);
    });
    print(_result);
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

