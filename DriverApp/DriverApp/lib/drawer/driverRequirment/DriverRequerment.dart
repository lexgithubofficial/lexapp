import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'DriverRequermentController.dart';
class DriverRequerment extends StatefulWidget {
  const DriverRequerment({super.key});

  @override
  DriverRequirementPageState createState() => DriverRequirementPageState();
}

class DriverRequirementPageState extends State<DriverRequerment> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final DriverRequermentController DriverRequermentControllerobj = Get.put(DriverRequermentController());
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
            "Driver Requirement",
            style: TextStyle(
                color: Colors.black,
                fontFamily: "FontMain",
                fontWeight: FontWeight.bold),
          ),
        ),
        body: Container(
          color: Colors.black,
          child: Stack(
            children: [
              Container(
                height: size.height * 0.35,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFFf8c102),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: size.height * 0.16),
                      child: Stack(
                        children: [
                          Center(
                            child: Container(
                              height: size.height * .90,
                              width: size.width * 0.9,
                              decoration: BoxDecoration(
                                color: const Color(0xFF3c3c3c),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Center(
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: 15, right: 15, top: 15),
                                            child: Text("Driver Requirements",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                    fontFamily: "FontMain",
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                        ),
                                        Container(
                                          height: 60,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.5),
                                              ),
                                              BoxShadow(
                                                color: Colors.grey.shade800,
                                                spreadRadius: -2.0,
                                                blurRadius: 2.0,
                                              ),
                                            ],
                                          ),
                                          margin: const EdgeInsets.all(15),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Padding(
                                                padding:
                                                    EdgeInsets.only(left: 20),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Get Started",
                                                      style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 11,
                                                        fontFamily: "FontMain",
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      "Add Your Bank Account",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily: "FontMain",
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  Get.toNamed("/AddBankAccount",
                                                      arguments: [
                                                        'parameter1',
                                                        'parameter2'
                                                      ]);
                                                },
                                                child: const Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 20),
                                                  child: Icon(
                                                      FontAwesomeIcons
                                                          .chevronCircleRight,
                                                      color: Colors.yellow,
                                                      size: 25),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          height: 60,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.5),
                                              ),
                                              BoxShadow(
                                                color: Colors.grey.shade800,
                                                spreadRadius: -2.0,
                                                blurRadius: 2.0,
                                              ),
                                            ],
                                          ),
                                          margin: const EdgeInsets.only(
                                              left: 15, right: 15),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Padding(
                                                padding:
                                                    EdgeInsets.only(left: 20),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Get Started",
                                                      style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 11,
                                                        fontFamily: "FontMain",
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      "Swiss ID",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12,
                                                          fontFamily:
                                                              "FontMain",
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  DriverRequermentControllerobj.saveSwissId("",context);
                                                },
                                                child: const Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 20),
                                                  child: Icon(
                                                      FontAwesomeIcons
                                                          .chevronCircleRight,
                                                      color: Colors.yellow,
                                                      size: 25),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          height: 60,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.5),
                                              ),
                                              BoxShadow(
                                                color: Colors.grey.shade800,
                                                spreadRadius: -2.0,
                                                blurRadius: 2.0,
                                              ),
                                            ],
                                          ),
                                          margin: const EdgeInsets.only(
                                              left: 15, right: 15, top: 15),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Padding(
                                                padding:
                                                    EdgeInsets.only(left: 20),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Get Started",
                                                      style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 11,
                                                        fontFamily: "FontMain",
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      "Proof of residence",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12,
                                                          fontFamily:
                                                              "FontMain",
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ),

                                              GestureDetector(
                                                onTap: () {
                                                  DriverRequermentControllerobj.saveSwissId("Proof of residence",context);
                                                },
                                                child: const Padding(
                                                  padding:
                                                      EdgeInsets.only(right: 20),
                                                  child: Icon(
                                                      FontAwesomeIcons
                                                          .chevronCircleRight,
                                                      color: Colors.yellow,
                                                      size: 25),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          height: 60,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.5),
                                              ),
                                              BoxShadow(
                                                color: Colors.grey.shade800,
                                                spreadRadius: -2.0,
                                                blurRadius: 2.0,
                                              ),
                                            ],
                                          ),
                                          margin: const EdgeInsets.only(
                                              left: 15, right: 15, top: 15),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Padding(
                                                padding:
                                                    EdgeInsets.only(left: 20),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Optional",
                                                      style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 11,
                                                        fontFamily: "FontMain",
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      "Card AVS",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12,
                                                          fontFamily:
                                                              "FontMain",
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  DriverRequermentControllerobj.saveSwissId("Card AVS",context);
                                                },
                                                child: const Padding(
                                                  padding:
                                                      EdgeInsets.only(right: 20),
                                                  child: Icon(
                                                      FontAwesomeIcons
                                                          .chevronCircleRight,
                                                      color: Colors.yellow,
                                                      size: 25),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          height: 60,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.5),
                                              ),
                                              BoxShadow(
                                                color: Colors.grey.shade800,
                                                spreadRadius: -2.0,
                                                blurRadius: 2.0,
                                              ),
                                            ],
                                          ),
                                          margin: const EdgeInsets.only(
                                              left: 15, right: 15, top: 15),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Padding(
                                                padding:
                                                    EdgeInsets.only(left: 20),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Optional",
                                                      style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 11,
                                                        fontFamily: "FontMain",
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      "Tax setting",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12,
                                                          fontFamily:
                                                              "FontMain",
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ),

                                              GestureDetector(
                                                  onTap: () {
                                                    DriverRequermentControllerobj.saveSwissId("Tax setting",context);
                                                  },
                                                child: const Padding(
                                                  padding:
                                                      EdgeInsets.only(right: 20),
                                                  child: Icon(
                                                      FontAwesomeIcons
                                                          .chevronCircleRight,
                                                      color: Colors.yellow,
                                                      size: 25),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          height: 60,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.5),
                                              ),
                                              BoxShadow(
                                                color: Colors.grey.shade800,
                                                spreadRadius: -2.0,
                                                blurRadius: 2.0,
                                              ),
                                            ],
                                          ),
                                          margin: const EdgeInsets.only(
                                              left: 15, right: 15, top: 15),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Padding(
                                                padding:
                                                    EdgeInsets.only(left: 20),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Get Started",
                                                      style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 11,
                                                        fontFamily: "FontMain",
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      "Swiss driving license ",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12,
                                                          fontFamily:
                                                              "FontMain",
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              GestureDetector(
                                                  onTap: () {
                                                    DriverRequermentControllerobj.saveSwissId("Swiss driving license",context);
                                                  },
                                                child: const Padding(
                                                  padding:
                                                      EdgeInsets.only(right: 20),
                                                  child: Icon(
                                                      FontAwesomeIcons
                                                          .chevronCircleRight,
                                                      color: Colors.yellow,
                                                      size: 25),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          height: 60,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.5),
                                              ),
                                              BoxShadow(
                                                color: Colors.grey.shade800,
                                                spreadRadius: -2.0,
                                                blurRadius: 2.0,
                                              ),
                                            ],
                                          ),
                                          margin: const EdgeInsets.only(
                                              left: 15, right: 15, top: 15),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Padding(
                                                padding:
                                                    EdgeInsets.only(left: 20),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Get Started",
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 11),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      "Control driving license ",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12,
                                                          fontFamily:
                                                              "FontMain",
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              GestureDetector(
                                                  onTap: () {
                                                    DriverRequermentControllerobj.saveSwissId("Control driving license",context);
                                                  },
                                                child: const Padding(
                                                  padding:
                                                      EdgeInsets.only(right: 20),
                                                  child: Icon(
                                                      FontAwesomeIcons
                                                          .chevronCircleRight,
                                                      color: Colors.yellow,
                                                      size: 25),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
