import 'dart:convert';

import 'package:demoapp/constants.dart';
import 'package:demoapp/view/DynamicallyBids/BidingListController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

class BidingList extends StatefulWidget {
  const BidingList({Key? key}) : super(key: key);

  @override
  State<BidingList> createState() => _BidingList();
}

class _BidingList extends State<BidingList> {
  final BidingListController BidingListControllerobj =
      Get.put(BidingListController());
  var channel =
      WebSocketChannel.connect(Uri.parse('wss://ridewithlex.com:7070'));

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    channel.sink.close(status.goingAway);
    BidingListControllerobj.items.clear();
    BidingListControllerobj.bid_idDATA.clear();
    BidingListControllerobj.previous_booking_idData.clear();

  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: primary_black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: primary_black,
        ),
        // the App.build method, and use it to set our appbar title.
        title: const Text(
          "Biding List",
          textAlign: TextAlign.left,
          style: TextStyle(
              color: primary_black,
              fontFamily: "FontMain",
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: size.height * 0.5,
            decoration: const BoxDecoration(
              color: yellow_box_color,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Container(
                height: size.height * 0.6,
                width: size.width * 0.9,
                decoration: BoxDecoration(
                  color: secodary_black,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Obx(() {
                  return BidingListControllerobj.items.isEmpty
                      ? const Center(child: CircularProgressIndicator())
                      : ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: BidingListControllerobj.items.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              // mainAxisAlignment: ,
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  height: 65,
                                  width: size.width * 0.8,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: primary_black.withOpacity(0.5),
                                      ),
                                      const BoxShadow(
                                        color: secodary_black,
                                        spreadRadius: -2.0,
                                        blurRadius: 2.0,
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8,
                                              vertical: 0,
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 10),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                      height: 65,
                                                      decoration: BoxDecoration(
                                                        // color: secodary_black,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: secodary_black
                                                                .withOpacity(
                                                                    0.5),
                                                          ),
                                                          BoxShadow(
                                                            color: secodary_black
                                                                .withOpacity(
                                                                    0.1),
                                                            spreadRadius: -2.0,
                                                            blurRadius: 2.0,
                                                          ),
                                                        ],
                                                        // border: Border.a
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Row(
                                                          children: [
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              children: [
                                                                const Text(
                                                                  "Bid Request From Driver",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white54,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontSize:
                                                                          14),
                                                                ),
                                                                Text("Bid "+ BidingListControllerobj.items[index],
                                                                  style:
                                                                      const TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontFamily:
                                                                        "FontMain",
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            const Spacer(),
                                                            TextButton(

                                                                style: ButtonStyle(

                                                                  foregroundColor: MaterialStateProperty.all<
                                                                          Color>(
                                                                      Colors
                                                                          .yellow
                                                                          .shade400),
                                                                  overlayColor:
                                                                      MaterialStateProperty
                                                                          .resolveWith<
                                                                              Color?>(
                                                                    (Set<MaterialState>
                                                                        states) {
                                                                      if (states
                                                                          .contains(
                                                                              MaterialState.hovered)) {
                                                                        return Colors
                                                                            .yellow
                                                                            .withOpacity(0.04);
                                                                      }
                                                                      if (states.contains(MaterialState
                                                                              .focused) ||
                                                                          states
                                                                              .contains(MaterialState.pressed)) {
                                                                        return Colors
                                                                            .yellow
                                                                            .withOpacity(0.12);
                                                                      }
                                                                      return null; // Defer to the widget's default.
                                                                    },
                                                                  ),
                                                                ),

                                                                onPressed: () {
                                                                  var bid = BidingListControllerobj.bid_idDATA[index].toString().trim();
                                                                  print("${bid}jfjjfjf");
                                                                  var jsonString = {
                                                                    "request": "driverBidBookingAccepted",
                                                                    "data": {"bid_id": bid}};
                                                                  String convertedJsonStr = json.encode(jsonString);
                                                                  channel.sink.add(convertedJsonStr);
                                                                  channel.stream.listen((message) {
                                                                    confirm(message

                                                                    );
                                                                  });
                                                                },
                                                                child: Text(
                                                                  "ACCEPT",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .yellow.shade800,
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontFamily:
                                                                          "FontMain"),
                                                                )),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                }),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: size.height * 0.4),
            child: Align(
              alignment: Alignment.center,
              child: MaterialButton(
                color: const Color(0xFFf8c102),
                height: 45,
                minWidth: size.width * 0.5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                onPressed: () {
                  print("fffrfrt${BidingListControllerobj.previous_booking_idData.toString()}");
                  var jsonString = {
                    "request": "requestBookingCancelled",
                    "data": {"prev_booking_id": BidingListControllerobj.previous_booking_idData[0].toString()}
                  };
                  String convertedJsonStr =
                  json.encode(jsonString);
                  final wsUrl =
                  Uri.parse('wss://ridewithlex.com:7070');
                  var channel =
                  WebSocketChannel.connect(wsUrl);
                  channel = WebSocketChannel.connect(wsUrl);
                  channel.sink.add(convertedJsonStr);
                  channel.stream.listen((message) {
                    var jsonResponse = json.decode(message);
                    var response = jsonResponse['response'].toString().trim();
                    if (response == "requestBookingCancelled_resp") {
                      BidingListControllerobj.previous_booking_idData.clear();
                      BidingListControllerobj.bid_idDATA.clear();
                      BidingListControllerobj.items.clear();
                      Navigator.of(context) .pushNamedAndRemoveUntil("/navmain", (route) => false);
                    }
                  });



                },
                child: const Text(
                  "Cancel",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: "FontMain",
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void confirm(var message) {
    var jsonResponse = json.decode(message);
    var response = jsonResponse['response'].toString().trim();
    var data = jsonResponse['data'];
    if (data != null && data.toString().isNotEmpty && data.toString() != "[]") {
      if (response == "driverBidBookingAccepted_resp") {
        BidingListControllerobj.previous_booking_idData.clear();
        BidingListControllerobj.bid_idDATA.clear();
        BidingListControllerobj.items.clear();
        Get.toNamed("/ConfirmTripStart", arguments: {
          'data': jsonResponse['data'],
        });
      }
    }
  }
}
