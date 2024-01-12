import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../Getx/api/ApiConstants.dart';
import '../../SharedPref.dart';

class LoginController extends GetxController {
  var items = [].obs;
  var isLoading = false.obs;

  void nextClick( BuildContext context,emailID, password) {

    if (emailID == "") {
      validationAlert("Email id cannot be blank");
      return;
    }
    bool check = isEmail(emailID);
    if (!check) {
      validationAlert("Please enter valid email id");
      return;
    }

    if (password == "") {
      validationAlert("Password cannot be blank");
      return;
    }

    loginDriver(context,emailID, password);

  }

  void forgotPassword(emailID) {


    if (emailID == "") {
      validationAlert("Email id cannot be blank");
      return;
    }
    bool check = isEmail(emailID);
    if (!check) {
      validationAlert("Please enter valid email id");
      return;
    }

  }


  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> loginDriver(BuildContext context, String emailID, String password) async {
    try {
      isLoading(true);
      Map data = {
        "email": emailID,
        "password": password,
      };
      var url = ApiConstants.custumerlogin;
      String body = json.encode(data);
      var response = await http.post(Uri.parse(url),
          body: body, headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
       var result = json.decode(response.body.toString());
        String status = result['status'].toString();

        if (status == "404") {
          Get.showSnackbar(
            const GetSnackBar(
              title: "Confirmation",
              message: "Invalid email id and password",
              duration: Duration(seconds: 3),
            ),
          );
        } else {
          Get.showSnackbar(
            const GetSnackBar(
              title: "Confirmation",
              message: "Login successful",
              duration: Duration(seconds: 3),
            ),
          );

          String uid = result['uid'].toString();
          SharedPref.setcustmerid(int.parse(uid));
          Navigator.of(context) .pushNamedAndRemoveUntil("/navmain", (route) => false);

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
