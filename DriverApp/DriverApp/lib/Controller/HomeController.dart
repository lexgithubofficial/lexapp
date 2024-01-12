
import 'package:get/get.dart';

class HomeController extends GetxController{
  var tabIndex = 0.obs;
  RxString TITLE= 'HOME'.obs;

  void changeTabIndex(int index) {
    tabIndex.value = index;
    if(index==0){
      TITLE.value="Home";

    }else if(index==1){
      TITLE.value="Rides";
    }
    else{
      TITLE.value="Account";
    }

  }
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }
}