import 'dart:convert';

import 'package:get/get.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../Getx/api/ApiConstants.dart';
import '../../SharedPref.dart';
import '../TaskHistory/AllTaskModel.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class RidesController extends GetxController implements GetxService {
  RxString Title = 'Rides'.obs;
  RxInt selectedTile = 0.obs;
  RxDouble slierCount = 75.0.obs;
  var isLoading = false.obs;
  late CustomerData allTaskModel;
  var dataSize = 0;

  changeTile(value) {
    selectedTile.value = value;
    if (value == 0) {
      fetchData(0);
    } else {
      fetchData(5);
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchData1();
    fetchData(0);
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
        if (status == "404") {
          dataSize = 0;
          String error = jsonResponse['error'].toString();
          GetSnackBar(
            title: "Error",
            message: error,
            duration: Duration(seconds: 3),
          );
        } else {
          allTaskModel = CustomerData.fromJson(result);
          dataSize = allTaskModel.data.length;
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

  fetchData1() async {
    int driverid = await SharedPref.getDriverId();
    try {
      var jsonString = {
        "request": "setDriverOffline",
        "data": {"d_id": driverid}
      };
      String convertedJsonStr = json.encode(jsonString);
      final wsUrl = Uri.parse('wss://ridewithlex.com:7070');
      var channel = WebSocketChannel.connect(wsUrl);
      channel.sink.add(convertedJsonStr);
      channel.stream.listen((message) {
        // channel.sink.close(status.goingAway);
      });
    } on Exception catch (_) {
      print("eorror $_");
      rethrow;
    }
  }
}
