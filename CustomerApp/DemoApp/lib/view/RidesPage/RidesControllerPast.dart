import 'dart:convert';
import 'package:demoapp/SharedPref.dart';
import 'package:demoapp/view/RidesPage/AllTaskModel.dart';
import 'package:get/get.dart';
import '../../Getx/api/ApiConstants.dart';
import 'package:http/http.dart' as http;

class RidesControllerPast extends GetxController implements GetxService {
  RxString Title = 'Rides'.obs;
  RxInt selectedTile = 0.obs;
  RxInt slierCount = 0.obs;
  var isLoading = false.obs;
  late AllTaskModel allTaskModel;
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
    fetchData(0);
  }

  @override
  void dispose() {
    super.dispose();
  }

  fetchData(int count) async {
    int uid = await SharedPref.getcustmerid();
    try {
      isLoading(true);
      Map data = {
        "uid": uid,
      };
      var url = "";
      if (count == 0) {
        url = ApiConstants.activeRide;
      } else {
        url = ApiConstants.pastRide;
      }

      String body = json.encode(data);
      var response = await http.post(Uri.parse(url),
          body: body, headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        var result = json.decode(response.body.toString());
        String status = result['status'].toString();
        if (status == "404") {
          dataSize = 0;
          String error = result['error'].toString();
          validationAlert(error);
        } else {
          allTaskModel = AllTaskModel.fromJson(result);
          dataSize = allTaskModel.data.length;
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
}
