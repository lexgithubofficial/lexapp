import 'dart:convert';
import 'package:get/get.dart';
import '../../Getx/api/ApiConstants.dart';
import '../../SharedPref.dart';
import 'AllTaskModel.dart';
import 'package:http/http.dart' as http;


class TaskHistoryController extends GetxController implements GetxService {
  var isLoading = false.obs;

  late CustomerData allTaskModel;
  var dataSize = 0;

  @override
  void onInit() {
    super.onInit();

    fetchData(5);
  }

  @override
  void dispose() {
    super.dispose();
  }

  fetchData(int count) async {
    int driverid = await SharedPref.getDriverId();
    try {
      isLoading(true);

      var jsonResponse;
      Map data = {
        "d_id": driverid,
      };
      var url = "";
      if (count == 0) {
        url = ApiConstants.todayTask;
      } else {
        url = ApiConstants.allTask;
      }

      String body = json.encode(data);
      var response = await http.post(Uri.parse(url),
          body: body, headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        var result = json.decode(response.body.toString());
        jsonResponse = json.decode(response.body.toString());
        String status = jsonResponse['status'].toString();

        if (status != "404") {
          allTaskModel = CustomerData.fromJson(result);
          dataSize=allTaskModel.data.length;
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
}
