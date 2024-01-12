import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../Getx/api/ApiConstants.dart';
import '../../SharedPref.dart';

class LoginController extends GetxController {
  var items = [].obs;
  var isLoading = false.obs;
  ///****Validation****//
  RxString password = "".obs;
  RxString emailID = "".obs;


  void nextClick(BuildContext context,emailIdvalue, password_value) {
    emailID.value = emailIdvalue;
    password.value = password_value;

    if (emailIdvalue == "") {
      validationAlert("Email Name cannot be blank");
      return;
    }
    bool check = isEmail(emailIdvalue);
    if (!check) {
      validationAlert("Please enter valid email id");
      return;
    }

    if (password_value == "") {
      validationAlert("Password cannot be blank");
      return;
    }

    loginDriver(context,emailIdvalue, password_value);
  }

  void forgotPassword(emailIdvalue) {
    emailID.value = emailIdvalue;

    if (emailIdvalue == "") {
      validationAlert("Email Name cannot be blank");
      return;
    }
    bool check = isEmail(emailIdvalue);
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

  Future<void> loginDriver(
  BuildContext context,
    String email,
    String password_value,
  ) async {
    try {
      isLoading(true);
      var jsonResponse;
      Map data = {
        "email": email,
        "password": password_value,
      };
      var url = ApiConstants.loginPage;
      String body = json.encode(data);
      var response = await http.post(Uri.parse(url),
          body: body, headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        jsonResponse = json.decode(response.body.toString());
        String jsonTutorial = jsonEncode(jsonResponse);

        var respo = jsonDecode(jsonTutorial);
        String status = respo['status'].toString();

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
          String d_id = respo['d_id'].toString();
          SharedPref.setDriverId(int.parse(d_id));
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

  Future<void> sendEmail(String email) async {
    try {
      isLoading(true);
      var jsonResponse;
      Map data = {
        "email": email,
      };
      var url = ApiConstants.forgetPassdd;
      String body = json.encode(data);
      var response = await http.post(Uri.parse(url),
          body: body, headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        jsonResponse = json.decode(response.body.toString());
        String jsonTutorial = jsonEncode(jsonResponse);

        var respo = jsonDecode(jsonTutorial);
        String status = respo['status'].toString();

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
              message: " Password send on your register email id , kindly check it try to login again",
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
