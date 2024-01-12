

import 'package:get/get.dart';
class RidesController extends GetxController implements GetxService {
  RxString Title = 'Rides'.obs;

  RxInt selectedTile = 0.obs;
  RxDouble slierCount = 6.0.obs;
  RxString selectedprice ="".obs;
  changeTile(value) {
    selectedTile.value = value;
  }

  void click() {

  }

  @override
  void onInit() {

    selectedprice= slierCount.toString().obs;

    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
