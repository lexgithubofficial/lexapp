import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../../constants.dart';

class mapRnd extends StatefulWidget {
  const mapRnd({Key? key}) : super(key: key);

  @override
  State<mapRnd> createState() => OrderTrackingPageState();
}

class OrderTrackingPageState extends State<mapRnd> {

  LocationData? currentLocation;

  final Completer<GoogleMapController> _controller = Completer();

  CameraPosition cCameraPosition = CameraPosition(
    target: LatLng(lattidude,longitude), zoom: 13.5);

  final Set<Marker> markerList = {};
  final Set<Polyline> PolylineList = {};
  List<LatLng> latlong = [
    LatLng(lattidude, longitude),
    LatLng(lattidude+0.0004, longitude+0.0004)
  ];

  @override
  void initState() {
    super.initState();
    for(int i =0; i<latlong.length; i++) {
      markerList.add(Marker(markerId: MarkerId(i.toString()),
          position: latlong[i],
          infoWindow: InfoWindow(
              title: "ttt",
              snippet: "444"
          ),
          icon: BitmapDescriptor.defaultMarker));

      setState(() {});
      PolylineList.add(Polyline(polylineId: PolylineId("U"),
          points: latlong));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:GoogleMap(
        markers: markerList,
        polylines: PolylineList,
        onMapCreated: (mapController) {
          _controller.complete(mapController);
        },
        myLocationEnabled: true,
        initialCameraPosition: cCameraPosition,
        mapType: MapType.none,
      )
    );
  }

}
