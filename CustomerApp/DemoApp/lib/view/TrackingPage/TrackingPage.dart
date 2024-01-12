
import 'package:demoapp/Getx/api/ApiConstants.dart';
import 'package:demoapp/constants.dart';
import 'package:demoapp/view/TrackingPage/TrackingController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TrackingPage extends StatefulWidget {
  const TrackingPage({Key? key}) : super(key: key);

  @override
  State<TrackingPage> createState() => _TrackingPageState();
}

class _TrackingPageState extends State<TrackingPage> {
  @override
  void initState() {
    super.initState();
    final TrackingController TrackingControllerobj = Get.put(TrackingController());
    TrackingControllerobj.fetchData();

  }


  final orderId = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final TrackingController TrackingControllerobj = Get.put(TrackingController());

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
          "Track Order",
          textAlign: TextAlign.left,
          style: TextStyle(
            color: primary_black,
              fontFamily: "FontMain",
            fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: size.height * 0.35,
            decoration: const BoxDecoration(
              color: yellow_box_color,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(top: size.height * 0.04),
              child: SizedBox(
                // height: size.height * 0.82,
                // width: size.width * 0.9,
                child: ListView(
                  children: [
                    SizedBox(
                      height: size.height * 0.4,
                      // width: size.width * 0.9,
                      child: Stack(
                        children: [
                          Center(
                            child: Container(
                              height: size.height * 0.35,
                              width: size.width * 0.9,
                              decoration: BoxDecoration(
                                color: secodary_black,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Padding(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 30),
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        const Center(
                                          child: Text(
                                            "Track Your Order",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 22,
                                              fontFamily: "FontMain",
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        const Text(
                                          "Enter order number",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontFamily: "FontMain",
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(20),
                                            boxShadow: [
                                              BoxShadow(
                                                color: primary_black
                                                    .withOpacity(0.5),
                                              ),
                                              const BoxShadow(
                                                color: secodary_black,
                                                spreadRadius: -2.0,
                                                blurRadius: 2.0,
                                              ),
                                            ],
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 10,
                                            ),
                                            child: TextFormField(
                                              style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.white,
                                              ),
                                              keyboardType: TextInputType.number,
                                              controller: orderId,
                                              decoration: const InputDecoration(
                                                border: InputBorder.none,
                                                hintText: "Enter Your Order Number",
                                                hintStyle: TextStyle(
                                                  color: Colors.white38,
                                                  fontFamily: "FontMain",
                                                  fontSize: 13,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                  ],
                                ),
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
                                String orderIdp = orderId.text.toString().trim();
                                TrackingControllerobj.orderSearch(orderIdp);

                              },
                              child: const Text(
                                "Track",
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
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        height: size.height * 0.42,
                        width: size.width,
                        child: Obx(() {
                          return TrackingControllerobj.isLoading.value
                              ? const Center(child: CircularProgressIndicator())
                              : TrackingControllerobj.count==0
                              ? const Center(
                              child: Column(
                                children: [
                                ],
                              ))
                              : Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Tracking History",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontFamily: "FontMain",
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 0,
                                    ),

                                    child: ListView.builder(
                                      physics:
                                      const AlwaysScrollableScrollPhysics(),
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      itemCount: TrackingControllerobj.TrackingHistoryModel.data?.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        return Padding(
                                          padding:
                                          const EdgeInsets.only(bottom: 10),
                                          child: Row(
                                            children: [
                                              Container(
                                                height: 65,
                                                width: 65,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(10),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: secodary_black
                                                          .withOpacity(0.5),
                                                    ),
                                                    BoxShadow(
                                                      color: secodary_black
                                                          .withOpacity(0.1),
                                                      spreadRadius: -2.0,
                                                      blurRadius: 2.0,
                                                    ),
                                                  ],
                                                ),
                                                child:  Center(
                                                  child: CircleAvatar(
                                                    radius: 22.0,
                                                    backgroundImage: NetworkImage(
                                                        ApiConstants.imgviewbasepath+TrackingControllerobj.TrackingHistoryModel.data![index].profileImage.toString(),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: Container(
                                                  height: 65,
                                                  decoration: BoxDecoration(
                                                    // color: secodary_black,
                                                    borderRadius:
                                                    BorderRadius.circular(10),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: secodary_black
                                                            .withOpacity(0.5),
                                                      ),
                                                      BoxShadow(
                                                        color: secodary_black
                                                            .withOpacity(0.1),
                                                        spreadRadius: -2.0,
                                                        blurRadius: 2.0,
                                                      ),
                                                    ],
                                                    // border: Border.a
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                    const EdgeInsets.all(8.0),
                                                    child: Row(
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                          children:  [
                                                            Text(
                                                              "FAH${TrackingControllerobj.TrackingHistoryModel.data?[index].previousBookingId}",
                                                              style: const TextStyle(
                                                                color:
                                                                Colors.white,
                                                                fontSize: 12,
                                                                fontWeight:
                                                                FontWeight
                                                                    .bold,
                                                                fontFamily: "FontMain",
                                                              ),
                                                            ),
                                                            const Text(
                                                             "Order in search",
                                                              // textAlign: TextAlign.left,
                                                              style: TextStyle(
                                                                color:
                                                                Colors.white,
                                                                fontSize: 11,
                                                                fontFamily: "FontMain",
                                                                // fontWeight: FontWeight.bold,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        const Spacer(),
                                                        const Icon(
                                                          Icons.chevron_right_rounded,
                                                          color: Colors.white,
                                                          size: 40,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
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
