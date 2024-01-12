import 'dart:convert';

import 'package:demoapp/Getx/api/ApiConstants.dart';
import 'package:demoapp/constants.dart';
import 'package:demoapp/model/PickupLocation.dart';
import 'package:demoapp/view/HomePage/carModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class HomeController extends GetxController implements GetxService {
  var tabIndex = 0.obs;
  RxString TITLE = 'HOME'.obs;
  late List<PickupLocation> PickupLocation_ = [];
  var isLoading = false.obs;
  late CarModel carData;
  late List<dynamic> result = [];
  RxString location = 'Pickup Location'.obs;
  RxString Desti_location = 'Destination Location'.obs;

  RxString PostPickupLocation = ''.obs;
  RxString PostDestiLocation = ''.obs;

  RxString categoryId = ''.obs;
  RxString userid = ''.obs;
  RxString postlat = ''.obs;
  RxString postlong = ''.obs;

  RxString carcategoryname = ''.obs;
  RxString carcategorphoto = ''.obs;

  RxInt tappedIndex = 000.obs;
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;

  void changeTabIndex(int index) {
    tabIndex.value = index;
    if (index == 0) {
      TITLE.value = "Home";
    } else if (index == 1) {
      TITLE.value = "My Rides";
    } else {
      TITLE.value = "Account";
    }

  }

  @override
  void onInit() {
    addCustomIcon();
    fetchData();
    getAddressFromLatLng(lattidude, longitude);
    super.onInit();
  }


  fetchData() async {
    try {
      isLoading(true);
      http.Response response = await http.get(
          Uri.tryParse(ApiConstants.addCarDetail)!);
      if (response.statusCode == 200) {
        ///data successfully
        var resultdata = jsonDecode(response.body.toString());
        carData = CarModel.fromJson(resultdata);
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

  getapiFromMap() async {
    try {
      isLoading(true);
      var uuid = Uuid();
      String _sesionValue = "12345";
      _sesionValue = uuid.v4();
      print("unikid=" + _sesionValue);
      String kPLACES_API_KEY = ApiConstants.googleApi;
      String baseURL = 'https://maps.googleapis.com/maps/api/place/autocomplete/json';
      String input = "va";
      String request = '$baseURL?input=$input&key=$kPLACES_API_KEY&sessiontoken=$_sesionValue';
      var response = await http.get(Uri.parse(request));
      print(response.body.toString());
      if (response.statusCode == 200) {
        result = jsonDecode(response.body.toString())['predictions'];
        Get.showSnackbar(
          GetSnackBar(
            title: "Error",
            message: response.body.toString(),
            duration: const Duration(seconds: 3),
          ),
        );
      }
      else {
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

  void addCustomIcon() {
    BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(), "assets/images/caricon.png")
        .then(
          (icon) {
        markerIcon = icon;
      },
    );
  }


  getAddressFromLatLng(double lat, double lng) async {

    String _host = 'https://maps.google.com/maps/api/geocode/json';
    final url = '$_host?key=AIzaSyAvu0uQmz4wQwGKs1ilGQR1lJSKGcijO6w&language=en&latlng=$lat,$lng';
    if (lat != null && lng != null) {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        Map data = jsonDecode(response.body);
        String _formattedAddress = data["results"][0]["formatted_address"];
        location.value = _formattedAddress;
        PostPickupLocation.value = _formattedAddress.toString();
        pickulattidude =lat;
        pickulongitude = lng;

      }
    }
  }
}