import 'dart:async';
import 'dart:convert';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:demoapp/Controller/HomeController.dart';
import 'package:demoapp/Getx/api/ApiConstants.dart';
import 'package:demoapp/constants.dart';
import 'package:demoapp/view/RidesPage/RidesPage.dart';
import 'package:demoapp/view/profile/Account_view.dart';
import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_webservice/places.dart';

class HomeActivity extends StatelessWidget {
  const HomeActivity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
    //***controller****///
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        backgroundColor:
            //  controller.tabIndex.value == 0 ?
            Colors.black,
        // : Color(0xFFFFFFFF),
        buttonBackgroundColor: const Color(0xFFfcc312),
        color: const Color(0xFF6c757d),
        items: const [
          Icon(
            Icons.home,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.car_crash_outlined,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.person,
            size: 30,
            color: Colors.white,
          ),
        ],
        index: 0,
        onTap: (index) {
          Get.find<HomeController>().changeTabIndex(index);
        },
      ),
      body: Obx(() => [
            const Home1(),
            const RidesPage(),
            const Account_view(),
          ][Get.find<HomeController>().tabIndex.value]),
    );
  }
}

class Home1 extends StatefulWidget {
  const Home1({Key? key}) : super(key: key);

  @override
  _Home1 createState() => _Home1();

}

