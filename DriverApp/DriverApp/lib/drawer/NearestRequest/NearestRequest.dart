import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'NearestController.dart';
import '../../Getx/api/ApiConstants.dart';
import '../../SharedPref.dart';
import '../../constants.dart';

class NearestRequest extends StatefulWidget {
  const NearestRequest({super.key});

  @override
  _NearestRequestState createState() => _NearestRequestState();
}

class _NearestRequestState extends State<NearestRequest> {

  GoogleMapController? mapController; //contrller for Google map
  PolylinePoints polylinePoints = PolylinePoints();
  var channel;
  String googleAPiKey = ApiConstants.googeleApi;

  Set<Marker> markers = Set(); //markers for google map
  Map<PolylineId, Polyline> polylines = {}; //polylines to show direction
  double distance = 0.0;
  LatLng  startLocation = LatLng(pickulattidude, pickulongitude);
  LatLng endLocation = LatLng(droplattidude, droplongitude);
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

    //add to the list of poly line coordinates
    addPolyLine(polylineCoordinates);
  }

  addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = const PolylineId("poly");
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
    final NearestController NearestControllerobj = Get.put(NearestController());
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
      ),
      body: Container(
        color: Colors.black87,
        child: Stack(
          children: [
            SizedBox(
              height: size.height * 0.50,
              child: Stack(
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
                  Positioned(
                      bottom: 200,
                      left: 50,
                      child: Card(
                        child: Container(
                            padding: const EdgeInsets.all(20),
                            child: Text(
                                "Total Distance: ${distance.toStringAsFixed(2)} KM",
                                style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold))),
                      ))
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: size.height * 0.44),
              child: SizedBox(
                height: size.height * 0.7,
                child: Stack(
                  children: [
                    Center(
                      child: SizedBox(
                        height: size.height * 0.45,
                        width: size.width,
                        child: GetBuilder<NearestController>(builder: (state) {
                          return state.customer_name == ""
                              ? const SizedBox(
                            height: 50.0,
                            width: 50.0,
                            child: Center(
                                child: CircularProgressIndicator()),
                          )
                              : Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.all(30),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              radius: 30.0,
                                              backgroundImage: NetworkImage(
                                                ApiConstants.imgviewbasepath+profile_image_view,
                                              ),
                                            ),

                                            Padding(
                                              padding:
                                              const EdgeInsets.all(
                                                  15),
                                              child: Text(
                                                state.customer_name,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: "FontMain",
                                                  color:
                                                  Color(0xfff6bf02),
                                                  fontWeight:
                                                  FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          "${state.distance} KM",
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                            fontFamily: "FontMain",
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const Text(
                                          "Total Distance",
                                          style: TextStyle(
                                            fontSize: 11,
                                            fontFamily: "FontMain",
                                            color: Colors.white54,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              MaterialButton(
                                color: const Color(0xFFf8c102),
                                height: 45,
                                minWidth: size.width * 0.6,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                onPressed: () {
                                  NearestControllerobj.acceptdriver();
                                },
                                child: Text(
                                  "Accept for CHF${state.requested_bid}",
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                    color: Colors.black87,
                                    fontSize: 14,
                                    fontFamily: "FontMain",
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              const Text(
                                "suggest your fare",
                                style: TextStyle(
                                  fontSize: 11,
                                  fontFamily: "FontMain",
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: [
                                  MaterialButton(
                                    color: const Color(0xFFf6bf02),
                                    height: 45,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(10),
                                    ),
                                    onPressed: () {
                                      NearestControllerobj.bid1(
                                          NearestControllerobj
                                              .option_bids1);
                                      validationAlert(
                                          "Request sent to customer");

                                      final wsUrl = Uri.parse(
                                          'wss://ridewithlex.com:7070');
                                      channel =
                                          WebSocketChannel.connect(wsUrl);
                                      channel.stream.listen((message) {
                                        // channel.sink.close(status.goingAway);
                                        var jsonResponse =
                                        json.decode(message);
                                        var response =
                                        jsonResponse['response'];
                                        var data = jsonResponse['data'];
                                        if (response ==
                                            "driverBidBookingAccepted_resp") {
                                          NearestControllerobj
                                              .acceptdriver();
                                        }
                                      });
                                    },
                                    child: Text(
                                      "CHF ${NearestControllerobj
                                              .option_bids1}",
                                      style: const TextStyle(
                                        color: Colors.black87,
                                        fontSize: 12,
                                        fontFamily: "FontMain",
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  MaterialButton(
                                    color: const Color(0xFFf6bf02),
                                    height: 45,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(10),
                                    ),
                                    onPressed: () {
                                      NearestControllerobj.bid1(
                                          NearestControllerobj
                                              .option_bids2);
                                      validationAlert(
                                          "Request sent to customer");
                                      final wsUrl = Uri.parse(
                                          'wss://ridewithlex.com:7070');
                                      channel =
                                          WebSocketChannel.connect(wsUrl);
                                      channel.stream.listen((message) {
                                        // channel.sink.close(status.goingAway);
                                        var jsonResponse =
                                        json.decode(message);
                                        var response =
                                        jsonResponse['response'];
                                        var data = jsonResponse['data'];
                                        if (response ==
                                            "driverBidBookingAccepted_resp") {
                                          NearestControllerobj
                                              .acceptdriver();
                                        }
                                      });
                                    },
                                    child: Text(
                                      "CHF ${NearestControllerobj
                                              .option_bids2}",
                                      style: const TextStyle(
                                        color: Colors.black87,
                                        fontSize: 12,
                                        fontFamily: "FontMain",
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  MaterialButton(
                                    color: const Color(0xFFf6bf02),
                                    height: 45,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(10),
                                    ),
                                    onPressed: () {
                                      NearestControllerobj.bid1(
                                          NearestControllerobj
                                              .option_bids3);
                                      validationAlert(
                                          "Request sent to customer");
                                      final wsUrl = Uri.parse(
                                          'wss://ridewithlex.com:7070');
                                      channel =
                                          WebSocketChannel.connect(wsUrl);
                                      channel.stream.listen((message) {
                                        // channel.sink.close(status.goingAway);
                                        var jsonResponse =
                                        json.decode(message);
                                        var response =
                                        jsonResponse['response'];
                                        var data = jsonResponse['data'];
                                        if (response == "driverBidBookingAccepted_resp") {
                                          NearestControllerobj.acceptdriver();
                                        }
                                      });
                                    },
                                    child: Text(
                                      "CHF ${NearestControllerobj
                                              .option_bids3}",
                                      style: const TextStyle(
                                        color: Colors.black87,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              MaterialButton(
                                color: const Color(0xFFf8c102),
                                height: 45,
                                minWidth: size.width * 0.6,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                onPressed: () async {
                                  int id = await SharedPref.getDriverId();
                                  Navigator.of(context).pushNamedAndRemoveUntil("/OnlinePage", arguments: [id],(route) => false);
                                },
                                child: const Text(
                                  "DECLINE",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 14,
                                    fontFamily: "FontMain",
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
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

void validationAlert(String mgs) {
  Get.showSnackbar(
    GetSnackBar(
      message: mgs,
      duration: const Duration(seconds: 3),
    ),
  );
  return;
}