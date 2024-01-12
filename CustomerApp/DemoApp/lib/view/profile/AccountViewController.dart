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

class AccountViewController extends GetxController {
  var items = [].obs;
  var isLoading = false.obs;
    UserData? UserData_obj;
   UserModel? UserModelobj;
  var userid_;
  RxString imgPick = "".obs;
  String title = "";
  File imagePath = File("");

  ///****Validation****//
  RxString fullName = "".obs;

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

  //// profile upload

  Future<void> customerRegistration(
      BuildContext context,
      String fullName,
      String email,
      String phone,
      String password,
      String confirmPassword,
      String file) async {
    try {
      isLoading(true);
      var url = ApiConstants.Lexregister;
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields.addAll({'full_name': fullName});
      request.fields.addAll({'email': email});
      request.fields.addAll({'phone': phone});
      request.fields.addAll({'password': password});
      request.fields.addAll({'confirm_password': confirmPassword});

      request.files
          .add(await http.MultipartFile.fromPath('profile_image', file));
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var result = await response.stream.bytesToString();
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
    final img = await pickedFile.pickImage(source: ImageSource.camera);
    if (img != null) {
      imgPick.value = img.path;
      imagePath = File(imgPick.value);
    } else {
      imgPick.value = "";
    }
  }

  Future getImageGallery(String title) async {
    final ImagePicker pickedFile = ImagePicker();
    final img = await pickedFile.pickImage(source: ImageSource.gallery);
    if (img != null) {
      imgPick.value = img.path;

      imagePath = File(imgPick.value);
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
