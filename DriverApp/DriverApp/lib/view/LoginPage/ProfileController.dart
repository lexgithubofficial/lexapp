import 'dart:convert';
import 'dart:io';

import 'package:driverapp/view/LoginPage/userModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import '../../Getx/api/ApiConstants.dart';

class ProfileController extends GetxController {
  var items = [].obs;
  var isLoading = false.obs;
  UserModel? UserModelobj;
  var userid_;
  RxString imgPick = "".obs;
  String title = "";
  File imagePath = File("");
  var finalpath = "";


  ///****Validation****//
  RxString fullName = "".obs;
  RxString emailID = "".obs,
      phoneNumber = "".obs,
      jobtype = "".obs,
      assingned = "".obs,
      password = "".obs;

  void nextClick(String fullNameValue, emailIdvalue, phoneNumbervalue,
      jobtypevalue, assingned_value,passwordvalue) {

    fullName.value = fullNameValue;
    emailID.value = emailIdvalue;
    phoneNumber.value = phoneNumbervalue;
    jobtype.value = jobtypevalue;
    assingned.value = assingned_value;
    password.value = passwordvalue;

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
    if (jobtypevalue == "") {
      validationAlert("Job type cannot be blank");
      return;
    }
    if (assingned_value == "") {
      validationAlert("Assigned team type cannot be blank");
      return;
    }
    if (passwordvalue == "") {
      validationAlert("Password cannot be blank");
      return;
    }
    if (finalpath == "") {
      validationAlert("Kindly select profile ");
      return;
    }

    Get.toNamed("/AddingCar", arguments: [fullNameValue, emailIdvalue,phoneNumbervalue,jobtypevalue,assingned_value,passwordvalue,finalpath]);

  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> registrationOfuser(
    String full_name,
    String email,
    String phone,
    String job_type,
    String assingned_value,
  ) async {
    try {
      isLoading(true);
      var jsonResponse;
      Map data = {
        "full_name": full_name,
        "email": email,
        "phone": phone,
        "job_type": job_type,
        "assig_team": assingned_value
      };
      var url = ApiConstants.addDriver;
      String body = json.encode(data);
      var response = await http.post(Uri.parse(url),
          body: body, headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        jsonResponse = json.decode(response.body.toString());

        Get.showSnackbar(
          const GetSnackBar(
            title: "Confirmation",
            message: "Driver registered successfully",
            duration: Duration(seconds: 3),
          ),
        );
        Get.toNamed("/AddingCar", arguments: ['parameter1', 'parameter2']);

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

  void alertShow(BuildContext context, String title) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        // we set up a container inside which
        // Returning SizedBox instead of a Container
        return SizedBox(
          height: 120,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    primary: Colors.grey.shade800,
                    side: const BorderSide(
                      color: Colors.black54,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    getImageCamera(title);
                  },
                  child: const Text("Camera"),
                ),
                const SizedBox(
                  width: 30,
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    primary: Colors.grey.shade800,
                    side: const BorderSide(
                      color: Colors.black54,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    getImageGallery(title);
                  },
                  child: const Text("Gallery"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  Future getImageCamera(String title) async {

    final ImagePicker pickedFile = ImagePicker();
    final img = await pickedFile.pickImage(source: ImageSource.camera,imageQuality: 20);
    if (img != null) {
      imgPick.value = img.path;
      finalpath = img.path;
      imagePath =File(img.path);
    } else {
      imgPick.value = "";
    }
  }
  Future getImageGallery(String title) async {
    final ImagePicker pickedFile = ImagePicker();
    final img = await pickedFile.pickImage(source: ImageSource.gallery,imageQuality: 20);
    if (img != null) {
      imgPick.value = img.path;
      finalpath = img.path;
      imagePath =File(img.path);
    } else {
      imgPick.value = "";
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
