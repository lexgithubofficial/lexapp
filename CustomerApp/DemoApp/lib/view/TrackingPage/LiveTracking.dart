
import 'package:demoapp/view/TrackingPage/LiveTrackingController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class LiveTracking extends StatefulWidget {
  const LiveTracking({super.key});

  @override
  _LiveTracking createState() => _LiveTracking();
}

class _LiveTracking extends State<LiveTracking> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final LiveTrackingController LiveTrackingControllerobj = Get.put(LiveTrackingController());
    LiveTrackingControllerobj.setSelected();

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
              height: size.height * 0.70,
              child: Stack(
                children: [
                  GoogleMap( //Map widget from google_maps_flutter package
                    zoomGesturesEnabled: true, //enable Zoom in, out on map
                    initialCameraPosition: CameraPosition(
                      target: LiveTrackingControllerobj.startLocation, //initial position
                      zoom: 14.0, //initial zoom level
                    ),
                    markers: LiveTrackingControllerobj.markers.obs, //markers to show on map
                    polylines: Set<Polyline>.of(LiveTrackingControllerobj.polylines.values), //polylines
                    mapType: MapType.normal, //map type
                    onMapCreated: (controller) { //method called when map is created
                      setState(() {
                        LiveTrackingControllerobj.mapController = controller;
                      });
                    },

                  ),

                  Positioned(
                      bottom: 200,
                      left: 50,
                      child: Card(
                        child: Container(
                            padding: const EdgeInsets.all(20),
                            child: Text("Total Distance: ${LiveTrackingControllerobj.distance.toStringAsFixed(2)} KM",
                                style: const TextStyle(fontSize: 13, fontWeight:FontWeight.bold))
                        ),
                      )
                  )
                ],
              ),

            ),
            Padding(
              padding:  EdgeInsets.only(top: size.height * 0.65),
              child: SizedBox(
                height: size.height * 0.6,
                child: Stack(
                  children: [
                    Center(
                      child: Container(
                        height: size.height * 0.55,
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft:  Radius.circular(30)),
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
