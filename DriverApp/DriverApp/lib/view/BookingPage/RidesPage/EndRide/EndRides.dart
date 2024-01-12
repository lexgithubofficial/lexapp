import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../SharedPref.dart';
import '../../../../drawer/NearestRequest/NearestController.dart';
import '../../../../Getx/api/ApiConstants.dart';
import '../../../../constants.dart';
import 'EndRideController.dart';

import 'dart:async';
import 'dart:typed_data';
import 'package:location/location.dart' as location;
import 'package:http/http.dart' as http;

class EndRides extends StatefulWidget {
  const EndRides({super.key});

  @override
  _EndRides createState() => _EndRides();
}

class _EndRides extends State<EndRides> {
  Future<bool> _onPop() async {
    return false;
  }

  GoogleMapController? mapController;
  String googleApikey = ApiConstants.googeleApi; //contrller for Google map

  final location.Location _locationTracker = location.Location();
  LatLng? curretnLatLng;
  LatLng? initialLatLng;
  LatLng destLatLng =  LatLng(droplattidude, droplongitude);
  StreamSubscription? _locationSubscription;

  getCurrentPosition() async {
    try {
      // initializing marker image
      Uint8List imageData = await getMarker();
      var getLocation = await _locationTracker.getLocation();
      updateMarkerAndCircle(getLocation, imageData);
      // draw polygon
      if (getLocation != null) {
        initialLatLng = LatLng(getLocation.latitude!, getLocation.longitude!);
        setState(() {});
        print("destLatLng $destLatLng  ");
        getPolyLine(
            initialLatLng:
                LatLng(getLocation.latitude!, getLocation.longitude!),
            destLatLng: destLatLng);
      }

      if (_locationSubscription != null) {
        // if previous stream is open then close it
        _locationSubscription?.cancel();
      }

      _locationSubscription =
          _locationTracker.onLocationChanged.listen((newLocalData) {
        if (mapController != null) {
          mapController!.animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(
                  bearing: 192.8334901395799,
                  target:
                      LatLng(newLocalData.latitude!, newLocalData.longitude!),
                  tilt: 0,
                  zoom: 14.00)));
          updateMarkerAndCircle(newLocalData, imageData);
        }

        print(
            "newLocalData ${newLocalData.longitude} && ${newLocalData.latitude}");
      });
    } catch (e, s) {
      print("Exception occured : $e stack is : $s");
    }
  }

  Marker? marker;

  Future<Uint8List> getMarker() async {
    ByteData byteData =
        await DefaultAssetBundle.of(context).load("assets/images/livecar.png");
    return byteData.buffer.asUint8List();
  }

  void updateMarkerAndCircle(
      location.LocationData newLocalData, Uint8List imageData) {
    if (newLocalData.longitude != null &&
        newLocalData.longitude != null &&
        newLocalData.heading != null) {


      LatLng latlng = LatLng(newLocalData.latitude!, newLocalData.longitude!);
      var radius = calculateDistance(pickulattidude, droplongitude, newLocalData.latitude, newLocalData.longitude);
      if(radius==0.0||radius<0.50){
        sendNotification("Reached to Destination location");
      }


      setState(() {
        marker = Marker(
            markerId: const MarkerId("currentlocation"),
            position: latlng,
            rotation: newLocalData.heading!,
            draggable: false,
            zIndex: 2,
            flat: true,
            anchor: const Offset(0.5, 0.5),
            icon: BitmapDescriptor.fromBytes(imageData));
      });
    }
  }

  List<LatLng> polyLineCord = [];

  getPolyLine(
      {required LatLng initialLatLng, required LatLng destLatLng}) async {
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

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  @override
  void initState() {
    super.initState();
    getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    final NearestController ConfirmPickupControllerobj = Get.put(NearestController());
    final EndRideController EndRideControllerobj = Get.put(EndRideController());

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
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    color: Colors.yellow,
                    child: initialLatLng != null
                        ? GoogleMap(
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
                                      markerId:
                                          const MarkerId("currentlocation"),
                                      position: initialLatLng ?? destLatLng),
                              Marker(
                                  markerId: const MarkerId("destinations"),
                                  position: destLatLng),
                              Marker(
                                  markerId: const MarkerId("source"),
                                  position: initialLatLng ?? destLatLng),
                            },

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
                          )
                        : const SizedBox(),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25)),
                      color: Colors.black,
                    ),
                    child: Column(children: [
                      IconButton(
                        color: Colors.blue.shade800,
                        onPressed: () {
                          launchGoogleMaps(droplattidude, droplongitude);
                        },
                        icon: const Icon(Icons.navigation_outlined,size: 40,weight: 3),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 30,right: 30,bottom: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Row(
                                  children: [
                                    Center(
                                      child: CircleAvatar(
                                        radius: 30.0,
                                        backgroundImage: NetworkImage(
                                          ApiConstants.imgviewbasepath +
                                              profile_image_view,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:  const EdgeInsets.all(15),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            ConfirmPickupControllerobj
                                                .customer_name,
                                            style:  const TextStyle(
                                              fontSize: 18,
                                              fontFamily: "FontMain",
                                              color: Color(0xfff6bf02),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                           Row(
                                            children: [
                                              const Icon(Icons.star,
                                                  size: 15,
                                                  color: Colors.amber),
                                              Text(
                                                EndRideControllerobj
                                                    .rate=="null"? "1":   EndRideControllerobj
                                                    .rate,
                                                style: const TextStyle(
                                                  fontSize: 11,
                                                  fontFamily: "FontMain",
                                                  color: Color(0xffffffff),
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                const Text(
                                  "Time Taken",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: "FontMain",
                                    color: Color(0xffffffff),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      takentime,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontFamily: "FontMain",
                                        color: Color(0xffffffff),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                       Padding(
                        padding: const EdgeInsets.only(top: 5, left: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              ConfirmPickupControllerobj
                                  .drop_location,
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: "FontMain",
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            const Row(
                              children: [
                                Icon(FontAwesomeIcons.mapMarker,
                                    size: 20, color: Colors.amber),
                                Text(
                                  " Avenue de lo Care 30",
                                  style: TextStyle(
                                      fontSize: 11,
                                      fontFamily: "FontMain",
                                      color: Color(0xffffffff)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      MaterialButton(
                        color: const Color(0xFFf8c102),
                        height: 45,
                        minWidth: 300,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        onPressed: () {
                          EndRideControllerobj.endRide();
                        },
                        child: const Text(
                          "END RIDE",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 14,
                            fontFamily: "FontMain",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ]),
                  ),
                )
              ],
            )));
  }
  Future<void> sendNotification(String mgs) async {
    try {
      int driverid = await SharedPref.getDriverId();
      Map data = {
        "d_id": driverid,
        "message": mgs,
      };
      var url = ApiConstants.pushNotification;
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
  static Future<void> launchGoogleMaps(double destinationLatitude,double destinationLongitude) async {
    final uri = Uri(
        scheme: "google.navigation",
        queryParameters: {
          'q': '$destinationLatitude, $destinationLongitude'
        });
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      debugPrint('An error occurred');
    }
  }
}
