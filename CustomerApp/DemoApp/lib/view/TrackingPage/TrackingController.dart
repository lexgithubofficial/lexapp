
import 'dart:convert';
import 'package:demoapp/Getx/api/ApiConstants.dart';
import 'package:demoapp/SharedPref.dart';
import 'package:demoapp/view/TrackingPage/model/TrackingHistory.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class TrackingController extends GetxController implements GetxService {
  var items = [].obs;
  var isLoading = false.obs;
  late TrackingHistory TrackingHistoryModel;
  var count =0;


  void orderSearch(oid) {

    if (oid == "") {
      fetchData();
    }
    TRACKORDER(oid);
  }

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  fetchData() async {
    int uid = await SharedPref.getcustmerid();

    try {
      isLoading(true);
      Map data = {
        "uid": uid
      };
      var url = ApiConstants.trackingHistory;

      String body = json.encode(data);
      var response = await http.post(Uri.parse(url),
          body: body, headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {

        var result = json.decode(response.body.toString());

        String status = result['status'].toString();
        if (status == "404") {
          count=0;
          String error = result['error'].toString();
          validationAlert(error);
        } else {
          TrackingHistoryModel = TrackingHistory.fromJson(result);
          count=1;
        }
      }
    } catch (e) {
      validationAlert(e.toString());
    } finally {
      isLoading(false);
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

  TRACKORDER(var oid) async {
    int uid = await SharedPref.getcustmerid();

    try {
      isLoading(true);
      Map data = {
        "confirm_bookings_id": oid,
        "uid": uid,
      };
      var url = ApiConstants.trackRide;

      String body = json.encode(data);
      var response = await http.post(Uri.parse(url),
          body: body, headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        var result = json.decode(response.body.toString());
        var jsonResponse = json.decode(response.body.toString());
        String status = jsonResponse['status'].toString();
        if (status == "404") {
          String error = jsonResponse['error'].toString();
          validationAlert(error);
        } else {
          TrackingHistoryModel = TrackingHistory.fromJson(result);

        }
      }
    } catch (e) {
      validationAlert(e.toString());
    } finally {
      isLoading(false);
    }
  }
}