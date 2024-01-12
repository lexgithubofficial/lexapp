import 'dart:convert';
import 'dart:math';
import 'package:demoapp/Getx/api/ApiConstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
class LiveTrackingController extends GetxController{
  var isLoading = false.obs;

  RxDouble pickulattidude1 = 28.528782.obs;
  RxDouble pickulongitude1 = 77.273972.obs;

  RxDouble droplattidude1 = 19.110020.obs;
  RxDouble droplongitude1 = 73.007680.obs;

  GoogleMapController? mapController; //controller for Google map
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPiKey = ApiConstants.googleApi;
  Set<Marker> markers = Set(); //markers for google map
  Map<PolylineId, Polyline> polylines = {}; //polylines to show direction
  late LatLng startLocation;
  late LatLng endLocation ;
  void setSelected() {
     startLocation = LatLng(pickulattidude1.value , pickulongitude1.value);
     endLocation   = LatLng(droplattidude1.value, droplongitude1.value);
  }

  RxDouble distance = 0.0.obs;

  @override
  void initState() {
      markers.add(Marker( //add start location marker
      markerId: MarkerId(startLocation.toString()),
      position: startLocation, //position of marker
      infoWindow: const InfoWindow( //popup info
        title: 'Starting Point ',
        snippet: 'Start Marker',
      ),
      icon: BitmapDescriptor.defaultMarker, //Icon for Marker
    ));

    markers.add(Marker( //add distination location marker
      markerId: MarkerId(endLocation.toString()),
      position: endLocation, //position of marker
      infoWindow: const InfoWindow( //popup info
        title: 'Destination Point ',
        snippet: 'Destination Marker',
      ),
      icon: BitmapDescriptor.defaultMarker, //Icon for Marker
    ));

    getDirections(); //fetch direction polylines from Google API

  }

  getDirections() async {
    List<LatLng> polylineCoordinates = [];

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleAPiKey,
      PointLatLng(startLocation.latitude, startLocation.longitude),
      PointLatLng(endLocation.latitude, endLocation.longitude),
      // travelMode: TravelMode.driving,
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print(result.errorMessage);
    }

    //polulineCoordinates is the List of longitute and latidtude.
    double totalDistance = 0;
    for(var i = 0; i < polylineCoordinates.length-1; i++){
      totalDistance += calculateDistance(
          polylineCoordinates[i].latitude,
          polylineCoordinates[i].longitude,
          polylineCoordinates[i+1].latitude,
          polylineCoordinates[i+1].longitude);
    }

    distance = totalDistance.obs;

    //add to the list of poly line coordinates
    addPolyLine(polylineCoordinates);
  }

  addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.deepPurpleAccent,
      points: polylineCoordinates,
      width: 8,
    );
    polylines[id] = polyline;
  }
  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var a = 0.5 - cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) *
            (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }


  Future<void> postbookingdata(
      String userid,
      String PostPickupLocation,
      String PostDestiLocation,
      String categoryId,
      String bidding_price,
      String km_range,
      String travel_time
      ) async {
    try {
      isLoading(true);
      var jsonResponse;
      Map data = {
        "uid": userid,
        "pic_location": PostPickupLocation,
        "drop_location": PostDestiLocation,
        "c_id": categoryId,
        "d_id": "",
        "bidding_price": bidding_price,
        "km_range": km_range,
        "travel_time": travel_time
      };
      var url = ApiConstants.previous_booking;
      String body = json.encode(data);
      var response = await http.post(Uri.parse(url),
          body: body, headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        jsonResponse = json.decode(response.body.toString());
        String jsonTutorial = jsonEncode(jsonResponse);
        var respo = jsonDecode(jsonTutorial);
        String status = respo['status'].toString();
        if(status==200) {
          String id = respo['id'].toString();
          Get.showSnackbar(
            GetSnackBar(
              title: "Data successfully ",
              message: "User ID ="+id,
              duration: const Duration(seconds: 3),
            ),
          );

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
