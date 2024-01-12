import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import '../../constants.dart';
import '../../drawer/navmain.dart';
import 'LoginController.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  bool _obscureText = true;

  Future<bool> _onPop() async {
    return false;
  }

  TextEditingController cltEmailId = TextEditingController();
  TextEditingController sendemail = TextEditingController();
  TextEditingController cltPassword = TextEditingController();
  var currentPage = DrawerSections.Home;
  bool servicestatus = false;
  bool haspermission = false;
  late LocationPermission permission;
  late Position position;
  String long = "", lat = "";
  late StreamSubscription<Position> positionStream;

  @override
  void initState() {
    super.initState();
    cltEmailId = TextEditingController();
    cltPassword = TextEditingController();
    checkGps();
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
  }

  @override
  void dispose() {
    cltEmailId.dispose();
    cltPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement buil
    final LoginController LoginController0bj = Get.put(LoginController());
    Size size = MediaQuery.of(context).size;

    return WillPopScope(
        onWillPop: _onPop,
        child: Scaffold(
          body: Stack(
            children: [
              Container(
                color: Colors.black,
              ),
              Container(
                width: double.infinity,
                height: size.width * .80,
                decoration: const BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.all(Radius.circular(25))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/logincar.png',
                      height: 280,
                      width: 300,
                    )
                  ],
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(top: size.width * .72),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        padding: const EdgeInsets.only(top: 30),
                        child: const Text("Welcome Back",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontFamily: "FontMain",
                                fontWeight: FontWeight.bold)),
                      ),
                      const Text("Please login to continue",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontFamily: "FontMain",
                              fontWeight: FontWeight.normal)),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                            left: 40, right: 40, top: 10, bottom: 20),
                        child: Column(
                          children: [
                            TextField(
                                keyboardType: TextInputType.emailAddress,
                                controller: cltEmailId,
                                style: const TextStyle(color: Colors.white),
                                decoration: const InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15.0),
                                    ),
                                    borderSide: BorderSide(
                                        color: Colors.yellow, width: 1.0),
                                  ),
                                  hintText: 'Email',
                                  hintStyle: TextStyle(fontSize: 14.0, color: Colors.white70),
                                  prefixIcon: Icon(
                                    Icons.email,
                                    color: Colors.white70,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15.0),
                                    ),
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                      width: 1.0,
                                    ),
                                  ),
                                )),
                            const SizedBox(
                              height: 20,
                            ),
                            TextField(
                                keyboardType: TextInputType.visiblePassword,
                                controller: cltPassword,
                                obscureText: _obscureText,
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  enabledBorder: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15.0),
                                    ),
                                    borderSide: BorderSide(
                                        color: Colors.yellow, width: 1.0),
                                  ),
                                  hintText: 'Password',
                                  hintStyle: const TextStyle(fontSize: 14.0, color: Colors.white70),
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _obscureText = !_obscureText;
                                      });
                                    },
                                    child: Icon(
                                      _obscureText
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                  ),
                                  prefixIcon: const Icon(
                                    Icons.key,
                                    color: Colors.white70,
                                  ),
                                  border: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15.0),
                                    ),
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                      width: 1.0,
                                    ),
                                  ),
                                )),
                            const SizedBox(
                              height: 6,
                            ),
                            Column(
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.topRight,
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.dialog(
                                        SizedBox(
                                          height: size.width * .85,
                                          width: size.width * .8,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 40),
                                                child: Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(20),
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            20.0),
                                                    child: Material(
                                                      child: Column(
                                                        children: [
                                                          const SizedBox(
                                                              height: 3),
                                                          const Text(
                                                            " Forgot password",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                color: Color(0xff222b38),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 17),
                                                          ),
                                                          TextField(
                                                            keyboardType:
                                                                TextInputType
                                                                    .emailAddress,
                                                            controller:
                                                                sendemail,
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .black54),
                                                            decoration:
                                                                const InputDecoration(
                                                              enabledBorder:
                                                                  UnderlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .grey),
                                                              ),
                                                              labelStyle: TextStyle(
                                                                  color: Colors
                                                                      .black54,
                                                                  fontSize: 15,
                                                                  fontFamily:
                                                                      "FontMain"),
                                                              labelText:
                                                                  'Email',
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              height: 10),
                                                          MaterialButton(
                                                            color:
                                                                yellow_box_color,
                                                            height: 45,
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                            ),
                                                            onPressed: () {
                                                              String emailId =
                                                                  sendemail.text
                                                                      .toString();
                                                              LoginController0bj
                                                                  .forgotPassword(
                                                                      emailId);
                                                            },
                                                            child:
                                                                const SizedBox(
                                                              width: 250,
                                                              child: Row(
                                                                children: <Widget>[
                                                                  Expanded(
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Text(
                                                                        "SEND",
                                                                        style: TextStyle(
                                                                            color: Colors
                                                                                .black,
                                                                            fontSize:
                                                                                14,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontFamily: "FontMain"),
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
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                    child: const Text("Forgot password   ",
                                        style: TextStyle(
                                            color: Colors.yellowAccent,
                                            fontSize: 13,
                                            decoration:
                                                TextDecoration.underline,
                                            fontFamily: "FontMain")),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      MaterialButton(
                        color: yellow_box_color,
                        height: 45,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        onPressed: () {
                          String emailId = cltEmailId.text.toString();
                          String Password = cltPassword.text.toString();
                          LoginController0bj.nextClick(
                              context, emailId, Password);
                        },
                        child: const SizedBox(
                          width: 250,
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Center(
                                  child: Text(
                                    "LOG IN",
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "FontMain"),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Text("Don't have a account? ",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontFamily: "FontMain")),
                            GestureDetector(
                              onTap: () {
                                Get.toNamed("/CreateProfile",
                                    arguments: ['parameter1', 'parameter2']);
                              },
                              child: const Text("Create One",
                                  style: TextStyle(
                                      color: Colors.yellow,
                                      fontSize: 15,
                                      fontFamily: "FontMain")),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              height: 1, width: 70, color: Colors.white54),
                          const Text("  or continue with  ",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontFamily: "FontMain")),
                          Container(
                              height: 1, width: 70, color: Colors.white54),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            'assets/images/google.png',
                            height: 25,
                            width: 25,
                          ),
                          const SizedBox(
                            width: 22,
                          ),
                          Image.asset(
                            'assets/images/fb.png',
                            height: 25,
                            width: 25,
                          ),
                          const SizedBox(
                            width: 22,
                          ),
                          Image.asset(
                            'assets/images/apple.png',
                            height: 25,
                            width: 25,
                            color: Colors.white,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
