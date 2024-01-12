import 'dart:convert';
import 'package:driverapp/drawer/TaskHistory/AllTaskModel.dart';
import 'package:get/get.dart';
import '../../Getx/api/ApiConstants.dart';
import '../../SharedPref.dart';
import 'package:http/http.dart' as http;

class WalletComtroller extends GetxController implements GetxService {
  var isLoading = false.obs;

  var isLoading1 = false.obs;


  late CustomerData allTaskModel;
  var dataSize = 0;
  String lifetime_earning="";
  String current_balance="";
  String profileImage="";

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
      var url = ApiConstants.driverEarning;

      String body = json.encode(data);
      var response = await http.post(Uri.parse(url),
          body: body, headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body.toString());
        String status = jsonResponse['status'].toString();

        if (status != "404") {
           lifetime_earning = jsonResponse['lifetime_earning'].toString();
           current_balance = jsonResponse['current_balance'].toString();
           profileImage = jsonResponse['drive_image'].toString();
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
      var url = ApiConstants.allTask;


      String body = json.encode(data);
      var response = await http.post(Uri.parse(url),
          body: body, headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        var result = json.decode(response.body.toString());
        var jsonResponse = json.decode(response.body.toString());
        String status = jsonResponse['status'].toString();

        if (status != "404") {
          allTaskModel = CustomerData.fromJson(result);
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
