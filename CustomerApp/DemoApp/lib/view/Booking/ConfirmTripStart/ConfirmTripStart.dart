import 'dart:convert';
import 'dart:math';
import 'package:demoapp/Getx/api/ApiConstants.dart';
import 'package:demoapp/constants.dart';
import 'package:demoapp/view/Booking/ConfirmTripStart/ConfirmTripStartController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:async';
import 'dart:typed_data';
import 'package:location/location.dart' as location;

class ConfirmTripStart extends StatefulWidget {
  const ConfirmTripStart({super.key});

  @override
  _ConfirmTripStart createState() => _ConfirmTripStart();
}

class _ConfirmTripStart extends State<ConfirmTripStart> {

  Future<bool> _onPop() async {
    final shouldPop = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Do you want cancel trip?',
            style: TextStyle(
                color: Colors.black,
                fontFamily: "FontMain",
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
          actionsAlignment: MainAxisAlignment.end,
          actions: [
            TextButton(
              onPressed: () {
                Get.toNamed("/HomeActivity",
                    arguments: ['parameter1', 'parameter2']);
              },
              child: const Text(
                'Yes',
                style: TextStyle(
                    color: Colors.black54,
                    fontFamily: "FontMain",
                    fontWeight: FontWeight.bold),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text(
                'No',
                style: TextStyle(
                    color: Colors.black54,
                    fontFamily: "FontMain",
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
    return shouldPop!;
  }
  LatLng startLocation = LatLng(pickulattidude, pickulongitude);
  LatLng endLocation = LatLng(droplattidude, droplongitude);
  GoogleMapController? mapController;
  String googleApikey = ApiConstants.googleApi; //contrller for Google map
  LatLng? curretnLatLng;
  LatLng? initialLatLng;
  LatLng destLatLng = LatLng(droplattidude, droplongitude);
  StreamSubscription? _locationSubscription;

  getCurrentPosition() async {
    try {
      final wsUrl = Uri.parse('wss://ridewithlex.com:7070');
      var channel = WebSocketChannel.connect(wsUrl);
      channel.stream.listen((message) async {
        var jsonResponse = json.decode(message);
        var response = jsonResponse['response'];
        if (response == "webSocketTransfer_resp") {
          var confirm_booking = jsonResponse['data']["confirm_booking_id"].toString();
          var lat = jsonResponse['data']["lat"].toString();
          var long = jsonResponse['data']["long"].toString();
         // validationAlert(lat.toString());
          Uint8List imageData = await getMarker();
          updateMarkerAndCircle(double.parse(lat),double.parse(long), imageData);

        }
      });

      // initializing marker image
      Uint8List imageData = await getMarker();
      updateMarkerAndCircle(pickulattidude,pickulongitude, imageData);
      // draw polygon
        initialLatLng = LatLng(pickulattidude,pickulongitude);
        setState(() {});
        print("destLatLng $destLatLng  ");
        getPolyLine(
            initialLatLng:
                LatLng(pickulattidude, pickulongitude),
            destLatLng: destLatLng);


    } catch (e, s) {
      print("Exception occured : $e stack is : $s");
    }
  }

  Marker? marker;
  Future<Uint8List> getMarker() async {
    ByteData byteData =
        await DefaultAssetBundle.of(context).load("assets/images/livecar.jpg");
    return byteData.buffer.asUint8List();
  }

  void updateMarkerAndCircle(double latitude,double longitude, Uint8List imageData) {
    LatLng latlng = LatLng(latitude, longitude);
    setState(() {
      marker = Marker(
          markerId: const MarkerId("current location"),
          position: latlng,
          draggable: false,
          rotation: 0.5,
          zIndex: 2,
          flat: true,
          anchor: const Offset(0.5, 0.5),
          icon: BitmapDescriptor.fromBytes(imageData));
    });
    }
  List<LatLng> polyLineCord = [];

  getPolyLine({required LatLng initialLatLng, required LatLng destLatLng}) async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleApikey,
        PointLatLng(initialLatLng.latitude, initialLatLng.longitude),
        PointLatLng(destLatLng.latitude, destLatLng.longitude));

    if (result.points.isNotEmpty) {
      print("result ${result}");
      result.points.forEach((PointLatLng latLng) {
        polyLineCord.add(LatLng(latLng.latitude, latLng.longitude));
      });
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getCurrentPosition();
    super.initState();
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
    return WillPopScope(
        onWillPop: _onPop,
        child: Scaffold(
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
                "Confirm Pickup ",
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
                    target: initialLatLng ?? destLatLng,
                    //initial position
                    zoom: 14.0, //initial zoom level
                  ),
                  markers: {
                    marker != null
                        ? marker!
                        : Marker(
                            markerId: const MarkerId("currentlocation"),
                            position: initialLatLng ?? destLatLng),
                    Marker(
                        markerId: const MarkerId("destinations"),
                        position: destLatLng),
                    Marker(
                        markerId: const MarkerId("source"),
                        position: initialLatLng ?? destLatLng),
                  },
                  // myLocationEnabled: true,

                  //markers to show on map
                  // polylines: Set<Polyline>.of(
                  //     LiveTrackingControllerobj.polylines.values),
                  //polylines
                  // todo: polyline on map
                  polylines: {
                    Polyline(
                        polylineId: const PolylineId("route"),
                        width: 5,
                        points: polyLineCord,
                        color: blue_textColor)
                  },
                  mapType: MapType.terrain,
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          // shrinkWrap: true,
                          children: [
                            Column(
                              children: [
                                Column(children: [
                                  Container(
                                    margin: const EdgeInsets.all(10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        const Text(
                                          "OTP : ",
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.white,
                                            fontFamily: "FontMain",
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 7,
                                        ),
                                        Text(
                                          ConfirmTripStartControllerobj.otp,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.white,
                                            fontFamily: "FontMain",
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Row(
                                                children: [
                                                  Center(
                                                    child: CircleAvatar(
                                                      radius: 32.0,
                                                      backgroundImage:
                                                          NetworkImage(
                                                        profile_imageShow,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(5),
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              ConfirmTripStartControllerobj
                                                                  .customer_name,
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 18,
                                                                fontFamily:
                                                                    "FontMain",
                                                                color: Color(
                                                                    0xffffffff),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            Container(
                                                              margin:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      top: 8,
                                                                      left: 10),
                                                              child: Row(
                                                                children: [
                                                                  const Icon(
                                                                      Icons
                                                                          .star,
                                                                      size: 15,
                                                                      color: Colors
                                                                          .amber),
                                                                  Text(
                                                                    ConfirmTripStartControllerobj.rating ==
                                                                            "null"
                                                                        ? "1"
                                                                        : ConfirmTripStartControllerobj
                                                                            .rating,
                                                                    style:
                                                                        const TextStyle(
                                                                      fontSize:
                                                                          11,
                                                                      fontFamily:
                                                                          "FontMain",
                                                                      color: Colors
                                                                          .amber,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .only(top: 3),
                                                          child: Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Container(
                                                                margin:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        top: 5),
                                                                child: Text(
                                                                  ConfirmTripStartControllerobj
                                                                      .car_model,
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        13,
                                                                    fontFamily:
                                                                        "FontMain",
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                width: 3,
                                                              ),
                                                              Text(
                                                                ConfirmTripStartControllerobj
                                                                    .car_no,
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 16,
                                                                  fontFamily:
                                                                      "FontMain",
                                                                  color: Colors
                                                                      .amber,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
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
                                          const Column(
                                            children: [
                                              Text(
                                                "Driver",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                  fontFamily: "FontMain",
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(top: 5, left: 20),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Please confirm pickup",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontFamily: "FontMain",
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 13,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: GestureDetector(
                                                onTap: () async {
                                                  FlutterPhoneDirectCaller
                                                      .callNumber(
                                                          ConfirmTripStartControllerobj
                                                              .phone);
                                                },
                                                child: const Row(
                                                  children: [
                                                    Icon(Icons.call,
                                                        size: 15,
                                                        color: Colors.amber),
                                                    Text(
                                                      "  Call",
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12,
                                                        fontFamily: "FontMain",
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            const Expanded(
                                              flex: 1,
                                              child: Row(
                                                children: [
                                                  Icon(Icons.chat,
                                                      size: 15,
                                                      color: Colors.amber),
                                                  Text(
                                                    "  Chat",
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12,
                                                      fontFamily: "FontMain",
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: GestureDetector(
                                                onTap: () {
                                                  var jsonString = {
                                                    "request":
                                                        "requestBookingCancelled",
                                                    "data": {
                                                      "prev_booking_id":
                                                          ConfirmTripStartControllerobj
                                                              .previous_booking_id
                                                              .toString()
                                                    }
                                                  };
                                                  String convertedJsonStr =
                                                      json.encode(jsonString);
                                                  final wsUrl = Uri.parse(
                                                      'wss://ridewithlex.com:7070');
                                                  var channel =
                                                      WebSocketChannel.connect(
                                                          wsUrl);
                                                  channel =
                                                      WebSocketChannel.connect(
                                                          wsUrl);
                                                  channel.sink
                                                      .add(convertedJsonStr);
                                                  channel.stream
                                                      .listen((message) {
                                                    var jsonResponse =
                                                        json.decode(message);
                                                    var response =
                                                        jsonResponse['response']
                                                            .toString()
                                                            .trim();
                                                    if (response ==
                                                        "requestBookingCancelled_resp") {
                                                      Navigator.of(context)
                                                          .pushNamedAndRemoveUntil(
                                                              "/navmain",
                                                              (route) => false);
                                                    }
                                                  });
                                                },
                                                child: const Row(
                                                  children: [
                                                    Icon(Icons.cancel,
                                                        size: 15,
                                                        color: Colors.amber),
                                                    Text(
                                                      "  Cancel",
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12,
                                                        fontFamily: "FontMain",
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 30,
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
                                        Get.toNamed("/CompleteTrip",
                                            arguments: [
                                              'parameter1',
                                              'parameter2'
                                            ]);
                                      },
                                      child: const Text(
                                        "CONFIRM TRIP START",
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
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Please arrive within ${ConfirmTripStartControllerobj.driveTime}",
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontFamily: "FontMain",
                                    ),
                                  ),
                                ]),
                              ],
                            )
                          ],
                        )),
                  ),
                )
              ],
            )));
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
}
