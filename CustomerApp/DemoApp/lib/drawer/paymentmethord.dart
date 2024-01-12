import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants.dart';

class paymentmethord extends StatefulWidget {
  const paymentmethord({super.key});

  @override
  _SendFeedbackPageState createState() => _SendFeedbackPageState();
}

class _SendFeedbackPageState extends State<paymentmethord> {
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
          "Payment Methods",
          textAlign: TextAlign.left,
          style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: "FontMain"),
        ),
      ),
      body: Container(
        color: Colors.black87,
        child: Stack(
          children: [
            Container(
              height: size.height * 0.40,
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
                child: SizedBox(
                  height: size.height * 0.75,
                  width: size.width * 0.9,
                  child: Stack(
                    children: [
                      Center(
                        child: Container(
                          height: size.height * 0.70,
                          width: size.width * 0.9,
                          decoration: BoxDecoration(
                            color: secodary_black,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(35),
                            child: Column(
                              children: [
                                const Text(
                                  "CHF 123.00",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Colors.amber,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "FontMain"),
                                ),
                                const Text(
                                  "Available Balance",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                      fontFamily: "FontMain"),
                                ),

                                const SizedBox(
                                  height: 20,
                                ),
                                const Text(
                                  "Pay your fare",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "FontMain"),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width: size.width, height: 55,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
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
                                        width: 20,
                                      ),
                                      Image.asset(
                                        'assets/images/visa.png',
                                        height: 35,
                                        width: 35,
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      const Expanded(
                                        child: Text("************76",style: TextStyle(color: Colors.white),),
                                      ),

                                      const SizedBox(
                                        child: Align(
                                          alignment: Alignment.topRight,
                                          child: Center(
                                            child: Icon(
                                              Icons
                                                  .chevron_right_rounded,
                                              color: Colors.white,
                                              size: 40,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width: size.width, height: 55,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
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
                                  child: const Row(
                                    children: [
                                      SizedBox(
                                        width: 20,
                                      ),
                                        Icon(
                                        Icons
                                            .add,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Expanded(
                                        child: Text("Add Payment Methods",style: TextStyle(color: Colors.white),),
                                      ),

                                      SizedBox(
                                        child: Align(
                                          alignment: Alignment.topRight,
                                          child: Center(
                                            child: Icon(
                                              Icons
                                                  .chevron_right_rounded,
                                              color: Colors.white,
                                              size: 40,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Expanded(
                                      flex: 2,
                                      child: Text("Promo Code",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "FontMain"),
                                      ),
                                    ),
                                    Expanded(
                                      child:  MaterialButton(
                                        color: yellow_box_color,
                                        height: 25,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        onPressed: () {},
                                        child: const Text(
                                          "See More",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 11,
                                              fontFamily: "FontMain"
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(
                                  height: 15,
                                ),

                                Container(
                                  width: size.width, height: 55,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
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
                                  child: GestureDetector(
                                    onTap: () {

                                      Get.toNamed("/promodcode", arguments: ['parameter1', 'parameter2']);
                                    },
                                    child: const Row(
                                      children: [
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Icon(
                                          Icons
                                              .add,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Expanded(
                                          child: Text("Add Promo Code",style: TextStyle(color: Colors.white),),
                                        ),

                                        SizedBox(
                                          child: Align(
                                            alignment: Alignment.topRight,
                                            child: Center(
                                              child: Icon(
                                                Icons
                                                    .chevron_right_rounded,
                                                color: Colors.white,
                                                size: 40,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
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
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: MaterialButton(
                          color: yellow_box_color,
                          height: 45,
                          minWidth: size.width * 0.5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          onPressed: () {},
                          child: const Text(
                            "PAY",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                                fontFamily: "FontMain"
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
      ),
    );
  }
}
