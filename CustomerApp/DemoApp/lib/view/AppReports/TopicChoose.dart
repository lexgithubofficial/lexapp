
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../constants.dart';

class TopicChoose extends StatefulWidget {
  const TopicChoose({super.key});

  @override
  _SendFeedbackPageState createState() => _SendFeedbackPageState();
}

class _SendFeedbackPageState extends State<TopicChoose> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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
            "App Reports",
            style: TextStyle(color: Colors.black,  fontFamily: "FontMain",fontWeight: FontWeight.bold),
          ),
        ),
        body: Stack(
          children: [
            Container(
              height: size.height * 0.30,
              decoration: const BoxDecoration(
                color: yellow_box_color,
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
                    margin: EdgeInsets.only(top: size.height * 0.17),
                    child: SizedBox(
                      height: size.height * 0.80,
                      child: Stack(
                        children: [
                          Center(
                            child: Container(
                              height: size.height * .75,
                              width: size.width * 0.9,
                              decoration: BoxDecoration(
                                color: secodary_black,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 40,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 15, right: 15, bottom: 5),
                                          child: Center(
                                            child: Text("Choose a topic",
                                                style: TextStyle(
                                                    color: Colors.yellow.shade800,
                                                    fontSize: 22,
                                                    fontFamily: "FontMain",
                                                    fontWeight: FontWeight.bold)),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                         Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Container(
                                                height: 50,
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
                                                    left: 10, right: 10),
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
                                                            "Something is malfunctioning",
                                                            style: TextStyle(
                                                                color: Colors.white,
                                                                fontSize: 12,
                                                                fontFamily:
                                                                "FontMain"),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        Get.toNamed("/appreport", arguments: [1]);

                                                      },
                                                      child: const Padding(
                                                        padding: EdgeInsets.only(
                                                            right: 20),
                                                        child: Icon(
                                                            FontAwesomeIcons
                                                                .chevronCircleRight,
                                                            color: Colors.white70,
                                                            size: 25),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(height: 15,),
                                              Container(
                                                height: 50,
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
                                                    left: 10, right: 10),
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
                                                            "App lacks a feature",
                                                            style: TextStyle(
                                                                color: Colors.white,
                                                                fontSize: 12,
                                                                fontFamily:
                                                                "FontMain"),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        Get.toNamed("/appreport", arguments: [2]);

                                                      },
                                                      child: const Padding(
                                                        padding: EdgeInsets.only(
                                                            right: 20),
                                                        child: Icon(
                                                            FontAwesomeIcons
                                                                .chevronCircleRight,
                                                            color: Colors.white70,
                                                            size: 25),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(height: 15,),
                                              Container(
                                                height: 50,
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
                                                    left: 10, right: 10),
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
                                                            "Clumsy Interface",
                                                            style: TextStyle(
                                                                color: Colors.white,
                                                                fontSize: 12,
                                                                fontFamily:
                                                                "FontMain"),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        Get.toNamed("/appreport", arguments: [3]);

                                                      },
                                                      child: const Padding(
                                                        padding: EdgeInsets.only(
                                                            right: 20),
                                                        child: Icon(
                                                            FontAwesomeIcons
                                                                .chevronCircleRight,
                                                            color: Colors.white70,
                                                            size: 25),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(height: 15,),
                                              Container(
                                                height: 50,
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
                                                    left: 10, right: 10),
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
                                                            "I would like to suggest an idea",
                                                            style: TextStyle(
                                                                color: Colors.white,
                                                                fontSize: 12,
                                                                fontFamily:
                                                                "FontMain"),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        Get.toNamed("/appreport", arguments: [4]);

                                                      },
                                                      child: const Padding(
                                                        padding: EdgeInsets.only(
                                                            right: 20),
                                                        child: Icon(
                                                            FontAwesomeIcons
                                                                .chevronCircleRight,
                                                            color: Colors.white70,
                                                            size: 25),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(height: 15,),
                                              Container(
                                                height: 50,
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
                                                    left: 10, right: 10),
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
                                                            "Others",
                                                            style: TextStyle(
                                                                color: Colors.white,
                                                                fontSize: 12,
                                                                fontFamily:
                                                                "FontMain"),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        Get.toNamed("/appreport", arguments: [5]);

                                                      },
                                                      child: const Padding(
                                                        padding: EdgeInsets.only(
                                                            right: 20),
                                                        child: Icon(
                                                            FontAwesomeIcons
                                                                .chevronCircleRight,
                                                            color: Colors.white70,
                                                            size: 25),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
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
                  ),

                ],
              ),
            ),
          ],
        ));
  }
}
