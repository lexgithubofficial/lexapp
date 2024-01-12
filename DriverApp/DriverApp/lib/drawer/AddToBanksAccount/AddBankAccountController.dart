import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../Getx/api/ApiConstants.dart';
import '../../SharedPref.dart';

class AddBankAccountController extends GetxController {
  var items = [].obs;
  var isLoading = false.obs;


  void saveBankDetails(FullName, Code,city,IBAN,BIC,BankName) {

    if (FullName == "") {
      validationAlert("Name cannot be blank");
      return;
    }
    if (Code == "") {
      validationAlert("Code cannot be blank");
      return;
    }
    if (city == "") {
      validationAlert("City cannot be blank");
      return;
    }
    if (IBAN == "") {
      validationAlert("IBAN cannot be blank");
      return;
    }
    if (BIC == "") {
      validationAlert("BIC cannot be blank");
      return;
    }
    if (BankName == "") {
      validationAlert("Bank Name cannot be blank");
      return;
    }

    saveBankDetailsServer(FullName, Code,city,IBAN,BIC,BankName);
  }



  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> saveBankDetailsServer(String FullName, String Code, String city, String IBAN, String BIC, String BankName) async {
    try {
      isLoading(true);
      var jsonResponse;
      int driverid = await SharedPref.getDriverId();
      Map data = {
        "d_id": driverid,
        "full_name": FullName,
        "code": Code,
        "city": city,
        "iban": IBAN,
        "swift": BIC,
        "bank_name": BankName,
      };
      var url = ApiConstants.addbankdd;
      String body = json.encode(data);
      var response = await http.post(Uri.parse(url),
          body: body, headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        jsonResponse = json.decode(response.body.toString());
        String jsonTutorial = jsonEncode(jsonResponse);
        var respo = jsonDecode(jsonTutorial);
        String status = respo['status'].toString();

        if (status == "404") {
          Get.showSnackbar(
            const GetSnackBar(
              title: "Confirmation",
              message: "Bank details already saved",
              duration: Duration(seconds: 3),
            ),
          );
        } else {
          Get.showSnackbar(
            const GetSnackBar(
              title: "Confirmation",
              message: "Bank details saved successful",
              duration: Duration(seconds: 3),
            ),
          );
          Get.back();


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
