import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'RidesController.dart';
import '../../constants.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _Home();
}


class _Home extends State<Home> {
  Future<bool> _onPop() async {
    return false;
  }


  @override
  void initState() {
    super.initState();
    final RidesController RidesControllerobj = Get.put(RidesController());
    RidesControllerobj.fetchData(0);

  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final RidesController RidesControllerobj = Get.put(RidesController());
    return WillPopScope(
        onWillPop: _onPop,
        child:Stack(
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
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
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
                              color: Colors.black.withOpacity(0.5),
                            ),
                            const BoxShadow(
                              color: Colors.black,
                              spreadRadius: -2.0,
                              blurRadius: 2.0,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Obx(() {
                            return Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.find<RidesController>().changeTile(0);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Get.find<RidesController>()
                                                .selectedTile
                                                .value ==
                                                0
                                                ? yellow_box_color
                                                .withOpacity(0.5)
                                                : Colors.transparent,
                                          ),
                                          BoxShadow(
                                            color: Get.find<RidesController>()
                                                .selectedTile
                                                .value ==
                                                0
                                                ? yellow_box_color
                                                : Colors.transparent,
                                            spreadRadius: -2.0,
                                            blurRadius: 2.0,
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Today's Tasks",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontFamily: "FontMain",
                                            color: Get.find<RidesController>()
                                                .selectedTile
                                                .value ==
                                                0
                                                ? Colors.black
                                                : grey_textColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.find<RidesController>().changeTile(1);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Get.find<RidesController>()
                                                .selectedTile
                                                .value ==
                                                1
                                                ? yellow_box_color
                                                .withOpacity(0.5)
                                                : Colors.transparent,
                                          ),
                                          BoxShadow(
                                            color: Get.find<RidesController>()
                                                .selectedTile
                                                .value ==
                                                1
                                                ? yellow_box_color
                                                : Colors.transparent,
                                            spreadRadius: -2.0,
                                            blurRadius: 2.0,
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                        child: Text(
                                          "All Tasks",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontFamily: "FontMain",
                                            color: Get.find<RidesController>()
                                                .selectedTile
                                                .value ==
                                                1
                                                ? Colors.black
                                                : grey_textColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Obx(() {
                          return RidesControllerobj.isLoading.value
                              ? const Center(child: CircularProgressIndicator())
                              : RidesControllerobj.dataSize == 0
                              ? Center(
                              child: Column(
                                children: [
                                  Image.asset(
                                    "assets/images/todaytask.png",
                                    height: 300,
                                  ),
                                ],
                              ))
                              : SizedBox(
                            height: 320,
                            child: ListView.builder(
                              physics:
                              const AlwaysScrollableScrollPhysics(),
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              itemCount: RidesControllerobj
                                  .allTaskModel.data.length,
                              itemBuilder:
                                  (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 10, left: 10),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              height: 25,
                                              width: 25,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Color(0xffFFFFFF),
                                                border: Border.all(
                                                  color: Color(0xffDBDBDB),
                                                  width: 1,
                                                ),
                                              ),
                                              child:  Center(
                                                child: Text((index+1).toString()),
                                              ),
                                            ),
                                          ),
                                          const Text(
                                            "Pickup location     ",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: "FontMain",
                                            ),
                                          ),
                                          Flexible(
                                            child: Text(
                                              RidesControllerobj
                                                  .allTaskModel
                                                  .data[index]
                                                  .pickupLocation,
                                              textAlign: TextAlign.start,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 13,
                                                fontFamily: "FontMain",
                                                // fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),

                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(left: 40),
                                            child: Text(

                                              "Drop location         ",
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: "FontMain",
                                              ),
                                            ),
                                          ),
                                          Flexible(
                                            child: Text(
                                              RidesControllerobj
                                                  .allTaskModel
                                                  .data[index]
                                                  .dropLocation,
                                              textAlign: TextAlign.start,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 13,
                                                fontFamily: "FontMain",
                                                // fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),

                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(left: 40),
                                            child: Text(
                                              "Bid",
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: "FontMain",
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 100),
                                            child: Text(
                                              "${RidesControllerobj
                                                  .allTaskModel
                                                  .data[index]
                                                  .bid} CHF",
                                              textAlign: TextAlign.start,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 13,
                                                fontFamily: "FontMain",
                                                // fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),

                                        ],
                                      ),

                                    ],
                                  ),
                                );
                              },
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));

  }
}