class _Home1 extends State<Home1> {
  @override
  void initState() {
    super.initState();
    setState(() {
      final HomeController HomeController_obj = Get.put(HomeController());
      HomeController_obj.addCustomIcon();
      HomeController_obj.fetchData();
      HomeController_obj.getAddressFromLatLng(lattidude, longitude);
    });

  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final HomeController HomeController_obj = Get.put(HomeController());
    GoogleMapController? mapController;
    String googleApikey = ApiConstants.googleApi; //contrller for Google map
    ////********Map Related
    Completer<GoogleMapController> _controller = Completer();
    // on below line we have specified camera position
    CameraPosition _kGoogle = CameraPosition(
      target: LatLng(lattidude, longitude),
      zoom: 14.4746,
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: size.height * 0.4,
                  decoration: const BoxDecoration(
                    color: yellow_box_color,
                  ),
                  child: SizedBox(
                    child: SafeArea(
                      // on below line creating google maps
                      child: GoogleMap(
                        initialCameraPosition: _kGoogle,
                        // on below line we are setting markers on the map
                        markers: <Marker>{
                          Marker(
                            markerId: const MarkerId('1'),
                            icon: HomeController_obj.markerIcon,
                            position: LatLng(lattidude, longitude),
                          ),
                          Marker(
                              markerId: const MarkerId('2'),
                              icon: HomeController_obj.markerIcon,
                              position: LatLng(
                                  lattidude + 0.002, longitude - 0.002)),
                          Marker(
                              markerId: const MarkerId('3'),
                              icon: HomeController_obj.markerIcon,
                              position: LatLng(
                                  lattidude + 0.005, longitude + 0.005)),
                          Marker(
                              markerId: const MarkerId('3'),
                              icon: HomeController_obj.markerIcon,
                              position: LatLng(
                                  lattidude - 0.006, longitude + 0.006)),
                          Marker(
                              markerId: const MarkerId('3'),
                              icon: HomeController_obj.markerIcon,
                              position: LatLng(
                                  lattidude - 0.003, longitude + 0.003)),
                        },

                        // on below line specifying map type.
                        mapType: MapType.normal,
                        // on below line setting user location enabled.
                        myLocationEnabled: true,
                        // on below line setting compass enabled.
                        compassEnabled: true,
                        // on below line specifying controller on map complete.
                        onMapCreated: (GoogleMapController controller) {
                          _controller.complete(controller);
                          mapController = controller;
                        },
                      ),
                    ),
                  ),
                  // on pressing floating action button the camera will take to user current location
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: size.height * 0.56,
                    margin: EdgeInsets.only(top: size.height * 0.35),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 12,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IntrinsicHeight(
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 14),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      CircleAvatar(
                                        radius: 10,
                                        backgroundColor:
                                            yellow_box_color.withOpacity(0.4),
                                        child: const CircleAvatar(
                                          radius: 4,
                                          backgroundColor: yellow_box_color,
                                        ),
                                      ),
                                      const Expanded(
                                        child: VerticalDivider(
                                          color: Colors.white,
                                        ),
                                      ),
                                      CircleAvatar(
                                        radius: 10,
                                        backgroundColor:
                                            yellow_box_color.withOpacity(0.4),
                                        child: const CircleAvatar(
                                          radius: 4,
                                          backgroundColor: yellow_box_color,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Column(
                                        children: [
                                          InkWell(
                                              onTap: () async {
                                                var place =
                                                    await PlacesAutocomplete
                                                        .show(
                                                         logo: const Text(""),
                                                            context: context,
                                                            apiKey:
                                                                googleApikey,
                                                            mode:
                                                                Mode.overlay,
                                                            types: [],
                                                            strictbounds:
                                                                false,
                                                            components: [
                                                              Component(
                                                                  Component
                                                                      .country,
                                                                  ApiConstants.countrycodeD)
                                                            ],
                                                            //google_map_webservice package
                                                            onError: (err) {
                                                              print(err);
                                                            });

                                                if (place != null) {
                                                  HomeController_obj.location.value = place.description.toString();
                                                  HomeController_obj.PostPickupLocation.value =place.description.toString();

                                                  print("jcsjcj"+removeDiacritics(place.description.toString()));


                                                  //form google_maps_webservice package
                                                  final plist = GoogleMapsPlaces(
                                                    apiKey: googleApikey,
                                                    apiHeaders: await const GoogleApiHeaders().getHeaders(),
                                                    //from google_api_headers package
                                                  );
                                                  String placeid =
                                                      place.placeId ?? "0";
                                                  final detail = await plist
                                                      .getDetailsByPlaceId(
                                                          placeid);
                                                  final geometry =
                                                      detail.result.geometry!;
                                                  final lat =
                                                      geometry.location.lat;
                                                  final lang =
                                                      geometry.location.lng;
                                                  pickulattidude = lat;
                                                  pickulongitude = lang;
                                                }
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(1),
                                                child: Card(
                                                  child: Container(
                                                      decoration:
                                                          const BoxDecoration(
                                                        color: Colors.black54,
                                                        borderRadius:
                                                            BorderRadius
                                                                .only(),
                                                      ),
                                                      padding:
                                                          const EdgeInsets
                                                              .all(0),
                                                      width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width -
                                                          35,
                                                      child: ListTile(
                                                        title: Obx(
                                                          () {
                                                            return Text(
                                                              removeDiacritics(Get.find<HomeController>().location.toString().length > 60
                                                                  ? "${Get.find<HomeController>().location.toString().substring(0, 60)}..."
                                                                  : Get.find<HomeController>().location.toString()),
                                                              style: const TextStyle(
                                                                  color: yellow_box_color,
                                                                  fontSize:
                                                                      12,
                                                                  fontFamily:
                                                                      "FontMain"),
                                                            );
                                                          },
                                                        ),
                                                        trailing: const Icon(
                                                            Icons.clear,color: yellow_box_color,),
                                                        dense: true,
                                                      )),
                                                ),
                                              ))
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Column(
                                        children: [
                                          InkWell(
                                              onTap: () async {
                                                var place =
                                                    await PlacesAutocomplete
                                                        .show(
                                                           logo: const Text(""),
                                                            context: context,
                                                            apiKey:
                                                                googleApikey,
                                                            mode:
                                                                Mode.overlay,
                                                            types: [],
                                                            strictbounds:
                                                                false,

                                                            components: [
                                                              Component(
                                                                  Component
                                                                      .country,
                                                                  ApiConstants.countrycodeD)
                                                            ],
                                                            //google_map_webservice package
                                                            onError: (err) {
                                                              print(err);
                                                            });

                                                if (place != null) {
                                                  HomeController_obj
                                                          .Desti_location
                                                          .value =
                                                      place.description
                                                          .toString();
                                                  HomeController_obj
                                                          .PostDestiLocation
                                                          .value =
                                                      place.description
                                                          .toString();

                                                  //form google_maps_webservice package
                                                  final plist =
                                                      GoogleMapsPlaces(
                                                    apiKey: googleApikey,
                                                    apiHeaders: await const GoogleApiHeaders().getHeaders(),
                                                    //from google_api_headers package
                                                  );
                                                  String placeid =
                                                      place.placeId ?? "0";
                                                  final detail = await plist
                                                      .getDetailsByPlaceId(
                                                          placeid);
                                                  final geometry =
                                                      detail.result.geometry!;
                                                  final lat =
                                                      geometry.location.lat;
                                                  final lang =
                                                      geometry.location.lng;
                                                  droplattidude = lat;
                                                  droplongitude = lang;

                                                  HomeController_obj.postlat
                                                      .value = lat.toString();
                                                  HomeController_obj
                                                          .postlong.value =
                                                      lang.toString();
                                                }
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(1),
                                                child: Card(
                                                  child: Container(
                                                      decoration:
                                                          const BoxDecoration(
                                                        color: Colors.black54,
                                                        borderRadius:
                                                            BorderRadius
                                                                .only(),
                                                      ),
                                                      padding:
                                                          const EdgeInsets
                                                              .all(0),
                                                      width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width -
                                                          35,
                                                      child: ListTile(
                                                        title: Obx(
                                                          () {
                                                            return RichText(
                                                              text: TextSpan(
                                                                text:
                                                                removeDiacritics( Get.find<HomeController>()
                                                                  .Desti_location
                                                                  .toString()
                                                                  .length >
                                                                  60
                                                                  ? '${Get.find<HomeController>().Desti_location.toString().substring(0, 60)}...'
                                                                  : Get.find<
                                                                  HomeController>()
                                                                  .Desti_location
                                                                  .toString()),
                                                              style: const TextStyle(
                                                                  color: yellow_box_color,
                                                                  fontSize:
                                                                  12,
                                                                  fontFamily:
                                                                  "FontMain")
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                        trailing: const Icon(
                                                          Icons.clear,color: yellow_box_color,),
                                                        dense: true,
                                                      )),
                                                ),
                                              ))
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 200,
                            child: Obx(() {
                              return HomeController_obj.isLoading.value
                                  ? const Center(
                                      child: CircularProgressIndicator())
                                  : HomeController_obj.carData.data.isEmpty
                                      ? const Center(
                                          child: CircularProgressIndicator())
                                      : GridView.builder(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          // physics: ,
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            childAspectRatio: 0.6,
                                            mainAxisSpacing: 10,
                                            crossAxisSpacing: 10,
                                          ),
                                          itemCount: HomeController_obj
                                              .carData.data.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            HomeController_obj
                                                    .categoryId.value =
                                                HomeController_obj
                                                    .carData.data[index].id
                                                    .toString();
                                            HomeController_obj.userid.value =
                                                HomeController_obj
                                                    .carData.data[index].uid
                                                    .toString();
                                            HomeController_obj
                                                    .carcategoryname.value =
                                                HomeController_obj.carData
                                                    .data[index].carName
                                                    .toString();

                                            HomeController_obj
                                                    .carcategorphoto.value =
                                                HomeController_obj.carData
                                                    .data[index].carImage
                                                    .toString();
                                            return InkWell(onTap: () {
                                              Get.find<HomeController>()
                                                  .tappedIndex
                                                  .value = index;
                                              HomeController_obj
                                                      .categoryId.value =
                                                  HomeController_obj
                                                      .carData.data[index].id
                                                      .toString();
                                              HomeController_obj
                                                      .userid.value =
                                                  HomeController_obj
                                                      .carData.data[index].uid
                                                      .toString();
                                              HomeController_obj
                                                      .carcategoryname.value =
                                                  HomeController_obj.carData
                                                      .data[index].carName
                                                      .toString();
                                              HomeController_obj
                                                      .carcategorphoto.value =
                                                  HomeController_obj.carData
                                                      .data[index].carImage
                                                      .toString();
                                            }, child: Obx(
                                              () {
                                                return Container(
                                                  // height: 200,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Get.find<HomeController>()
                                                                    .tappedIndex ==
                                                                index
                                                            ? Colors.amber
                                                            : secodary_black,
                                                      ),
                                                      const BoxShadow(
                                                        color: secodary_black,
                                                        spreadRadius: -2.0,
                                                        blurRadius: 1.0,
                                                      ),
                                                    ],
                                                  ),
                                                  child: Stack(
                                                    children: [
                                                      Column(
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
                                                                    left: 30,
                                                                    top: 10),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  HomeController_obj
                                                                      .carData
                                                                      .data[
                                                                          index]
                                                                      .carName,
                                                                  style:
                                                                      const TextStyle(
                                                                    color:
                                                                        textColor,
                                                                    fontSize:
                                                                        12,
                                                                    fontFamily:
                                                                        "FontMain",
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                                Row(
                                                                    children: <Widget>[
                                                                      Text(
                                                                        HomeController_obj
                                                                            .carData
                                                                            .data[index]
                                                                            .totalCustomer,
                                                                        style:
                                                                            const TextStyle(
                                                                          color:
                                                                              Colors.white,
                                                                          fontSize:
                                                                              12,
                                                                          fontFamily:
                                                                              "FontMain",
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                        ),
                                                                      ),
                                                                      const Icon(
                                                                          Icons
                                                                              .person,
                                                                          color:
                                                                              Colors.white,
                                                                          size: 18),
                                                                      const SizedBox(
                                                                          width:
                                                                              10),
                                                                      Text(
                                                                        HomeController_obj
                                                                            .carData
                                                                            .data[index]
                                                                            .totalBag,
                                                                        style:
                                                                            const TextStyle(
                                                                          color:
                                                                              Colors.white,
                                                                          fontSize:
                                                                              12,
                                                                          fontFamily:
                                                                              "FontMain",
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                        ),
                                                                      ),
                                                                      const Icon(
                                                                        Icons
                                                                            .shop,
                                                                        color:
                                                                            Colors.white,
                                                                        size:
                                                                            18,
                                                                      ),
                                                                    ]),
                                                                const SizedBox(
                                                                  height: 6,
                                                                ),
                                                                Image.network(
                                                                  ApiConstants
                                                                          .img_baseurl +
                                                                      HomeController_obj
                                                                          .carData
                                                                          .data[index]
                                                                          .carImage,
                                                                  width: 100,
                                                                  height: 40,
                                                                  fit: BoxFit
                                                                      .fill,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            ));
                                          },
                                        );
                            }),
                          ),
                          MaterialButton(
                            color: yellow_box_color,
                            height: 50,
                            minWidth: double.infinity,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            onPressed: () {
                              if (HomeController_obj.PostPickupLocation ==
                                  "") {
                                validationAlert(
                                    "Kindly select your pickup location");
                                return;
                              }

                              if (HomeController_obj.PostDestiLocation ==
                                  "") {
                                validationAlert(
                                    "Kindly select your destination location");
                                return;
                              }
                              Get.toNamed("/BidARidesPage");
                            },
                            child: const Text(
                              "BOOK YOUR RIDE",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: "FontMain",
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
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
