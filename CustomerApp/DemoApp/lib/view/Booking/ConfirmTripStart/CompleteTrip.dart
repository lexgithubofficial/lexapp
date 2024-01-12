import 'dart:convert';
import 'dart:math';
import 'package:demoapp/Getx/api/ApiConstants.dart';
import 'package:demoapp/SharedPref.dart';
import 'package:demoapp/constants.dart';
import 'package:demoapp/view/Booking/ConfirmTripStart/ConfirmTripStartController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:http/http.dart' as http;

class CompleteTrip extends StatefulWidget {
  const CompleteTrip({super.key});

  @override
  _CompleteTrip createState() => _CompleteTrip();
}

class _CompleteTrip extends State<CompleteTrip> {
  GoogleMapController? mapController; //contrller for Google map
  PolylinePoints polylinePoints = PolylinePoints();

  String googleAPiKey = ApiConstants.googleApi;

  Set<Marker> markers = Set(); //markers for google map
  Map<PolylineId, Polyline> polylines = {}; //poly-lines to show direction
  LatLng startLocation = LatLng(pickulattidude, pickulongitude);
  LatLng endLocation = LatLng(droplattidude, droplongitude);
  double distance = 0.0;

  @override
  void initState() {
    super.initState();
    markers.add(Marker(
      //add start location marker
      markerId: MarkerId(startLocation.toString()),
      position: startLocation, //position of marker
      infoWindow: const InfoWindow(
        //popup info
        title: 'Starting Point ',
        snippet: 'Start Marker',
      ),
      icon: BitmapDescriptor.defaultMarker, //Icon for Marker
    ));
    markers.add(Marker(
      //add distination location marker
      markerId: MarkerId(endLocation.toString()),
      position: endLocation, //position of marker
      infoWindow: const InfoWindow(
        //popup info
        title: 'Destination Point ',
        snippet: 'Destination Marker',
      ),
      icon: BitmapDescriptor.defaultMarker, //Icon for Marker
    ));
    getDirections(); //fetch direction polylines from Google API
    final wsUrl = Uri.parse('wss://ridewithlex.com:7070');
    var channel = WebSocketChannel.connect(wsUrl);
    channel.stream.listen((message) {
      var jsonResponse = json.decode(message);
      var response = jsonResponse['response'];
      var data = jsonResponse['data'].toString();
      var error = jsonResponse['error'];
      if (data == "[]") {
        return;
      } else {
        if (response == "driverEndTrip_resp") {
          sendNotificationForCust("Trip ended by driver");
          Get.toNamed("/RateAndReview",  arguments: {'data': jsonResponse['data']});


        }
      }
    });

    super.initState();
  }
  Future<void> sendNotificationForCust(String mgs) async {
    int uid = await SharedPref.getcustmerid();
    try {
      Map data = {
        "uid": uid,
        "message": mgs,
      };
      var url = ApiConstants.pushNotificationCustomer;
      String body = json.encode(data);
      var response = await http.post(Uri.parse(url),
          body: body, headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body.toString());
        String jsonTutorial = jsonEncode(jsonResponse);
      }
    } catch (e) {
      GetSnackBar(
        title: "Error",
        message: 'Error while getting data is $e',
        duration: const Duration(seconds: 3),
      );
    } finally {}
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
    setState(() {});
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final ConfirmTripStartController ConfirmTripStartControllerobj = Get.put(ConfirmTripStartController());
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          // backgroundColor: orange_box_backgound_color,
          centerTitle: true,
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          // the App.build method, and use it to set our appbar title.
          title: const Text(
            "Complete Ride ",
            style: TextStyle(
                color: Colors.white,
                fontFamily: "FontMain",
                fontWeight: FontWeight.bold),
          ),
        ),

        body: Stack(
          children: [
            GoogleMap(
              //Map widget from google_maps_flutter package
              zoomGesturesEnabled: true,
              //enable Zoom in, out on map
              initialCameraPosition: CameraPosition(
                //innital position in map
                target: startLocation, //initial position
                zoom: 14.0, //initial zoom level
              ),
              markers: markers,
              //markers to show on map
              polylines: Set<Polyline>.of(polylines.values),
              //polylines
              mapType: MapType.normal,
              //map type
              onMapCreated: (controller) {
                //method called when map is created
                setState(() {
                  mapController = controller;
                });
              },
            ),
            // todo : info card
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  // height: 100,
                    margin: const EdgeInsets.only(bottom: 60),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child:Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                      Container(
                        margin: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Row(
                                  children: [

                                    Center(
                                      child: CircleAvatar(
                                        radius: 32.0,
                                        backgroundImage: NetworkImage(
                                          profile_imageShow,
                                        ),
                                      ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: Column(
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                ConfirmTripStartControllerobj
                                                    .customer_name,
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                  fontFamily: "FontMain",
                                                  color: Color(0xffffffff),
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Container(
                                                margin:  const EdgeInsets.only(top: 8,left: 10),
                                                child:  Row(
                                                  children: [
                                                    const Icon(Icons.star,
                                                        size: 15,
                                                        color: Colors.amber),
                                                    Text(
                                                      ConfirmTripStartControllerobj.rating=="null"? "1":ConfirmTripStartControllerobj.rating,
                                                      style: const TextStyle(
                                                        fontSize: 11,
                                                        fontFamily: "FontMain",
                                                        color: Colors.amber,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),

                                            ],
                                          ),
                                          Container(
                                            margin:  const EdgeInsets.only(top: 3),
                                            child:  Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  margin:  const EdgeInsets.only(top: 5),
                                                  child: Text(
                                                    ConfirmTripStartControllerobj.car_model,
                                                    style: const TextStyle(
                                                      fontSize: 13,
                                                      fontFamily: "FontMain",
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 3,),
                                                Text(
                                                  ConfirmTripStartControllerobj.car_no,
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontFamily: "FontMain",
                                                    color: Colors.amber,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.toNamed("/TopicChoose", arguments: [
                                  'parameter1',
                                  'parameter2'
                                ]);
                              },
                              child: const Column(
                                children: [
                                  Icon(Icons.report, size: 30, color: Colors.amber),
                                  Text(
                                    "Reports",
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.amber,
                                      fontFamily: "FontMain",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                const Text(
                                  "Distance Traveled",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Colors.white54,
                                    fontSize: 12,
                                    fontFamily: "FontMain",
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  "${ConfirmTripStartControllerobj.distance} km",
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontFamily: "FontMain",
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: 30,
                            width: 1,
                            color: Colors.white,
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                const Text(
                                  "Time Taken",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Colors.white54,
                                    fontSize: 12,
                                    fontFamily: "FontMain",
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  TotaldriveTime,
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontFamily: "FontMain",
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        "Arrival at the destination",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: "FontMain",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Visibility(
                        visible: false,
                        child: MaterialButton(
                          color: const Color(0xFFf8c102),
                          height: 45,
                          minWidth: size.width * 0.6,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          onPressed: () {
                            Get.toNamed("/RateAndReview",
                                arguments: ['parameter1', 'parameter2']);
                          },
                          child: const Text(
                            "COMPLETE TRIP",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 14,
                              fontFamily: "FontMain",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ])),
              ),
            )
          ],
        ));

  }
}
