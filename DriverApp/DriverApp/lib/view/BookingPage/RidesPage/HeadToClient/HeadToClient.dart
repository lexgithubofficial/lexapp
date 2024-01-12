import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../Getx/api/ApiConstants.dart';
import '../../../../constants.dart';
import 'HeadToClientController.dart';
import 'dart:typed_data';
import 'package:location/location.dart' as location;

class HeadToClient extends StatefulWidget {
  const HeadToClient({super.key});

  @override
  _HeadToClient createState() => _HeadToClient();
}

class _HeadToClient extends State<HeadToClient> {
  Future<bool> _onPop() async {
    return false;
  }

  LatLng startLocation = LatLng(pickulattidude, pickulongitude);
  LatLng endLocation = LatLng(droplattidude, droplongitude);
  GoogleMapController? mapController;
  String googleApikey = ApiConstants.googeleApi; //contrller for Google map
  location.Location _locationTracker = location.Location();
  LatLng? curretnLatLng;
  LatLng? initialLatLng;
  LatLng destLatLng = LatLng(droplattidude, droplongitude);
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
        await DefaultAssetBundle.of(context).load("assets/images/livecar.jpg");
    return byteData.buffer.asUint8List();
  }

  void updateMarkerAndCircle(
      location.LocationData newLocalData, Uint8List imageData) {
    if (newLocalData.longitude != null &&
        newLocalData.longitude != null &&
        newLocalData.heading != null) {
      LatLng latlng = LatLng(newLocalData.latitude!, newLocalData.longitude!);
      setState(() {
        marker = Marker(
            markerId: const MarkerId("currentlocation"),
            position: latlng,
            rotation: newLocalData.heading!,
            draggable: false,
            zIndex: 2,
            flat: true,
            anchor: Offset(0.5, 0.5),
            icon: BitmapDescriptor.fromBytes(imageData));
      });
    }
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final HeadToClientController NearestControllerobj =
        Get.put(HeadToClientController());
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
                "Head To Client ",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "FontMain",
                    fontWeight: FontWeight.bold),
              ),
            ),
            body: Center(
              child: Stack(
                children: [
                  SizedBox(
                    height: size.height * 1,
                    width: double.infinity,
                    child:  Container(
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
                      )
                          : SizedBox(),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(
                          top: size.height * 0.10, left: 15, right: 15),
                      height: size.height * 0.25,
                      decoration: BoxDecoration(
                        color: const Color(0xFF000000),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Column(children: [
                        Container(
                          margin: const EdgeInsets.only(
                              left: 30, right: 30, top: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        NearestControllerobj.drop_location,
                                        style: const TextStyle(
                                          fontSize: 13,
                                          fontFamily: "FontMain",
                                          color: Color(0xffffffff),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Column(
                                children: [
                                  Text(
                                    "${NearestControllerobj.distance} km",
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.amber,
                                      fontFamily: "FontMain",
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Text(
                                    "Total distance",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.amber,
                                      fontFamily: "FontMain",
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed("/ConfirmPickup", arguments: ['data', NearestControllerobj.dataPass
                            ]);
                          },
                          child: Container(
                            margin: const EdgeInsets.only(left: 20),
                            child: const Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(Icons.arrow_back,
                                      color: Colors.white),
                                ),
                                Text(
                                  "Turn Left after 5 Blocks",
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontFamily: "FontMain",
                                    color: Color(0xffffffff),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ])),
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(
                          top: size.height * 0.70, left: 15, right: 15),
                      child: MaterialButton(
                        color: const Color(0xFFf8c102),
                        height: 45,
                        minWidth: size.width * 0.6,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        onPressed: () {
                          Get.toNamed("/ConfirmPickup", arguments: ['data', NearestControllerobj.dataPass
                          ]);
                        },
                        child: const Text(
                          "ON MY WAY",
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
                  ),
                ],
              ),
            )));
  }
}
