import 'dart:async';
import 'dart:ffi';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:location/location.dart' as location;

class LiveTrackingDemo extends StatefulWidget {
  const LiveTrackingDemo({Key? key}) : super(key: key);

  @override
  State<LiveTrackingDemo> createState() => _LiveTrackingDemoState();
}

class _LiveTrackingDemoState extends State<LiveTrackingDemo> {

  GoogleMapController? mapController;
  String googleApikey =
      "AIzaSyAPEGKCy6iKs1aV9YBh7z53UX5p0kQkrvA"; //contrller for Google map

  location.Location _locationTracker = location.Location();

  // Position? position;
  LatLng? curretnLatLng;
  LatLng? initialLatLng;
  LatLng destLatLng = LatLng(19.187268709310935, 72.84900423819936);

  StreamSubscription? _locationSubscription;

  getCurrentPosition() async {
    try {
      // initializing marker image
      Uint8List imageData = await getMarker();
      var getLocation = await _locationTracker.getLocation();
      updateMarkerAndCircle(getLocation, imageData);
      // loadMarker();
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
                  new CameraPosition(
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

  //todo : _  marker _
  List<Marker> _markerList = [];
  Marker? marker;

  Future<Uint8List> getMarker() async {
    ByteData byteData = await DefaultAssetBundle.of(context)
        .load("assets/images/caricon.png");
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
            markerId: MarkerId("currentlocation"),
            position: latlng,
            rotation: newLocalData.heading!,
            draggable: false,
            zIndex: 2,
            flat: true,
            anchor: Offset(0.5, 0.5),
            icon: BitmapDescriptor.fromBytes(imageData));
        // circle = Circle(
        //     circleId: CircleId("car"),
        //     radius: newLocalData.accuracy,
        //     zIndex: 1,
        //     strokeColor: Colors.blue,
        //     center: latlng,
        //     fillColor: Colors.blue.withAlpha(70));
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

  //todo : __  ! polyline _

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    // todo : controller part
    return Scaffold(
      // extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          centerTitle: true,
          automaticallyImplyLeading: true,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Colors.black87,
                child: Icon(Icons.menu),
              ),
            )
          ],
        ),
        body: Stack(
          children: [
            Container(
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
                      markerId: MarkerId("currentlocation"),
                      position: initialLatLng ?? destLatLng),
                  Marker(
                      markerId: MarkerId("destinations"),
                      position: destLatLng),
                  Marker(
                      markerId: MarkerId("source"),
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
                      polylineId: PolylineId("route"),
                      width: 5,
                      points: polyLineCord,)
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
            // todo : info card
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  // height: 100,
                    margin: EdgeInsets.only(bottom: 50),
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      // shrinkWrap: true,
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: CircleAvatar(
                              backgroundColor: Colors.grey,
                              child: Icon(
                                Icons.person_rounded,
                                color: Colors.white,
                              )),
                          title: Text("John Parker",
                              style: TextStyle(color: Colors.white)),
                          subtitle: Text("3.4 review",
                              style:
                              TextStyle(color: Colors.white, fontSize: 10)),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.comment,
                                color: Colors.white,
                              ),
                              Text("3.4 review",
                                  style: TextStyle(
                                      color: Colors.amber, fontSize: 10))
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(
                                  "Distance",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 10),
                                ),
                                Text(
                                  "7.4",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 24),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  "Distance",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 10),
                                ),
                                Text(
                                  "7.4",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 24),
                                )
                              ],
                            )
                          ],
                        ),
                      ],
                    )),
              ),
            )
          ],
        ));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _locationSubscription?.cancel();
    print("Subscription canceled ${_locationSubscription} ");

    super.dispose();
  }
}