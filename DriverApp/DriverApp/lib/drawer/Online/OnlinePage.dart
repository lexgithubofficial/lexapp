import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../../Getx/api/ApiConstants.dart';
import '../../constants.dart';
import 'package:geocoding/geocoding.dart';

import '../Profile/ProfileControllerUpadte.dart';
import 'OnlineController.dart';

class OnlinePage extends StatefulWidget {
  const OnlinePage({super.key});

  @override
  _OnlinePage createState() => _OnlinePage();
}

class _OnlinePage extends State<OnlinePage> with TickerProviderStateMixin {
  late GoogleMapController mapController;

  // Define a LatLng variable to store the current location
  LatLng currentLocation = LatLng(lattidude, longitude);

  var driverRequest;
  var channel;
  var jsonString;
  var jsonResponse;
  int driverid = 0;

  @override
  void initState() {
    super.initState();
    var data = Get.arguments;
    int id = data[0];
    driverid = id;
    try {
      jsonString = {
        "request": "setDriverOnline",
        "data": {"d_id": id, "latitude": lattidude, "longitude": longitude}
      };
      String convertedJsonStr = json.encode(jsonString);
      final wsUrl = Uri.parse('wss://ridewithlex.com:7070');
      channel = WebSocketChannel.connect(wsUrl);
      channel.sink.add(convertedJsonStr);
      channel.stream.listen((message) {
        // channel.sink.close(status.goingAway);
        jsonResponse = json.decode(message);
        var response = jsonResponse['response'];
        var data = jsonResponse['data'];
        if (response == "requestBooking_resp") {
          String pickup_location = data['pickup_location'].toString();
          getLatLngFrompickup(pickup_location);
          String drop_location = data['drop_location'].toString();
          getLatLngFrompdrop(drop_location);
          Get.toNamed("/NearestRequest", arguments: {
            'data': jsonResponse['data'],
          });

        }
      });
    } on Exception catch (_) {
      print("eorror $_");
      rethrow;
    }
  }

  Future<LatLng?> getLatLngFrompickup(String address) async {
    List<Location> locations = await locationFromAddress(address);
    if (locations.isNotEmpty) {
      double latitude = locations.first.latitude;
      double longitude = locations.first.longitude;
      pickulattidude = latitude;
      pickulongitude = longitude;
    }
  }

  Future<LatLng?> getLatLngFrompdrop(String address) async {
    List<Location> locations = await locationFromAddress(address);
    if (locations.isNotEmpty) {
      double latitude = locations.first.latitude;
      double longitude = locations.first.longitude;

      droplattidude = latitude;
      droplongitude = longitude;
    }
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final ProfileControllerUpadte ProfileControlleronj = Get.put(ProfileControllerUpadte());
    final OnlineController NearestControllerobj = Get.put(OnlineController());
    NearestControllerobj.driverOnile();

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          actions: [
            const Padding(
              padding: EdgeInsets.only(right: 70),
              child: SwitchExample(),
            ),
            GestureDetector(
              onTap: () {
                Get.toNamed("/Profile", arguments: ['parameter1', 'parameter2']);
              },
              child:  Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child:  Obx(() {
                  return ProfileControlleronj.isLoading.value
                      ? const Center(child: CircularProgressIndicator())
                      : ProfileControlleronj.View == 0
                      ? const Center(child: CircularProgressIndicator())
                      :  CircleAvatar(
                    radius: 20.0,
                    backgroundImage: NetworkImage(
                      ApiConstants.imgviewbasepath +
                          ProfileControlleronj
                              .profileModel
                              .data
                              .profileImage,
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
        body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: GoogleMap(
            mapType: MapType.normal,
            onMapCreated: (GoogleMapController controller) {
              mapController = controller;
            },
            initialCameraPosition: CameraPosition(
              target: currentLocation,
              zoom: 15.0,
            ),
            markers: {
              Marker(
                markerId: const MarkerId('currentLocation'),
                position: currentLocation,
              ),
            },
            circles: {
              Circle(
                circleId: const CircleId('myCircle'),
                center: currentLocation,
                radius: 120,
                strokeWidth: 40,
                // Radius in meters
                fillColor: Colors.black.withOpacity(0.20),
                strokeColor: Colors.black,
              ),
              Circle(
                circleId: const CircleId('myCircle'),
                center: currentLocation,
                radius: 40,
                strokeWidth: 10,
                // Radius in meters
                fillColor: Colors.yellowAccent.withOpacity(0.1),
                strokeColor: Colors.yellowAccent.shade700,
              ),
              Circle(
                circleId: const CircleId('myCircle'),
                center: currentLocation,
                radius: 500,
                strokeWidth: 1,
                // Radius in meters
                fillColor: Colors.grey.withOpacity(0.50),
                strokeColor: Colors.grey,
              ),
            },
          ),
        ));
  }
}

class SwitchExample extends StatefulWidget {
  const SwitchExample({super.key});

  @override
  State<SwitchExample> createState() => _SwitchExampleState();
}

class _SwitchExampleState extends State<SwitchExample> {
  bool light = true;
  final ProfileControllerUpadte ProfileControlleronj = Get.put(ProfileControllerUpadte());
  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 1.4,
      child: Row(
        children: [
          Switch(
            value: light,
            activeColor: Colors.amber,
            inactiveThumbColor: Colors.white54,
            activeTrackColor: Colors.grey,
            onChanged: (bool value) {
              // This is called when the user toggles the switch.
              setState(() {
                light = value;
                if (!light) {
                  light = false;
                  try {
                    var jsonString = {
                      "request": "setDriverOffline",
                      "data": {"d_id": driverid}
                    };
                    String convertedJsonStr = json.encode(jsonString);
                    final wsUrl = Uri.parse('wss://ridewithlex.com:7070');
                    var channel = WebSocketChannel.connect(wsUrl);
                    channel.sink.add(convertedJsonStr);
                    channel.stream.listen((message) {
                      // channel.sink.close(status.goingAway);
                    });
                  } on Exception catch (_) {
                    print("eorror $_");
                    rethrow;
                  }
                  ProfileControlleronj.onlinecheck =false;
                  Get.toNamed("/navmain", arguments: ['parameter1', 'parameter2']);
                }
              });
            },
          ),
          const Text(
            "Online",
            textAlign: TextAlign.left,
            style: TextStyle(
                fontSize: 12,
                color:Colors.green,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
