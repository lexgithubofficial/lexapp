

import 'package:get/get.dart';

class LoginCantroller extends GetxController{

  RxInt count= 1.obs;
  RxString NAME= 'login'.obs;
  RxBool swichFlag = false.obs;

  incrementcounter(){
    count.value++;
  }
  changebutonname(){
    NAME.value ="register";
  }

  changeswichbtn(bool v){
    swichFlag.value =v;
  }


}