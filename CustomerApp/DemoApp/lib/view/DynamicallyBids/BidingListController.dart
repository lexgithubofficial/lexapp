
import 'package:get/get.dart';

class BidingListController extends GetxController {
  var items = [].obs;
  var bid_idDATA = [].obs;
  var isLoading = false.obs;
  var previous_booking_idData = [].obs;

  @override
  void onInit() {
    super.onInit();
    var data = Get.arguments['data'] ?? "";
    if (data != "") {

    var bid_amount = data["bid_amount"].toString();
    var bid_id = data["bid_id"].toString();
    var previous_booking_id = data["previous_booking_id"].toString();

     items.add(bid_amount);
     previous_booking_idData.add(previous_booking_id);
     bid_idDATA.add(bid_id);
    }

  }

  @override
  void dispose() {
    super.dispose();
    items.clear();
    bid_idDATA.clear();
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


