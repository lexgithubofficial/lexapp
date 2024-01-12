import 'dart:convert';

import 'package:driverapp/view/LoginPage/registerDriver.dart';
import 'package:driverapp/view/LoginPage/userModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../Getx/api/ApiConstants.dart';
import '../../SharedPref.dart';
import '../../constants.dart';
import 'ProfileController.dart';

class AddCarController extends GetxController {
  var items = [].obs;
  var isLoading = false.obs;
  UserModel? UserModelobj;
  var userid_;

  ///****Validation****//
  RxString cltcarname = "".obs;
  RxString cltcarno = "".obs, cltliencenceno = "".obs, cltcarmodel = "".obs;
  late String fullName, emailId, phoneNumber, jobtype, assingned, password;
  var context1;
  var finalpath;

  void cont(BuildContext context) {
    context1 = context;
  }

  void submit(String cltcarnamev, cltcarnov, cltliencencenov, cltcarmodelv) {
    cltcarname.value = cltcarnamev;
    cltcarno.value = cltcarnov;
    cltliencenceno.value = cltliencencenov;
    cltcarmodel.value = cltcarmodelv;

    if (cltcarnamev == "") {
      validationAlert("Car name cannot be blank");
      return;
    }

    if (cltcarnov == "") {
      validationAlert("Car number cannot be blank");
      return;
    }

    if (cltliencencenov == "") {
      validationAlert("Licence number cannot be blank");
      return;
    }
    if (cltcarmodelv == "") {
      validationAlert("Car model cannot be blank");
      return;
    }

    registrationOfdriver(cltcarnamev, cltcarnov, cltliencencenov, cltcarmodelv);
  }

  @override
  void onInit() {
    fullName = Get.find<ProfileController>().fullName.toString();
    emailId = Get.find<ProfileController>().emailID.toString();
    phoneNumber = Get.find<ProfileController>().phoneNumber.toString();
    jobtype = Get.find<ProfileController>().jobtype.toString();
    assingned = Get.find<ProfileController>().assingned.toString();
    password = Get.find<ProfileController>().password.toString();
    finalpath = Get.find<ProfileController>().finalpath;
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> registrationOfdriver(
    String cltcarnamev,
    String cltcarnov,
    String cltliencencenov,
    String cltcarmodelv,
  ) async {
    try {
      isLoading(true);
      var url = ApiConstants.addDriver.trim();
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields.addAll({
        "full_name": fullName,
        "email": emailId,
        "phone": phoneNumber,
        "job_type": jobtype,
        "password": password,
        "assig_team": assingned,
        "car_name": cltcarnamev,
        "car_no": cltcarnov,
        "licence_no": cltliencencenov,
        "car_model": cltcarmodelv,
        "car_image": "na",
        "latitude": lattidude.toString(),
        "longitude": longitude.toString()
      });
      request.files
          .add(await http.MultipartFile.fromPath('profile_image', finalpath));
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var result = await response.stream.bytesToString();
        print(result);
        var jsonResponse = json.decode(result);
        RegisterDriver RegisterDriver_obj = RegisterDriver.fromJson(jsonResponse);
        String jsonObject = jsonEncode(jsonResponse);
        var respo = jsonDecode(jsonObject);
        String status = respo['status'].toString();
        if (status == "404") {
          String error = respo['error'].toString();
          Get.showSnackbar(
            GetSnackBar(
              title: "ERROR",
              message: error,
              duration: const Duration(seconds: 3),
            ),
          );
        } else {
          var DriverId = RegisterDriver_obj.dId.toString();
          SharedPref.setDriverId(int.parse(DriverId));
          Get.showSnackbar(
            const GetSnackBar(
              title: "Confirmation",
              message: "Driver registered successfully",
              duration: Duration(seconds: 3),
            ),
          );
          Navigator.of(context1).pushNamedAndRemoveUntil("/navmain", (route) => false);
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

