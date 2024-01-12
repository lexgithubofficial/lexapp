

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
class ImageCapture extends GetxController{

  RxString imgPick = "".obs;

  Future getImage() async{
    final ImagePicker pickedFile  =ImagePicker();
      final img = await pickedFile.pickImage(source: ImageSource.camera,imageQuality: 20);

      if(img!=null){
        imgPick.value = img.path.toString();
      }
      else{
        imgPick.value ="no image";
      }

  }
  Future getImageg() async{
    final ImagePicker pickedFile  =ImagePicker();
    final img = await pickedFile.pickImage(source: ImageSource.gallery,imageQuality: 20);

    if(img!=null){
      imgPick.value = img.path.toString();
    }
    else{
      imgPick.value ="no image";
    }

  }


}