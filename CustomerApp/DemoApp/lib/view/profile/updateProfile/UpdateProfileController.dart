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

class UpdateProfileController extends GetxController {
  var items = [].obs;
  var isLoading = false.obs;
  UserData? UserData_obj;
  var userid_;
  RxString? imgPick = "".obs;
  String? title = "";
  UserModel? UserModelobj;
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

    SharedPref.getcustmerid().then((value) {
      fetchuserData(value.toString());
      updateCustomerInfo(context, fullNameValue, emailIdvalue, phoneNumbervalue,
          passwordvalue, confirmpasswordvalue, value.toString());
    });
  }

  Future<void> updateCustomerInfo(
      BuildContext context,
      String fullName,
      String email,
      String phone,
      String password,
      String confirmPassword,
      String uid) async {
    try {
      isLoading(true);
      var url = ApiConstants.updateProfile.trim();
      Map data = {
        'full_name': fullName.trim(),
        'email': email.trim(),
        'phone': phone.trim(),
        'password': password.trim(),
        'confirm_password': confirmPassword.trim(),
        "uid": uid
      };

      String body = json.encode(data);
      var response = await http.post(Uri.parse(url),
          body: body, headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        var result = response.body.toString();
        var jsonResponse = json.decode(result);
        UserModelobj = UserModel.fromJson(jsonResponse);
        var uid = UserModelobj?.uid.toString();
        var message = UserModelobj?.message.toString();
        validationAlert("Profile updated successfully");
        SharedPref.setcustmerid(int.parse(uid!));

       // Navigator.of(context).pushNamedAndRemoveUntil("/navmain", (route) => false);


      } else {
        validationAlert("Error while getting data ");
      }
    } catch (e) {
      validationAlert("Error while getting data is $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> updateCustomerProfile(var imagePath) async {
    int uid = await SharedPref.getcustmerid();
    try {
      isLoading(true);
      var url = ApiConstants.updateProfilePicture.trim();
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields.addAll({
        "uid": uid.toString()
      });
      request.files.add(await http.MultipartFile.fromPath('profile_image', finalpath));
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var result = await response.stream.bytesToString();
        var jsonResponse = json.decode(result);
        UserModelobj = UserModel.fromJson(jsonResponse);

        var uid = UserModelobj?.uid.toString();
        var message = UserModelobj?.message.toString();
        validationAlert("Profile updated successfully");

        SharedPref.setcustmerid(int.parse(uid!));
       // Navigator.of(NavigationService.navigatorKey.currentContext!).pushNamedAndRemoveUntil("/navmain", (route) => false);

      } else {
        validationAlert("Error while getting data ");
      }
    } catch (e) {
      validationAlert("Error while getting data is $e");
    } finally {
      isLoading(false);
    }
  }

  @override
  void onInit() {
    SharedPref.getcustmerid().then((value) {
      fetchuserData(value.toString());
    });
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  fetchuserData(String id) async {
    try {
      isLoading(true);
      var url = ApiConstants.userDetails + id;
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body.toString());
        UserData_obj = UserData.fromJson(result);

        print(result);
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
    update();
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
                    getImageCamera();
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
                    getImageGallery();
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

  Future getImageCamera() async {
    final ImagePicker pickedFile = ImagePicker();
    final img = await pickedFile.pickImage(
        source: ImageSource.camera, imageQuality: 20);
    if (img != null) {
      imgPick?.value = img.path;
      finalpath = img.path;
      imagePath =File(img.path);
      updateCustomerProfile(imagePath);
    } else {
      imgPick?.value = "no image";
    }
  }

  Future getImageGallery() async {
    final ImagePicker pickedFile = ImagePicker();
    final img = await pickedFile.pickImage(
        source: ImageSource.gallery, imageQuality: 20);
    if (img != null) {
      imgPick?.value = img.path;
      finalpath = img.path;
      imagePath =File(img.path);
      updateCustomerProfile(imagePath);
    } else {
      imgPick?.value = "no image";
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
