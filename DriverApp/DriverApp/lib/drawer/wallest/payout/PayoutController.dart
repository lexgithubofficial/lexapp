import 'dart:convert';
import 'package:driverapp/drawer/wallest/payout/payoutHistory.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../Getx/api/ApiConstants.dart';
import '../../../SharedPref.dart';

class PayoutController extends GetxController implements GetxService {
  var isLoading = false.obs;
  var isLoading1 = false.obs;
  late PayoutHistory PayoutHistoryData;
  var dataSize = 0;
  String profileImage="";
  String available_fund="";
  String past_payout="";

  @override
  void onInit() {
    super.onInit();
    fetchData();
    EarningData();

  }

  @override
  void dispose() {
    super.dispose();
  }
  EarningData() async {
    int driverid = await SharedPref.getDriverId();
    try {
      isLoading(true);
      Map data = {
        "d_id": driverid,
      };
      var url = ApiConstants.driverPayoutEarningDetail;

      String body = json.encode(data);
      var response = await http.post(Uri.parse(url),
          body: body, headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body.toString());
        String status = jsonResponse['status'].toString();

        if (status != "404") {
          profileImage = jsonResponse['drive_image'].toString();
          past_payout = jsonResponse['past_payout'].toString();
          available_fund = jsonResponse['available_fund'].toString();
        }
        else{
          dataSize =0;
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
  fetchData() async {
    int driverid = await SharedPref.getDriverId();
    try {
      isLoading1(true);
      Map data = {
        "d_id": driverid,
      };
      var url = ApiConstants.driverPayouthistory;

      String body = json.encode(data);
      var response = await http.post(Uri.parse(url),
          body: body, headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        var result = json.decode(response.body.toString());
        var jsonResponse = json.decode(response.body.toString());
        String status = jsonResponse['status'].toString();

        if (status != "404") {
          PayoutHistoryData = PayoutHistory.fromJson(result);
          dataSize=1;
        }
        else{
          dataSize =0;
        }
      }
    } catch (e) {
      GetSnackBar(
        title: "Error",
        message: 'Error while getting data is $e',
        duration: const Duration(seconds: 3),
      );
    } finally {
      isLoading1(false);
    }
  }
}
