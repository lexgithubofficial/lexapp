import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../Getx/api/ApiConstants.dart';
import '../../SharedPref.dart';
import 'package:http/http.dart' as http;
import 'ProfileModel.dart';

class ProfileControllerUpadte extends GetxController implements GetxService {
  var isLoading = false.obs;

  late ProfileModel profileModel;
   var View=0;

  RxString imgPick = "".obs;
  String title = "";
  File imagePath = File("");
  var finalpath = "";
  bool onlinecheck = false;

  void submit(String mobileno, jobtype, asignteam) {
    if (mobileno == "") {
      validationAlert("Mobile mo cannot be blank");
      return;
    }

    if (jobtype == "") {
      validationAlert("Job type cannot be blank");
      return;
    }

    if (asignteam == "") {
      validationAlert("Asign team cannot be blank");
      return;
    }


    update_data(mobileno, jobtype, asignteam);
  }

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  @override
  void dispose() {
    super.dispose();
  }
  fetchData() async {
    int driverid = await SharedPref.getDriverId();
    try {
      isLoading(true);
      Map data = {
        "d_id": driverid.toString(),
      };
      String body = json.encode(data);
      var response = await http.post(Uri.parse(ApiConstants.driverDetail),
          body: body, headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        var result = response.body.toString();
        print("result"+result);
        var  jsonResponse = json.decode(result);
        String status = jsonResponse['status'].toString();
        if (status != "404") {
          profileModel = ProfileModel.fromJson(jsonResponse);
          View=2;
        }
        else{
          View=0;
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

  Future<void> update_data(
      String mobileno,
      String jobtype,
      String asignteam,
      ) async {
    try {
      int driverid = await SharedPref.getDriverId();
      Map data = {
        "d_id": driverid.toString(),
        "phone":mobileno,
        "job_type": jobtype,
        "assig_team": asignteam,
      };

      var url = ApiConstants.updateDriverProfile;
      String body = json.encode(data);
      var response = await http.post(Uri.parse(url),
          body: body, headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
      var  jsonResponse = json.decode(response.body.toString());
        String status = jsonResponse['status'].toString();
        if (status == "404") {
          String error = jsonResponse['error'].toString();
          Get.showSnackbar(
            GetSnackBar(
              title: "ERROR",
              message: error,
              duration: Duration(seconds: 3),
            ),
          );
        } else {
          Get.showSnackbar(
            const GetSnackBar(
              title: "",
              message: "Profile updated successfully",
              duration: Duration(seconds: 3),
            ),
          );
          fetchData();
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


  Future<void> profileimgupdate() async {
    try {
      isLoading(true);
      int driverid = await SharedPref.getDriverId();
      var url = ApiConstants.updateDriverProfilePicture.trim();
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields.addAll({
        "d_id": driverid.toString(),

      });
      request.files
          .add(await http.MultipartFile.fromPath('profile_image', finalpath));
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var result = await response.stream.bytesToString();
        print(result);
        var jsonResponse = json.decode(result);
        String jsonObject = jsonEncode(jsonResponse);
        var respo = jsonDecode(jsonObject);
        String status = respo['status'].toString();
        if (status == "404") {
          String error = respo['error'].toString();
          validationAlert("Error");
        }
      } else {
        validationAlert("Error");
      }
    } catch (e) {
      validationAlert(e.toString());
    } finally {
      isLoading(false);
    }
  }


  void alertShow(BuildContext context) {
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
      profileimgupdate();
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
      profileimgupdate();
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