import 'dart:convert';
import 'package:demoapp/Getx/api/NavigationService.dart';
import 'package:demoapp/view/DynamicallyBids/BidingListController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:slider_button/slider_button.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

class FindDriver extends StatefulWidget {
  const FindDriver({super.key});

  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<FindDriver> {
  bool oneTimeView = false;
  var channel = WebSocketChannel.connect(Uri.parse('wss://ridewithlex.com:7070'));

  @override
  void initState() {
    super.initState();

    // channel.stream.
    channel.stream.listen((message) {
      var jsonResponse = json.decode(message);
      var response = jsonResponse['response'].toString().trim();

      if (response == "requestBookingAccepted_resp") {
        Get.toNamed("/ConfirmTripStart", arguments: {
          'data': jsonResponse['data'],
        });
      }
      if (response == "driverBidBookingRequest_resp") {
        var data = jsonResponse['data'];
        if (data != null && data.toString().isNotEmpty && data.toString() != "[]") {
          if (oneTimeView == false) {
            oneTimeView = true;
            print("dgdgg");

            Get.toNamed("/BidingList", arguments: {
              'data': jsonResponse['data'],
            });
          } else {
            if (data != "") {
              final BidingListController BidingListControllerobj =
              Get.put(BidingListController());
              var bid_amount = data["bid_amount"].toString();
              BidingListControllerobj.items.addAll([bid_amount]);
              var bid_id = data["bid_id"].toString();
              BidingListControllerobj.bid_idDATA.addAll([bid_id]);
              print("gggggg");


            }
          }
        }
      }
    });
  }

  void alert(var data) {
    print("dataserver" + data.toString());
    if (data.toString() != "[]") {
      var BidAmmount = data['bid_amount'].toString();
      var bid_id = data['bid_id'].toString();
      print("bid_id" + bid_id);
      var previous_booking_id = data['previous_booking_id'].toString();
      if (oneTimeView == false) {
        print("tttime" + false.toString());
        oneTimeView = true;
        Get.dialog(
          barrierDismissible: false,
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Material(
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          const Text(
                            "Bid Request From Driver",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(0xff222b38),
                                fontWeight: FontWeight.w500,
                                fontSize: 17),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            "CHF $BidAmmount",
                            textAlign: TextAlign.center,
                          ),
                          const Text(
                            "Are you sure want to accept ",
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),
                          //Buttons
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: const Size(0, 45),
                                    primary: Colors.amber,
                                    onPrimary: const Color(0xFFFFFFFF),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.of(NavigationService
                                            .navigatorKey.currentContext!)
                                        .pop();
                                    oneTimeView = false;

                                    var jsonString = {
                                      "request": "driverBidBookingRejected",
                                      "data": {"bid_id": bid_id}
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
                                      var response = jsonResponse['response']
                                          .toString()
                                          .trim();
                                      if (response ==
                                          "driverBidBookingRequest_resp") {
                                        validationAlert(
                                            " Bid Has Been Rejected");
                                      }
                                    });
                                  },
                                  child: const Text(
                                    'NO',
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: const Size(0, 45),
                                    primary: Colors.amber,
                                    onPrimary: const Color(0xFFFFFFFF),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  onPressed: () {
                                    var jsonString = {
                                      "request": "driverBidBookingAccepted",
                                      "data": {"bid_id": bid_id}
                                    };
                                    String convertedJsonStr =
                                        json.encode(jsonString);

                                    final wsUrl =
                                        Uri.parse('wss://ridewithlex.com:7070');
                                    var channel =
                                        WebSocketChannel.connect(wsUrl);
                                    channel = WebSocketChannel.connect(wsUrl);
                                    channel.sink.add(convertedJsonStr);
                                    channel.stream.listen((message) {});
                                    Navigator.of(NavigationService
                                            .navigatorKey.currentContext!)
                                        .pop();
                                  },
                                  child: const Text(
                                    'YES',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    channel.sink.close(status.goingAway);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        body: Stack(
          children: [
            // Background Image
            Image.asset(
              'assets/images/serchingback.png',
              // Replace with the path to your image
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              color: const Color(0xFFfaf7e9),
            ),

            // Centered Column for Button and Text
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 80),
                  child: const Text(
                    "Searching...",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        fontFamily: "FontMain"),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: const Text(
                    "It will take some time",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: "FontMain"),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    margin: const EdgeInsets.only(top: 40),
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/driverOnline.gif"),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    height: 40,
                    child: Center(
                      child: SliderButton(
                        action: () {
                          Navigator.of(NavigationService
                                  .navigatorKey.currentContext!)
                              .pop();
                          oneTimeView = true;

                          ///Do something here
                          ///
                          Navigator.of(NavigationService
                                  .navigatorKey.currentContext!)
                              .pop();
                        },
                        label: const Text(
                          "Slide to cancel ",
                          style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                              fontFamily: "FontMain",
                              fontSize: 15),
                        ),
                        icon: const Text(
                          "x",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ));
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
