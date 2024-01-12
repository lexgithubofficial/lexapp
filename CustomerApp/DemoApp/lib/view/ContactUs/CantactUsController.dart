import 'dart:convert';
import 'package:demoapp/Getx/api/ApiConstants.dart';
import 'package:demoapp/SharedPref.dart';
import 'package:demoapp/view/profile/userModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CantactUsController extends GetxController {
  var items = [].obs;
  var isLoading = false.obs;
  UserModel? UserModelobj;
  var userid_;
  RxString imgPick = "".obs;
  String title = "";

  ///****Validation****//
  RxString fullName = "".obs;
  RxString emailID = "".obs,
      phoneNumber = "".obs,
      message = "".obs;

  void nextClick(BuildContext context, String fullNameValue, emailIdvalue,
      phoneNumbervalue, message1) {
    fullName.value = fullNameValue;
    emailID.value = emailIdvalue;
    phoneNumber.value = phoneNumbervalue;
    message.value = message1;

    if (fullNameValue == "") {
      validationAlert("Full Name cannot be blank");
      return;
    }

    if (emailIdvalue == "") {
      validationAlert("Email Name cannot be blank");
      return;
    }
    bool check = isEmail(emailIdvalue);
    if (!check) {
      validationAlert("Please enter valid email id");
      return;
    }

    if (phoneNumbervalue == "") {
      validationAlert("phone Number cannot be blank");
      return;
    }
    if (message1 == "") {
      validationAlert("Message cannot be blank");
      return;
    }

    registrationOfuser(context, fullNameValue, emailIdvalue, phoneNumbervalue, message1);
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> registrationOfuser(BuildContext context,
      String name,
      String email,
      String phone,
      String message,) async {
    try {
      isLoading(true);
      int uid = await SharedPref.getcustmerid();
      Map data = {
        "uid": uid,
        "name": name,
        "email": email,
        "phone": phone,
        "message": message,
      };
      var url = ApiConstants.addSupport;
      String body = json.encode(data);
      var response = await http.post(Uri.parse(url),
          body: body, headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        var result = json.decode(response.body.toString());
        String status = result['status'].toString();
        if (status == "404") {
          String error = result['error'].toString();
          Get.showSnackbar(
            GetSnackBar(
              title: "ERROR",
              message: error,
              duration: const Duration(seconds: 3),
            ),
          );
        } else {

          Get.showSnackbar(
            const GetSnackBar(
              title: "Successfully ",
              message: "Data submitted successfully ",
              duration: Duration(seconds: 3),
            ),
          );

        }
      } else {
        Get.showSnackbar(
          const GetSnackBar(
            title: "Error",
            message: 'error fetching data',
            duration: Duration(seconds: 3),
          ),
        );
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

