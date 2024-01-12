
import 'package:demoapp/constants.dart';
import 'package:demoapp/drawer/helpandsupport.dart';
import 'package:demoapp/drawer/promodcode.dart';
import 'package:demoapp/view/AppReports/appreport.dart';
import 'package:demoapp/view/HomePage/HomeActivity.dart';
import 'package:demoapp/view/Loyalti/loyality.dart';
import 'package:demoapp/view/RidesPage/RidesPage.dart';
import 'package:demoapp/view/RidesPage/bid_ride_page.dart';
import 'package:demoapp/view/Setting/Setting.dart';
import 'package:demoapp/view/ShareApp/ShareApp.dart';
import 'package:demoapp/view/TrackingPage/TrackingPage.dart';
import 'package:demoapp/view/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Logout.dart';
import 'paymentmethord.dart';
import 'my_drawer_header.dart';
import 'dart:async';
import 'package:geolocator/geolocator.dart';
void main() {
  runApp(const navmain());
}

class navmain extends StatelessWidget {
  const navmain({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();

}


class _HomePageState extends State<HomePage> {

  var currentPage = DrawerSections.Home;
  bool servicestatus = false;
  bool haspermission = false;
  late LocationPermission permission;
  late Position position;
  String long = "", lat = "";
  late StreamSubscription<Position> positionStream;
  @override
  void initState() {
    checkGps();
    getLocation();
    super.initState();
  }
  checkGps() async {
    servicestatus = await Geolocator.isLocationServiceEnabled();
    if (servicestatus) {
      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          print('Location permissions are denied');
        } else if (permission == LocationPermission.deniedForever) {
          print("'Location permissions are permanently denied");
        } else {
          haspermission = true;
        }
      } else {
        haspermission = true;
      }

      if (haspermission) {
        setState(() {
          //refresh the UI
        });

        getLocation();
      }
    } else {
      print("GPS Service is not enabled, turn on GPS location");
    }
  }

  getLocation() async {
      position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      print(position.longitude); //Output: 80.24599079
      print(position.latitude); //Output: 29.6593457

      long = position.longitude.toString();
      lat = position.latitude.toString();

      lattidude =position.latitude ;
      longitude = position.longitude ;

      setState(() {
        //refresh UI
      });

      LocationSettings locationSettings = const LocationSettings(
        accuracy: LocationAccuracy.high, //accuracy of the location data
        distanceFilter: 100, //minimum distance (measured in meters) a
        //device must move horizontally before an update event is generated;
      );

      StreamSubscription<Position> positionStream = Geolocator.getPositionStream(
          locationSettings: locationSettings).listen((Position position) {
        print(position.longitude); //Output: 80.24599079
        print(position.latitude); //Output: 29.6593457

        long = position.longitude.toString();
        lat = position.latitude.toString();


      });
    }


  @override
  Widget build(BuildContext context) {
    var container;

    if (currentPage == DrawerSections.Home) {
      container = const HomeActivity();
    }
    else if (currentPage == DrawerSections.myrides) {
      container = const RidesPage();
    }

    else if (currentPage == DrawerSections.profile) {
      container = const profile();
    }

    else if (currentPage == DrawerSections.bookforfuture) {
      container = const BidARidesPage();
    }
    else if (currentPage == DrawerSections.loyaltyprogram) {
      container = const loyality();
    }

    else if (currentPage == DrawerSections.paymentmethord) {
      container = const paymentmethord();
    } else if (currentPage == DrawerSections.trackyourride) {
      container = const TrackingPage();
    } else if (currentPage == DrawerSections.setting) {
      container = const Setting();
    } else if (currentPage == DrawerSections.helpandsupport) {
      container = const helpandsupport();
    } else if (currentPage == DrawerSections.appreport) {
      container = const appreport();
    } else if (currentPage == DrawerSections.promodcode) {
      container = const promodcode();
    } else if (currentPage == DrawerSections.shareapp) {
      container = const ShareApp();
    }
    else if (currentPage == DrawerSections.logout) {
      container = const Logout();
    }
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        actions:  [
          Builder(
            builder: (context) => IconButton(
              icon: const CircleAvatar(
                backgroundColor: Colors.black54,
                child: Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
              ),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            ),
          )
        ],
      ),

