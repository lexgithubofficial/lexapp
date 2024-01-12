import 'dart:convert';
import 'package:get/get.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../../SharedPref.dart';
import 'package:http/http.dart' as http;

import '../../constants.dart';

class OnlineController extends GetxController implements GetxService {
  var driverRequest;
  var channel;
  var jsonString;
  var jsonResponse;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  driverOnile() async {
    int driverid = await SharedPref.getDriverId();
    try {

      jsonString = {
        "request": "setDriverOnline",
        "data": {"d_id": driverid, "latitude": lattidude, "longitude": longitude}
      };
      String convertedJsonStr = json.encode(jsonString);
      final wsUrl = Uri.parse('wss://ridewithlex.com:7070');
      channel = WebSocketChannel.connect(wsUrl);
      channel.sink.add(convertedJsonStr);
      channel.stream.listen((message) {
        // channel.sink.close(status.goingAway);
        jsonResponse = json.decode(message);
        var response = jsonResponse['response'];
        var data = jsonResponse['data'];
        if (response == "requestBooking_resp") {
          Get.toNamed("/NearestRequest", arguments: {
            'data': jsonResponse['data'],
          });

        }
      });

    } catch (e) {
      GetSnackBar(
        title: "Error",
        message: 'Error while getting data is $e',
        duration: const Duration(seconds: 3),
      );
    } finally {}
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
