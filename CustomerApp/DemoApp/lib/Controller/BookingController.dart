import 'package:get/get.dart';

class RidesController extends GetxController implements GetxService {
  RxString Title = 'Booking'.obs;
  RxInt selectedTile = 0.obs;
  RxDouble slierCount = 75.0.obs;
  changeTile(value) {
    selectedTile.value = value;
  }


}