      body: container,

      endDrawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const MyHeaderDrawer(),
              MyDrawerList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget MyDrawerList() {
    return Container(
      color: const Color(0xFFfff8e5),
      padding: const EdgeInsets.only(top: 15,),
      child: Column(
        // shows the list of menu drawer
        children: [
          menuItem(1, "Home", Icons.home,
              currentPage == DrawerSections.Home ? true : false),

          menuItem(2, "My Rides", Icons.car_repair,
              currentPage == DrawerSections.myrides ? true : false),

          menuItem(3, "My Profile", Icons.person,
              currentPage == DrawerSections.profile? true : false),

          menuItem(4, "Book For Future", Icons.car_crash_sharp,
              currentPage == DrawerSections.bookforfuture ? true : false),
          menuItem(5, "Loyalty Program", Icons.loyalty_rounded,
              currentPage == DrawerSections.loyaltyprogram ? true : false),
          menuItem(6, "Payment Methods", Icons.payment_outlined,
              currentPage == DrawerSections.paymentmethord ? true : false),
          menuItem(7, "Track Your Ride", Icons.payment_outlined,
              currentPage == DrawerSections.trackyourride ? true : false),
          menuItem(8, "Setting", Icons.settings_applications_sharp,
              currentPage == DrawerSections.setting ? true : false),
          menuItem(9, "Help & Support", Icons.help,
              currentPage == DrawerSections.helpandsupport ? true : false),
          menuItem(10, "App Report", Icons.report,
              currentPage == DrawerSections.appreport ? true : false),
          menuItem(11, "Promo Code", Icons.local_offer_sharp,
              currentPage == DrawerSections.promodcode ? true : false),
          menuItem(12, "Share App", Icons.share,
              currentPage == DrawerSections.shareapp ? true : false),
          menuItem(13, "Log Out", Icons.logout,
              currentPage == DrawerSections.logout ? true : false),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              margin: const EdgeInsets.only(top: 15,right: 70),
              child: const Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  "    Version 1.1",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: "FontMain"),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget menuItem(int id, String title, IconData icon, bool selected) {
    return Material(
      color: selected ? Colors.grey[100] : Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            if (id == 1) {
              currentPage = DrawerSections.Home;
            } else if (id == 2) {
              Get.toNamed("/RidesPage",
                  arguments: ['parameter1', 'parameter2']);
            } else if (id == 3) {
              Get.toNamed("/UpdateProfile", arguments: ['parameter1', 'parameter2']);
            }
            else if (id == 4) {
              Get.toNamed("/bookforfuture", arguments: ['parameter1', 'parameter2']);
            }

            else if (id == 5) {
              Get.toNamed("/loyality", arguments: ['parameter1', 'parameter2']);
            } else if (id == 6) {
              Get.toNamed("/paymentmethord",
                  arguments: ['parameter1', 'parameter2']);
            } else if (id == 7) {
              Get.toNamed("/TrackingPage", arguments: ['parameter1', 'parameter2']);
            } else if (id == 8) {
              Get.toNamed("/Setting", arguments: ['parameter1', 'parameter2']);
            } else if (id == 9) {
              Get.toNamed("/ContactUs", arguments: ['parameter1', 'parameter2']);
            } else if (id == 10) {
              Get.toNamed("/TopicChoose", arguments: ['parameter1', 'parameter2']);
            }
            else if (id == 11) {
              Get.toNamed("/promodcode", arguments: ['parameter1', 'parameter2']);
            }
            else if (id == 12) {
              Get.toNamed("/ShareApp", arguments: ['parameter1', 'parameter2']);
            }
            else if (id == 13) {
              Get.toNamed("/Logout", arguments: ['parameter1', 'parameter2']);
            }
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(9.0),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  textAlign: TextAlign.right,
                  title,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: "FontMain"),
                ),
              ),
              Expanded(
                child: Icon(
                  icon,
                  size: 20,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


enum DrawerSections {
  Home,
  myrides,
  bookforfuture,
  profile,
  loyaltyprogram,
  paymentmethord,
  trackyourride,
  setting,
  helpandsupport,
  appreport,
  promodcode,
  shareapp,
  ratereview,
  logout
}

