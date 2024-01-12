import 'dart:convert';
import 'package:demoapp/Getx/api/ApiConstants.dart';
import 'package:demoapp/view/Setting/SettingModel.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SettingController extends GetxController  {
  var ITEM = ["ITEM1", "ITEM2", "ITEM3", "ITEM4", "ITEM5", "ITEM6"].obs;
  RxString selected = "some book type".obs;
  var currency = [].obs;  var laungauge = [].obs;


  var isLoading = false.obs;
  SettingModel? openseaModel;
  void setSelected(String value) {
    selected.value = value;
  }
  bool isSwitched = false;
  void toggleSwitch(bool value) {
    if (isSwitched == false) {
      isSwitched = true;
    }
    else {
      isSwitched = false;
    }
  }

  @override
  void onInit() {
   // fetchData();
    currency = ["CHF", "USD", "euro", "US Dollars", "Pounds", "Rupees"].obs;
    laungauge = ["Germain", "French", "Italian ", "English "].obs;
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  fetchData() async {
    try {
      isLoading(true);
      http.Response response = await http.get(Uri.tryParse(
          ApiConstants.baseUrl + ApiConstants.usersEndpoint)!);
      if (response.statusCode == 200) {
        ///data successfully
        var result = jsonDecode(response.body.toString());
        openseaModel = SettingModel.fromJson(result);
        var  size= openseaModel?.data.length;
        currency = ["ITEM1", "ITEM2", "ITEM3", "ITEM4", "ITEM5", "ITEM6"].obs;

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