
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../Getx/api/ApiConstants.dart';
import '../../SharedPref.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

class DriverRequermentController extends GetxController {
  var items = [].obs;
  var isLoading = false.obs;
  RxString imgPick = "".obs;
    String title="";

  void saveSwissId(title, BuildContext context) {
    title = title;
    alertShow(context,title);
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> galleryupload(String file, String title) async {
    try {
      isLoading(true);
      int driverid = await SharedPref.getDriverId();
      var url = ApiConstants.multipartdd;
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields.addAll({'d_id': '$driverid', 'title': '$title'});
      request.files.add(await http.MultipartFile.fromPath('maltipart_file', file));
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var result = await response.stream.bytesToString();
        validationAlert("File uploaded successfully saved");
      } else {
        validationAlert(response.reasonPhrase.toString());
      }
    } catch (e) {
      validationAlert(e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> cameraupload(String file, String title) async {
    try {
      isLoading(true);
      int driverid = await SharedPref.getDriverId();
      var url = ApiConstants.multipartdd;
      var request = http.MultipartRequest(
          'POST', Uri.parse(url));
      request.fields.addAll({'d_id': '$driverid', 'title': title});
      request.files.add(await http.MultipartFile.fromPath('maltipart_file', file));
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var result = await response.stream.bytesToString();
        print("resulr"+result);
        validationAlert("File uploaded successfully saved");
      } else {
        validationAlert(response.reasonPhrase.toString());
      }
    } catch (e) {
      validationAlert(e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> pdfupload(String file, String title) async {
    try {
      isLoading(true);

      int driverid = await SharedPref.getDriverId();
      var url = ApiConstants.multipartdd;
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields.addAll({'d_id': '$driverid', 'title': title});
      request.files.add(await http.MultipartFile.fromPath('maltipart_file', file));
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var result = await response.stream.bytesToString();
        print("resulr"+result);
        validationAlert("File uploaded successfully saved");
      } else {
        print(response.reasonPhrase);
        validationAlert(response.reasonPhrase.toString());
      }
    } catch (e) {
      print("UPLOAD EORRO" + e.toString());
      validationAlert(e.toString());
    } finally {
      isLoading(false);
    }
  }

  void alertShow(BuildContext context, String title) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        // we set up a container inside which
        // Returning SizedBox instead of a Container
        return SizedBox(
          height: 120,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    primary: Colors.grey.shade800,
                    side: const BorderSide(
                      color: Colors.black54,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    getImageCamera(title);
                  },
                  child: const Text("Camera"),
                ),
                const SizedBox(
                  width: 15,
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    primary: Colors.grey.shade800,
                    side: const BorderSide(
                      color: Colors.black54,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    getImageGallery(title);
                  },
                  child: const Text("Gallery"),
                ),
                const SizedBox(
                  width: 15,
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    primary: Colors.grey.shade800,
                    side: const BorderSide(
                      color: Colors.black54,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    pickPDFAndUpload(title);
                  },
                  child: const Text("Pdf file"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future getImageCamera(String title) async {
    final ImagePicker pickedFile = ImagePicker();
    final img = await pickedFile.pickImage(source: ImageSource.camera,imageQuality: 20);
    if (img != null) {
      imgPick.value = img.path;
      cameraupload(img.path, title);
    } else {
      imgPick.value = "no image";
    }
  }

  Future getImageGallery(String title) async {
    final ImagePicker pickedFile = ImagePicker();
    final img = await pickedFile.pickImage(source: ImageSource.gallery,imageQuality: 20);
    if (img != null) {
      imgPick.value = img.path;
      galleryupload(img.path, title);
    } else {
      imgPick.value = "no image";
    }
  }

  Future<void> pickPDFAndUpload(String title) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      pdfupload(result.files.first.path!, title);
    }
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

bool isEmail(String em) {
  String p =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = new RegExp(p);
  return regExp.hasMatch(em);
}
