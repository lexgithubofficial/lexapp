import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../Getx/api/ApiConstants.dart';
import '../../SharedPref.dart';

class BookForFutureController extends GetxController {
  var items = [].obs;
  var isLoading = false.obs;
  late BuildContext context;
  ///****Validation****//

  RxString user_id = "".obs;

  void saveData(date, time) {

    if (date == "") {
      validationAlert("Date cannot be blank");
      return;
    }

    if (time == "") {
      validationAlert("Time cannot be blank");
      return;
    }
    SharedPref.getcustmerid().then((value) {

      if(value!=0){
        saveFutureBooking(value.toString(),date, time);
      }
      else{

      }
    });

  }

  @override
  void onInit() {
    super.onInit();

  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> saveFutureBooking(
      String user_id,
    String date,
    String time,
  ) async {
    try {
      isLoading(true);
      var jsonResponse;
      Map data = {
        "user_id": user_id,
        "date": date,
        "time": time,
      };
      var url = ApiConstants.bookFuture;
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

          String id = respo['id'].toString();
          Get.dialog(

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Material(
                        child: Column(
                          children: [
                            const SizedBox(height: 10),
                            const Text(
                              "Confirmation",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color(0xff222b38),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17),
                            ),

                            const Text(
                              "Data saved successful ",
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 20),
                            //Buttons
                            ElevatedButton(
                              child: const Text(
                                'Ok',
                              ),
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(0, 45),
                                primary: Colors.amber,
                                onPrimary: const Color(0xFFFFFFFF),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),

                              onPressed: () {
                                Get.back();
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );

        }
      }
    } catch (e) {
      customAlert(e.toString());
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
void customAlert(var MGS){
  Get.showSnackbar(
    GetSnackBar(
      title: "Title",
      message: MGS,
      duration: const Duration(seconds: 3),
    ),
  );
}
