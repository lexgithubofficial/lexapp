
import 'package:flutter/material.dart';
import '../../constants.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

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
          "Wallet",
          textAlign: TextAlign.left,
          style: TextStyle(
            color: primary_black,
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
              padding: const EdgeInsets.only(top: 130),
              child: Container(
                height: size.height * 0.4,
                width: size.width * 0.9,
                decoration: BoxDecoration(
                  color: secodary_black,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  // mainAxisAlignment: ,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "CHF 123.00",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: yellow_box_color,
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Available Balance",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.white,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      // height: 65,
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
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 30,
                          horizontal: 10,
                        ),
                        child: Column(
                          children: [
                            Divider(
                              color: Colors.grey[600],
                              thickness: 1.1,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      height: 55,
                                      width: 65,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color: yellow_box_color
                                                .withOpacity(0.5),
                                          ),
                                          const BoxShadow(
                                            color: yellow_box_color,
                                            spreadRadius: -2.0,
                                            blurRadius: 2.0,
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                        child: Image.asset(
                                          "assets/images/w_top_up.png",
                                          height: 30,
                                          width: 30,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      "Top up",
                                      // textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: Colors.white,
                                        // fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Container(
                                      height: 55,
                                      width: 65,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color: yellow_box_color
                                                .withOpacity(0.5),
                                          ),
                                          const BoxShadow(
                                            color: yellow_box_color,
                                            spreadRadius: -2.0,
                                            blurRadius: 2.0,
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                        child: Image.asset(
                                          "assets/images/w_withdraw.png",
                                          height: 30,
                                          width: 30,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      "Withdraw",
                                      // textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: Colors.white,
                                        // fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Container(
                                      height: 55,
                                      width: 65,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color: yellow_box_color
                                                .withOpacity(0.5),
                                          ),
                                          const BoxShadow(
                                            color: yellow_box_color,
                                            spreadRadius: -2.0,
                                            blurRadius: 2.0,
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                        child: Image.asset(
                                          "assets/images/w_send.png",
                                          height: 30,
                                          width: 30,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      "Send",
                                      // textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: Colors.white,
                                        // fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Container(
                                      height: 55,
                                      width: 65,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color: yellow_box_color
                                                .withOpacity(0.5),
                                          ),
                                          const BoxShadow(
                                            color: yellow_box_color,
                                            spreadRadius: -2.0,
                                            blurRadius: 2.0,
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                        child: Image.asset(
                                          "assets/images/w_pay.png",
                                          height: 30,
                                          width: 30,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      "Pay",
                                      // textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: Colors.white,
                                        // fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
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
            child: SizedBox(
              height: size.height * 0.4,
              width: size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Transaction History",
                      // textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Today",
                            // textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 14,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: double.infinity,
                            height: 65,
                            decoration: BoxDecoration(
                              // color: secodary_black,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: secodary_black.withOpacity(0.5),
                                ),
                                BoxShadow(
                                  color: secodary_black.withOpacity(0.1),
                                  spreadRadius: -2.0,
                                  blurRadius: 2.0,
                                ),
                              ],
                              // border: Border.a
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        "CHF 12.23",
                                        // textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "Just Now",
                                        // textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          // fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  Text(
                                    "+17 CHF",
                                    // textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: yellow_box_color,
                                      fontSize: 16,
                                      // fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: double.infinity,
                            height: 65,
                            decoration: BoxDecoration(
                              // color: secodary_black,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: secodary_black.withOpacity(0.5),
                                ),
                                BoxShadow(
                                  color: secodary_black.withOpacity(0.1),
                                  spreadRadius: -2.0,
                                  blurRadius: 2.0,
                                ),
                              ],
                              // border: Border.a
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        "CHF 12.23",
                                        // textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "Just Now",
                                        // textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          // fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  Text(
                                    "-15 CHF",
                                    // textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 16,
                                      // fontWeight: FontWeight.bold,
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
            ),
          ),
        ],
      ),
    );
  }
}
