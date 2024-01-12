import 'dart:convert';
import 'package:demoapp/Controller/BookingController.dart';
import 'package:demoapp/Controller/HomeController.dart';
import 'package:demoapp/Getx/api/ApiConstants.dart';
import 'package:demoapp/SharedPref.dart';
import 'package:demoapp/constants.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/web_socket_channel.dart';

class ConfirmPickupController extends GetxController {
  RxInt count = 1.obs;
  RxString NAME = 'login'.obs;
  var isLoading = false.obs;
  String PostPickupLocation = "",
      PostDestiLocation = "",
      categoryId = "",
      carcategoryname = "",
      carcategorphoto = "",
      price = "";
  dynamic argumentData = Get.arguments;
  var jsonString;

  onclick(String DIST) async {
    int userid = await SharedPref.getcustmerid();
    var lat = lattidude;
    var long = longitude;

    jsonString = {
      "request": "requestBooking",
      "data": {
        "user_id": userid,
        "from": PostPickupLocation,
        "to": PostDestiLocation,
        "customer_longitude": long,
        "customer_latitude": lat,
        "km": DIST,
        "bid": price
      }
    };

    String convertedJsonStr = json.encode(jsonString);
    try {
      final wsUrl = Uri.parse('wss://ridewithlex.com:7070');
      var channel = WebSocketChannel.connect(wsUrl);
      channel.sink.add(convertedJsonStr);
      channel.stream.listen((message) {
      });

      Get.toNamed("/FindDriver", arguments: ['parameter1', 'parameter2']);
    } on Exception catch (_) {
      // make it explicit that this function can throw exceptions
      rethrow;
    }
  }

  allData()  {

    PostPickupLocation = Get.find<HomeController>().PostPickupLocation.toString();
    PostDestiLocation  = Get.find<HomeController>().PostDestiLocation.toString();
    categoryId         = Get.find<HomeController>().categoryId.toString();
    carcategoryname    = Get.find<HomeController>().carcategoryname.toString();
    carcategorphoto    = Get.find<HomeController>().carcategorphoto.toString();
   // price              = Get.find<RidesController>().slierCount.value.toInt().round().toString();

  }


  @override
  void onInit() {
    super.onInit();
    PostPickupLocation = Get.find<HomeController>().PostPickupLocation.toString();
    PostDestiLocation  = Get.find<HomeController>().PostDestiLocation.toString();
    categoryId         = Get.find<HomeController>().categoryId.toString();
    carcategoryname    = Get.find<HomeController>().carcategoryname.toString();
    carcategorphoto    = Get.find<HomeController>().carcategorphoto.toString();
    print("ffefefer"+price);

  }

  Future<void> postbookingdata(
      String userid,
      String PostPickupLocation,
      String PostDestiLocation,
      String categoryId,
      String bidding_price,
      String km_range,
      String travel_time) async {
    try {
      isLoading(true);
      var jsonResponse;
      Map data = {
        "uid": userid,
        "pic_location": PostPickupLocation,
        "drop_location": PostDestiLocation,
        "c_id": categoryId,
        "d_id": "",
        "bidding_price": bidding_price,
        "km_range": km_range,
        "travel_time": travel_time
      };
      var url = ApiConstants.previous_booking;
      String body = json.encode(data);
      var response = await http.post(Uri.parse(url),
          body: body, headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        jsonResponse = json.decode(response.body.toString());
        String jsonTutorial = jsonEncode(jsonResponse);
        var respo = jsonDecode(jsonTutorial);
        String status = respo['status'].toString();
        if (status == 200) {
          String id = respo['id'].toString();
          Get.showSnackbar(
            GetSnackBar(
              title: "Data successfully ",
              message: "User ID =$id",
              duration: const Duration(seconds: 3),
            ),
          );
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
