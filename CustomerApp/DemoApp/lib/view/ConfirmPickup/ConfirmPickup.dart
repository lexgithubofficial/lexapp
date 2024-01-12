import 'dart:convert';
import 'dart:math';
import 'package:demoapp/Getx/api/ApiConstants.dart';
import 'package:demoapp/constants.dart';
import 'package:demoapp/view/ConfirmPickup/ConfirmPickupController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class ConfirmPickup extends StatefulWidget {
  const ConfirmPickup({super.key});

  @override
  _ConfirmPickupState createState() => _ConfirmPickupState();
}

class _ConfirmPickupState extends State<ConfirmPickup> {
  GoogleMapController? mapController; //contrller for Google map
  PolylinePoints polylinePoints = PolylinePoints();

  String googleAPiKey = ApiConstants.googleApi;

  Set<Marker> markers = Set(); //markers for google map
  Map<PolylineId, Polyline> polylines = {}; //polylines to show direction

  LatLng startLocation = LatLng(pickulattidude, pickulongitude);
  LatLng endLocation = LatLng(droplattidude, droplongitude);

  double distance = 0.0;
  String driveTime = "";
  Future<int> getDriveTime(double startLat, double startLng, double endLat, double endLng) async {
    final apiKey = ApiConstants.googleApi; // Replace with your API key
    final url = "https://maps.googleapis.com/maps/api/directions/json?origin=$startLat,$startLng&destination=$endLat,$endLng&key=$apiKey";

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final routes = data['routes'] as List;
      if (routes.isNotEmpty) {
        final legs = routes[0]['legs'] as List;
        if (legs.isNotEmpty) {
          final duration = legs[0]['duration']['value'] as int;
          return duration;
        }
      }
    }

    throw Exception('Failed to fetch drive time');
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
    setState(() {});
  }
  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var a = 0.5 - cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) *
            (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }
  void calculateDriveTime() async {
    try {
      final duration = await getDriveTime(startLocation.latitude,startLocation.longitude,endLocation.latitude, endLocation.longitude);
      setState(() {
        final now = Duration(seconds: duration);
        driveTime =  _printDuration(now);
        TotaldriveTime = driveTime;
      });
    } catch (e) {
      print("Error: $e");
    }
  }
  String _printDuration(Duration duration) {
    String negativeSign = duration.isNegative ? '-' : '';
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60).abs());
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60).abs());
    return "$negativeSign${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  void initState() {
    super.initState();
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
    calculateDriveTime();
    super.initState();
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
    for (var i = 0; i < polylineCoordinates.length - 1; i++) {
      totalDistance += calculateDistance(
          polylineCoordinates[i].latitude,
          polylineCoordinates[i].longitude,
          polylineCoordinates[i + 1].latitude,
          polylineCoordinates[i + 1].longitude);
    }
    print(totalDistance);

    setState(() {
      distance = totalDistance;
    });
    addPolyLine(polylineCoordinates);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final ConfirmPickupController ConfirmPickupControllerobj = Get.put(ConfirmPickupController());

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        // the App.build method, and use it to set our appbar title.
      ),
      body: Container(
        color: Colors.black87,
        child: Stack(
          children: [
            SizedBox(
              height: size.height * 0.50,
              child: Stack(
                children: [
                  GoogleMap( //Map widget from google_maps_flutter package
                    zoomGesturesEnabled: true, //enable Zoom in, out on map
                    initialCameraPosition: CameraPosition( //innital position in map
                      target: startLocation, //initial position
                      zoom: 14.0, //initial zoom level
                    ),
                    markers: markers, //markers to show on map
                    polylines: Set<Polyline>.of(polylines.values), //polylines
                    mapType: MapType.normal, //map type
                    onMapCreated: (controller) { //method called when map is created
                      setState(() {
                        mapController = controller;
                      });
                    },

                  ),

                  Positioned(
                      bottom: 200,
                      left: 50,
                      child: Card(
                        child: Container(
                            padding: const EdgeInsets.all(20),
                            child: Text("Total Distance: ${distance.toStringAsFixed(2)} KM",
                                style: const TextStyle(fontSize: 13, fontWeight:FontWeight.bold))
                        ),
                      )
                  )
                ],
              ),

            ),
            Padding(
              padding:  EdgeInsets.only(top: size.height * 0.50),
              child: SizedBox(
                height: size.height * 0.5,
                child: Stack(
                  children: [
                    Center(
                      child: Container(
                        height: size.height * 0.55,
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft:  Radius.circular(30)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(30),
                          child: Column(
                            children: [
                              Image.network(
                                ApiConstants.img_baseurl +ConfirmPickupControllerobj.carcategorphoto,
                                width: 200,
                                height: 100,
                                fit: BoxFit.fill,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(ConfirmPickupControllerobj.carcategoryname,
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "FontMain"),
                                    ),
                                  ),
                                  Expanded(
                                    child:Text("CHF ${ConfirmPickupControllerobj.price}",
                                      textAlign: TextAlign.right,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "FontMain"),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text("Time: $driveTime",
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontFamily: "FontMain"),
                                    ),
                                  ),

                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                               Row(
                                children: [
                                  Expanded(
                                    child: Text("${ConfirmPickupControllerobj.carcategoryname} ride - save money",
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontFamily: "FontMain"),
                                    ),
                                  ),

                                ],
                              ),

                              const SizedBox(
                                height: 30,
                              ),

                              Container(
                                width: size.width, height: 55,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: primary_black.withOpacity(0.5),
                                    ),
                                    const BoxShadow(
                                      color: secodary_black,
                                      spreadRadius: -2.0,
                                      blurRadius: 2.0,
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Image.asset(
                                      'assets/images/visa.png',
                                      height: 35,
                                      width: 35,
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          Get.defaultDialog(
                                            title: "Payment Info",
                                            middleText: "CHF ${ConfirmPickupControllerobj.price}, Payment has done! ",
                                            backgroundColor: Colors.white,
                                            titleStyle: const TextStyle(color: Colors.black54),
                                            middleTextStyle: const TextStyle(color: Colors.green),

                                          );

                                        },
                                          child: const Text("Make Payment",style: TextStyle(color: Colors.white),)),
                                    ),

                                    const SizedBox(
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: Center(
                                          child: Icon(
                                            Icons
                                                .chevron_right_rounded,
                                            color: Colors.white,
                                            size: 40,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              MaterialButton(
                                color: yellow_box_color,
                                height: 45,
                                minWidth: size.width * 0.6,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                onPressed: () {

                                  ConfirmPickupControllerobj.onclick(distance.toStringAsFixed(2));

                                },
                                child: const Text(
                                  "FIND DRIVER",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontFamily: "FontMain",
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )

                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
