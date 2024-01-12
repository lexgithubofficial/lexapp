import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../../../../Getx/api/ApiConstants.dart';
import '../../../../Getx/api/NavigationService.dart';
import '../../../../SharedPref.dart';
import '../../../../constants.dart';
import 'package:http/http.dart' as http;

import 'ConfirmPickupController.dart';
import 'dart:typed_data';
import 'package:location/location.dart' as location;

class ConfirmPickup extends StatefulWidget {
  const ConfirmPickup({super.key});

  @override
  _ConfirmPickup createState() => _ConfirmPickup();
}

class _ConfirmPickup extends State<ConfirmPickup> {
  TextEditingController cltotp = TextEditingController();
  var channel;
  GoogleMapController? mapController; //contrller for Google map
  PolylinePoints polylinePoints = PolylinePoints();

  String googleAPiKey = ApiConstants.googeleApi;

  Set<Marker> markers = Set(); //markers for google map
  Map<PolylineId, Polyline> polylines = {}; //polylines to show direction

  LatLng startLocation = LatLng(pickulattidude, pickulongitude);
  LatLng endLocation = LatLng(droplattidude, droplongitude);

  double distance = 0.0;
  var jsonResponse;
  String customer_name = "";
  String TotaldriveTime = "";

  String driveTime = "";
  String arrivalTime = "";


  Future<int> getDriveTime(
      double startLat, double startLng, double endLat, double endLng) async {
    final apiKey = ApiConstants.googeleApi; // Replace with your API key
    final url =
        "https://maps.googleapis.com/maps/api/directions/json?origin=$startLat,$startLng&destination=$endLat,$endLng&key=$apiKey";

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

  void calculateDriveTime() async {
    try {
      final duration = await getDriveTime(startLocation.latitude,
          startLocation.longitude, endLocation.latitude, endLocation.longitude);
      setState(() {
        final now = Duration(seconds: duration);
        driveTime = _printDuration(now);
        TotaldriveTime = driveTime;
        takentime = TotaldriveTime;
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

  void calculateDriveTime1() async {
    try {
      final duration = await getDriveTime(lattidude, longitude,pickulattidude, pickulongitude);
      setState(() {
        final now = Duration(seconds: duration);
        arrivalTime = _printDuration1(now);

      });
    } catch (e) {
      print("Error: $e");
    }
  }

  String _printDuration1(Duration duration) {
    String negativeSign = duration.isNegative ? '-' : '';
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60).abs());
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60).abs());
    return "$negativeSign${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

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
              ////***Socket call
              Timer(const Duration(seconds: 5), () {
                updateLatLong(newLocalData.latitude!,newLocalData.longitude!);
              });

            }
            var radius = calculateDistance(pickulattidude, droplongitude, newLocalData.latitude, newLocalData.longitude);
            if(radius==0.0||radius<0.50){
              sendNotification("Reached to pickup location");
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
      var radius = calculateDistance(pickulattidude, droplongitude, newLocalData.latitude, newLocalData.longitude);
      if(radius==0.0||radius<0.50){
        sendNotification("Reached to pickup location");
      }

      setState(() {
        marker = Marker(
            markerId: const MarkerId("current location"),
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
    super.initState();
    cltotp = TextEditingController();

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


    calculateDriveTime();
    calculateDriveTime1();

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


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final ConfirmPickupController ConfirmPickupControllerdata = Get.put(ConfirmPickupController());
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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child:  Stack(
               children: [
                 Container(
                   color: Colors.yellow,
                   child: initialLatLng != null
                       ? GoogleMap(
                     //Map widget from google_maps_flutter package
                     zoomGesturesEnabled: true,
                     myLocationEnabled: true,
                     trafficEnabled: true,
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
                           markerId: const MarkerId("current location"),
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

               ],

              ),
            ),
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25)),
                    color: Colors.black,
                  ),
                  child: Column(
                      children: [
                    IconButton(
                      color: Colors.blue.shade800,
                      onPressed: () {
                        launchGoogleMaps(pickulattidude, pickulongitude);
                      },
                      icon: const Icon(Icons.navigation_outlined,size: 40,weight: 3),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 20,right: 20),
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
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          customername_show,
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontFamily: "FontMain",
                                            color: Color(0xfff6bf02),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                         Row(
                                          children: [
                                            const Icon(Icons.star,
                                                size: 15, color: Colors.amber),
                                            Text(rate=="null"? "2.3":rate,
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
                                  fontSize: 14,
                                  fontFamily: "FontMain",
                                  color: Color(0xffffffff),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    arrivalTime,
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
                    Row(
                      children: [
                         Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              const Text(
                                "Arrival Time",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Colors.white54,
                                  fontSize: 12,
                                  fontFamily: "FontMain",
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                arrivalTime,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontFamily: "FontMain",
                                  color: Color(0xffffffff),
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
                                "Trip Time",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Colors.white54,
                                  fontSize: 12,
                                  fontFamily: "FontMain",
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                TotaldriveTime,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontFamily: "FontMain",
                                  color: Color(0xffffffff),
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              const Text(
                                "Enter OTP",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: "FontMain",
                                  color: Colors.white70,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              SizedBox(
                                height: 20,
                                width: 100,
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: cltotp,
                                  style: const TextStyle(color: Colors.white),
                                  decoration: const InputDecoration(
                                    border: UnderlineInputBorder(),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    ),
                                    labelStyle: TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                        fontFamily: "FontMain"),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    MaterialButton(
                      color: const Color(0xFFf8c102),
                      height: 45,
                      minWidth: size.width * 0.6,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      onPressed: () {
                        ConfirmPickupControllerdata.tempcheck.value = true;
                        String cltotpPass = cltotp.text.toString().trim();
                        ConfirmPickupControllerdata.confirmStart(cltotpPass);
                      },
                      child: const Text(
                        "CONFIRM PICKUP",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 14,
                          fontFamily: "FontMain",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ]),
                ),
              ),
            )
          ],
        ));
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
  void updateLatLong(var lat , var long) {

  var  jsonString = {
      "request": "webSocketTransfer",
      "data": {"confirm_booking_id": confirm_booking_id, "lat": lat, "long": long}
    };
    print(jsonString);
    String convertedJsonStr = json.encode(jsonString);
    final wsUrl = Uri.parse('wss://ridewithlex.com:7070');
    channel = WebSocketChannel.connect(wsUrl);
    channel.sink.add(convertedJsonStr);
    channel.stream.listen((message) {
      jsonResponse = json.decode(message);
     var  response = jsonResponse['response'];
      if (response == "webSocketTransfer_resp") {
        var confirm_booking = jsonResponse['data']["confirm_booking_id"].toString();
        var lat = jsonResponse['data']["lat"].toString();
        var long = jsonResponse['data']["long"].toString();
       // validationAlert(data.toString());
      }
    });
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

}
