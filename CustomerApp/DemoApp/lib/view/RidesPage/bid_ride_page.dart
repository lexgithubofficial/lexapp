import 'package:demoapp/Controller/RidesController.dart';
import 'package:demoapp/view/ConfirmPickup/ConfirmPickupController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants.dart';

class BidARidesPage extends StatelessWidget {
  const BidARidesPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final RidesController RidesController_obj = Get.put(RidesController());
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
          "Bid and Ride",

          textAlign: TextAlign.left,
          style: TextStyle(
            color: primary_black,
              fontWeight: FontWeight.bold,
              fontFamily: "FontMain"
          ),
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
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(top: (size.height * 0.5) / 4),
                child: IntrinsicWidth(
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: secodary_black, width: 8),
                      boxShadow: [
                        BoxShadow(color: yellow_box_color.withOpacity(0.5)),
                        const BoxShadow(
                          color: yellow_box_color,
                          spreadRadius: -2.0,
                          blurRadius: 2.0,
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        child: Text(
                          "Bid and Ride",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: primary_black,
                            fontSize: 14,
                            fontFamily: "FontMain",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 50),
              child: SizedBox(
                height: size.height * 0.65,
                width: size.width * 0.9,
                child: Stack(
                  children: [
                    Center(
                      child: Container(
                        height: size.height * 0.6,
                        width: size.width * 0.9,
                        decoration: BoxDecoration(
                          color: secodary_black,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Column(
                              children: [
                                Text(
                                  "Ride Fare",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontFamily: "FontMain",
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "Find your ride faster\nLower or raise the price",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontFamily: "FontMain",
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            // Sized
                            // const Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if (Get.find<RidesController>().slierCount.value > 6) {
                                      Get.find<RidesController>().slierCount.value--;
                                    }
                                  },
                                  child: Container(
                                    width: 45,
                                    height: 45,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Icon(
                                      Icons.remove,
                                      color: primary_black,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Obx(() {
                                  return Text(
                                    Get.find<RidesController>().slierCount.value.toInt().round().toString(),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: yellow_box_color,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                }),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(bottom: 5),
                                  child: Text(
                                    "CHF",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: yellow_box_color,
                                      fontSize: 14,
                                        fontFamily: "FontMain",
                                      // fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (Get.find<RidesController>().slierCount.value < 500) {
                                      Get.find<RidesController>().slierCount.value++;
                                    }
                                  },
                                  child: Container(
                                    width: 45,
                                    height: 45,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Icon(
                                      Icons.add,
                                      color: primary_black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // const SizedBox(
                            //   height: 15,
                            // ),
                            const Text(
                              "Select your fare",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                  fontFamily: "FontMain"
                                // fontWeight: FontWeight.bold,
                              ),
                            ),
                            Obx(() {
                              return Slider(
                                value: Get.find<RidesController>()
                                    .slierCount
                                    .value,
                                max: 1000,
                                min: 6,
                                divisions: 200,
                                thumbColor: yellow_box_color,
                                label: Get.find<RidesController>()
                                    .slierCount
                                    .value
                                    .round()
                                    .toString(),
                                activeColor: yellow_box_color,
                                inactiveColor: Colors.grey[600],
                                onChanged: (double value) {
                                  // setState(() {
                                  Get.find<RidesController>().slierCount.value =
                                      value;
                                  // });
                                },
                              );
                            }),
                            const SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: MaterialButton(
                        color: yellow_box_color,
                        height: 45,
                        minWidth: size.width * 0.5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        onPressed: () {
                          final ConfirmPickupController ConfirmPickupControllerobj = Get.put(ConfirmPickupController());
                          ConfirmPickupControllerobj.allData();
                          ConfirmPickupControllerobj.price = Get.find<RidesController>().slierCount.value.toInt().round().toString();
                          print("hhhhhh"+Get.find<RidesController>().slierCount.value.toString());
                          Get.toNamed("/ConfirmPickup", arguments: ['parameter2']);
                        },
                        child: const Text(
                          "NEXT",
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
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
