import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../Getx/api/ApiConstants.dart';
import '../../SharedPref.dart';

class AppReportsController extends GetxController {
  var items = [].obs;
  var isLoading = false.obs;
  ///****Validation****//
  var id="";

  void saveFeedback(feedback) {

    if (feedback == "") {
      validationAlert("feedback cannot be blank");
      return;
    }
    saveFutureBooking(feedback);


  }

  @override
  void onInit() {
    super.onInit();
    var data = Get.arguments;
        id = data[0].toString();
  }


  Future<void> saveFutureBooking(var feedback) async {
    int uid = await SharedPref.getcustmerid();
    try {
      isLoading(true);

      Map data = {
        "uid": uid,
        "topic_id": id,
        "feedback": feedback,
      };
      var url = ApiConstants.explainBrief;
      String body = json.encode(data);
      var response = await http.post(Uri.parse(url),
          body: body, headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
       var result = json.decode(response.body.toString());
        String status = result['status'].toString();
        if (status == "404") {
          Get.showSnackbar(
            const GetSnackBar(
              title: "Error",
              message: "Error",
              duration: Duration(seconds: 3),
            ),
          );
        } else {

          validationAlert("Feedback send successfully ");
        }
      }
    } catch (e) {
      validationAlert(e.toString());
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

