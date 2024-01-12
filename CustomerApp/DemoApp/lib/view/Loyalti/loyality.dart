import 'package:flutter/material.dart';

import '../../constants.dart';

class loyality extends StatelessWidget {
  const loyality({super.key});

  Widget cardListWidget(size, context,
      {required double max, required double min, required double value}) {
    return Container(
      width: size.width,
      // height: 55,
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
      child: Row(
        children: [
          const SizedBox(
            width: 10,
          ),
          Image.asset(
            'assets/images/loyal_card.png',
            height: 35,
            width: 35,
          ),
          Expanded(
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                // trackHeight: 0,
                // thumbColor: Colors.transparent,
                trackHeight: 7,

                thumbShape: SliderComponentShape.noThumb,
              ),
              child: Slider(
                value: value,
                max: max,
                min: min,
                divisions: 200,
                thumbColor: Colors.transparent,
                label: "",
                activeColor: yellow_box_color,
                inactiveColor: Colors.grey[600],
                onChanged: (double value) {
                  // setState(() {
                  // Get.find<RidesController>().slierCount.value =
                  //     value;
                  // });
                },
              ),
            ),
          ),
          SizedBox(
            width: 55,
            child: Align(
              alignment: Alignment.topRight,
              child: Text(
                "${value.round()}/${max.round()}",
                textAlign: TextAlign.left,
                style: const TextStyle(
                  color: Colors.white,
                    fontFamily: "FontMain",
                   fontSize: 10,
                  // fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
    );
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
          "Loyalty",
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
            height: size.height * 0.4,
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
              padding: const EdgeInsets.only(top: 130),
              child: IntrinsicHeight(
                child: Container(
                   height: size.height * 87,
                  width: size.width * 0.9,
                  decoration: BoxDecoration(
                    color: secodary_black,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      // mainAxisAlignment: ,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Hi Halen!",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontFamily: "FontMain",
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Available Balance",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                      fontFamily: "FontMain"
                                    // fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "Points Earned",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                      fontFamily: "FontMain",
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "202",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Image.asset(
                              'assets/images/loyalty_start.png',
                              height: 35,
                              width: 35,
                            ),
                            // LinearProgressIndicator(value: 100,)
                            Expanded(
                              child: Column(
                                children: [
                                  SliderTheme(
                                    data: SliderTheme.of(context).copyWith(
                                      // trackHeight: 0,
                                      // thumbColor: Colors.transparent,
                                      trackHeight: 7,

                                      thumbShape: SliderComponentShape.noThumb,
                                    ),
                                    child: Slider(
                                      value: 60,
                                      max: 200,
                                      min: 20,
                                      divisions: 200,
                                      thumbColor: Colors.transparent,
                                      label: "",
                                      activeColor: yellow_box_color,
                                      inactiveColor: Colors.grey[600],
                                      onChanged: (double value) {
                                        // setState(() {
                                        // Get.find<RidesController>().slierCount.value =
                                        //     value;
                                        // });
                                      },
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 25,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "55/200",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          "Points Earned",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: yellow_box_color,
                                              fontFamily: "FontMain"
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
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                // height: 65,
                                // width: size.width * 0.4,
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
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 15,
                                    horizontal: 8,
                                  ),
                                  child: Column(
                                    children: [
                                      Center(
                                        child: Text(
                                          "Total Points Earned",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: yellow_box_color,
                                              fontFamily: "FontMain",
                                            fontSize: 12

                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        "212",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: yellow_box_color,
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Container(
                                // height: 65,
                                // width: size.width * 0.4,
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
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 15,
                                    horizontal: 8,
                                  ),
                                  child: Column(
                                    children: [
                                      Text(
                                        "Total Points Spent",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: yellow_box_color,
                                            fontFamily: "FontMain",
                                            fontSize: 12
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        "120",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: yellow_box_color,
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 100,
                          width: size.width,
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  width: size.width,
                                  height: 90,
                                  decoration: BoxDecoration(
                                    color: yellow_box_color,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          "Tap to see awards !",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontFamily: "FontMain",
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 200,
                                          child: Text(
                                            "You are 500 points away to get platinum Plan Card",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              color: Colors.black87,
                                                fontFamily: "FontMain",
                                                fontSize: 12
                                              // fontSize: 22,
                                              // fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: Image.asset(
                                  'assets/images/loyal_gift.png',
                                  height: 90,
                                  width: 90,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        cardListWidget(
                          size,
                          context,
                          min: 0,
                          max: 800,
                          value: 500,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        cardListWidget(
                          size,
                          context,
                          min: 0,
                          max: 800,
                          value: 200,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        cardListWidget(
                          size,
                          context,
                          min: 0,
                          max: 100,
                          value: 10,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
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
