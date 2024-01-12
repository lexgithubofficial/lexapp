import 'dart:convert';
import 'dart:io';

import 'package:demoapp/Getx/api/ApiConstants.dart';
import 'package:demoapp/SharedPref.dart';
import 'package:demoapp/view/profile/UserData.dart';
import 'package:demoapp/view/profile/userModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  var items = [].obs;
  var isLoading = false.obs;
  UserModel? UserModelobj;
  UserData? UserData_obj;
  var userid_;
  RxString imgPick = "".obs;
  String title = "";
  File imagePath = File("");
  var finalpath = "";

  ///****Validation****//
  RxString fullName = "".obs;
  RxString emailID = "".obs,
      phoneNumber = "".obs,
      password = "".obs,
      confirmpassword = "".obs;

  void nextClick(BuildContext context, String fullNameValue, emailIdvalue,
      phoneNumbervalue, passwordvalue, confirmpasswordvalue) {
    fullName.value = fullNameValue;
    emailID.value = emailIdvalue;
    phoneNumber.value = phoneNumbervalue;
    password.value = passwordvalue;
    confirmpassword.value = confirmpasswordvalue;

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
    if (passwordvalue == "") {
      validationAlert("password cannot be blank");
      return;
    }
    if (confirmpasswordvalue == "") {
      validationAlert("confirm password cannot be blank");
      return;
    }
    if (passwordvalue != confirmpasswordvalue) {
      validationAlert("password mismatch");
      return;
    }
    if (imgPick.value == "") {
      validationAlert("Kindly select profile photo");
      return;
    }

    customerRegistration(context, fullNameValue, emailIdvalue, phoneNumbervalue, passwordvalue, confirmpasswordvalue, finalpath);
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }


  Future<void> customerRegistration(BuildContext context, String fullName, String email, String phone, String password, String confirmPassword, String file) async {
    try {
      isLoading(true);
      var url = ApiConstants.Lexregister.trim();
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields.addAll({
        'full_name': fullName.trim(),
        'email': email.trim(),
        'phone': phone.trim(),
        'password': password.trim(),
        'confirm_password': confirmPassword.trim(),
      });
      request.files.add(await http.MultipartFile.fromPath(
          'profile_image', finalpath));
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var result = await response.stream.bytesToString();
        validationAlert(result.toString());
        var jsonResponse = json.decode(result);
        UserModelobj = UserModel.fromJson(jsonResponse);
        var uid = UserModelobj?.uid.toString();
        var message = UserModelobj?.message.toString();
        Get.showSnackbar(
          const GetSnackBar(
            title: "User registered successfully ",
            message: "",
            duration: Duration(seconds: 3),
          ),
        );
        SharedPref.setcustmerid(int.parse(uid!));

        Navigator.of(context).pushNamedAndRemoveUntil("/navmain", (route) => false);

      } else {
        validationAlert("Error while getting data ");
      }
    } catch (e) {
      validationAlert("Error while getting data is $e");
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
