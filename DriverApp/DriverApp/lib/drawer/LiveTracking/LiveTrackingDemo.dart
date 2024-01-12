import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../../../constants.dart';
import 'package:location/location.dart' as location;
import '../../Getx/api/ApiConstants.dart';
import '../../Getx/api/NavigationService.dart';

class LiveTrackingDemo extends StatefulWidget {
  const LiveTrackingDemo({Key? key}) : super(key: key);

  @override
  State<LiveTrackingDemo> createState() => _LiveTrackingDemoState();
}

class _LiveTrackingDemoState extends State<LiveTrackingDemo> {
  Future<bool> _onPop() async {
    return false;
  }
  var channel;
  GoogleMapController? mapController;
  String googleApikey = ApiConstants.googeleApi; //contrller for Google map

  final location.Location _locationTracker = location.Location();
  LatLng? curretnLatLng;
  LatLng? initialLatLng;
  LatLng destLatLng =  LatLng(customer_latitude, customer_longitude);
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
    ByteData byteData = await DefaultAssetBundle.of(context)
        .load("assets/images/livecar.png");
    return byteData.buffer.asUint8List();
  }
  void updateMarkerAndCircle(location.LocationData newLocalData, Uint8List imageData) {
    if (newLocalData.longitude != null &&
        newLocalData.longitude != null &&
        newLocalData.heading != null) {

       LatLng latlng = LatLng(newLocalData.latitude!, newLocalData.longitude!);
       var radius = calculateDistance(19.094203, 73.011633, newLocalData.latitude, newLocalData.longitude);
       if(radius==0.0||radius<0.03){
         Get.toNamed("/ConfirmPickup", arguments: ['data', ""]);
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
  double calculateDistance(lat1, lon1, lat2, lon2){
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((lat2 - lat1) * p)/2 +
        c(lat1 * p) * c(lat2 * p) *
            (1 - c((lon2 - lon1) * p))/2;
    return 12742 * asin(sqrt(a));
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final wsUrl = Uri.parse('wss://ridewithlex.com:7070');
     channel = WebSocketChannel.connect(wsUrl);
    channel.stream.listen((message) {
     var jsonResponse = json.decode(message);
      var response = jsonResponse['response'];

      if (response == "requestBookingCancelled_resp") {
        Navigator.of(NavigationService
            .navigatorKey.currentContext!).pushNamedAndRemoveUntil("/OnlinePage", arguments: [int.parse(d_id11)],(route) => false);
      }

    });

    getCurrentPosition();
  /*  Timer(const Duration(seconds: 20), () {
      Get.toNamed("/ConfirmPickup",
          arguments: ['parameter1', 'parameter2']);
    });*/

  }
  @override
  Widget build(BuildContext context) {
    // todo : controller part
    return WillPopScope(
        onWillPop: _onPop,
        child: Scaffold(
          // extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: Colors.black,
              elevation: 0,
              centerTitle: true,
              automaticallyImplyLeading: true,
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
                          markerId: const MarkerId("currentlocation"),
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
                // todo : info card

              ],
            )));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _locationSubscription?.cancel();
    print("Subscription canceled ${_locationSubscription} ");

    super.dispose();
  }
}


