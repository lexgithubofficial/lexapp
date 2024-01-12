import 'dart:async';
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:driverapp/drawer/driverRequirment/DriverRequerment.dart';
import 'package:driverapp/drawer/wallest/payout/Payout.dart';
import 'package:driverapp/drawer/Setting.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../Getx/api/ApiConstants.dart';
import '../constants.dart';
import 'HomeAllTask/Home.dart';
import 'Profile/Profile.dart';
import 'Profile/ProfileControllerUpadte.dart';
import 'RateAndReviewv/RateAndReview.dart';
import 'TaskHistory/TaskHistory.dart';
import 'Logout.dart';
import 'wallest/addWallet.dart';
import 'my_drawer_header.dart';
import 'Supports.dart';
import 'Contact.dart';
import '../SharedPref.dart';

void main() {
  runApp(navmain());
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
  var subscription;

  @override
  dispose() {
    subscription.cancel();
    super.dispose();
  }

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
    subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      var tempconnection = result;
      final connectivityResult = (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        Get.showSnackbar(
          GetSnackBar(
            message: tempconnection.toString(),
            duration: const Duration(seconds: 3),
          ),
        );
      }

      // Got a new connectivity status!
    });

    super.initState();
  }

  Future<bool> netcheck() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      // I am connected to a mobile network.
    } else if (connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a wifi network.
    } else if (connectivityResult == ConnectivityResult.ethernet) {
      // I am connected to a ethernet network.
    } else if (connectivityResult == ConnectivityResult.vpn) {
      // I am connected to a vpn network.
      // Note for iOS and macOS:
      // There is no separate network interface type for [vpn].
      // It returns [other] on any device (also simulator)
    } else if (connectivityResult == ConnectivityResult.bluetooth) {
      // I am connected to a bluetooth.
    } else if (connectivityResult == ConnectivityResult.other) {
      // I am connected to a network which is not in the above mentioned networks.
    } else if (connectivityResult == ConnectivityResult.none) {
      // I am not connected to any network.
    }
    return false;
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
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(position.longitude);
    print(position.latitude);

    long = position.longitude.toString();
    lat = position.latitude.toString();

    lattidude = position.latitude;
    longitude = position.longitude;

    driverid = await SharedPref.getDriverId();
    print("driverid=$driverid");
    setState(() {
      //refresh UI
    });

    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high, //accuracy of the location data
      distanceFilter: 100, //minimum distance (measured in meters) a
      //device must move horizontally before an update event is generated;
    );

    StreamSubscription<Position> positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position position) {
      print(position.longitude); //Output: 80.24599079
      print(position.latitude); //Output: 29.6593457

      long = position.longitude.toString();
      lat = position.latitude.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    final ProfileControllerUpadte ProfileControlleronj = Get.put(ProfileControllerUpadte());

    var container;

    if (currentPage == DrawerSections.Home) {
      container = const Home();
    } else if (currentPage == DrawerSections.TaskHistory) {
      container = const TaskHistory();
    } else if (currentPage == DrawerSections.Profile) {
      container = const Profile();
    } else if (currentPage == DrawerSections.DriverRequirment) {
      container = const DriverRequerment();
    } else if (currentPage == DrawerSections.Setting) {
      container = Setting();
    } else if (currentPage == DrawerSections.Wallets) {
      container = const addWallet();
    } else if (currentPage == DrawerSections.Payout) {
      container = const Payout();
    } else if (currentPage == DrawerSections.Contact) {
      container = Contact();
    } else if (currentPage == DrawerSections.Supports) {
      container = Supports();
    } else if (currentPage == DrawerSections.rateandreview) {
      container = const RateAndReview();
    } else if (currentPage == DrawerSections.Logout) {
      container = const Logout();
    }
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const CircleAvatar(
              backgroundColor: Colors.black54,
              child: Icon(
                Icons.menu,
                color: Colors.white,
              ),
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 70),
            child: Transform.scale(
              scale: 1.3,
              child: Obx(() {
                return ProfileControlleronj.isLoading.value
                    ? const Center()
                    : Row(
                        children: [
                          Switch(
                            value: ProfileControlleronj.onlinecheck,
                            activeColor: Colors.amber,
                            inactiveThumbColor: Colors.white54,
                            activeTrackColor: Colors.grey,
                            onChanged: (bool value) async {
                              ProfileControlleronj.onlinecheck = value;
                              if (ProfileControlleronj.onlinecheck) {
                                int id = await SharedPref.getDriverId();
                                Get.toNamed("/OnlinePage", arguments: [id]);
                              } else {
                                try {
                                  int id = await SharedPref.getDriverId();
                                  var jsonString = {
                                    "request": "setDriverOffline",
                                    "data": {"d_id": id}
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
                              }
                            },
                          ),
                          const Text(
                            "Offline",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      );
              }),
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.toNamed("/Profile", arguments: ['parameter1', 'parameter2']);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Obx(() {
                return ProfileControlleronj.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : ProfileControlleronj.View == 0
                        ? const Center(child: CircularProgressIndicator())
                        : CircleAvatar(
                            radius: 20.0,
                            backgroundImage: NetworkImage(
                              ApiConstants.imgviewbasepath +
                                  ProfileControlleronj
                                      .profileModel.data.profileImage,
                            ),
                          );
              }),
            ),
          ),
        ],
      ),
      body: container,
      drawer: Drawer(
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
      padding: const EdgeInsets.only(
        top: 15,
      ),
      child: Column(
        // shows the list of menu drawer
        children: [
          menuItem(1, "Home", Icons.home,
              currentPage == DrawerSections.Home ? true : false),
          menuItem(2, "Task History", Icons.bookmarks_sharp,
              currentPage == DrawerSections.TaskHistory ? true : false),
          menuItem(3, "Profile", Icons.person_pin_circle_outlined,
              currentPage == DrawerSections.Profile ? true : false),
          menuItem(4, "Driver Requirements", Icons.drive_eta_rounded,
              currentPage == DrawerSections.DriverRequirment ? true : false),
          menuItem(5, "Setting", Icons.settings_applications_sharp,
              currentPage == DrawerSections.Setting ? true : false),
          menuItem(6, "Wallets", Icons.wallet_giftcard,
              currentPage == DrawerSections.Wallets ? true : false),
          menuItem(7, "Payout", Icons.payment_outlined,
              currentPage == DrawerSections.Payout ? true : false),
          menuItem(8, "Contact", Icons.contact_mail_outlined,
              currentPage == DrawerSections.Contact ? true : false),
          menuItem(9, "Supports", Icons.supervised_user_circle_outlined,
              currentPage == DrawerSections.rateandreview ? true : false),
          menuItem(10, "Logout", Icons.logout,
              currentPage == DrawerSections.Logout ? true : false),
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
              Get.toNamed("/TaskHistory",
                  arguments: ['parameter1', 'parameter2']);
            } else if (id == 3) {
              Get.toNamed("/Profile", arguments: ['parameter1', 'parameter2']);
            } else if (id == 4) {
              // currentPage = DrawerSections.Parameters;
              Get.toNamed("/DriverRequerment",
                  arguments: ['parameter1', 'parameter2']);
            } else if (id == 5) {
              Get.toNamed("/Setting", arguments: ['parameter1', 'parameter2']);
            } else if (id == 6) {
              Get.toNamed("/addWallet",
                  arguments: ['parameter1', 'parameter2']);
            } else if (id == 7) {
              Get.toNamed("/Payout", arguments: ['parameter1', 'parameter2']);
            } else if (id == 8) {
              Get.toNamed("/Contact", arguments: ['parameter1', 'parameter2']);
            } else if (id == 9) {
              Get.toNamed("/Supports", arguments: ['parameter1', 'parameter2']);
            } else if (id == 10) {
              Get.toNamed("/Logout", arguments: ['parameter1', 'parameter2']);
            }
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Expanded(
                child: Icon(
                  icon,
                  size: 20,
                  color: Colors.black,
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: "FontMain"),
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
  TaskHistory,
  Profile,
  DriverRequirment,
  Setting,
  Wallets,
  Payout,
  Contact,
  Supports,
  rateandreview,
  Logout,
}
