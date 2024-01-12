import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controller/HomeController.dart';
import '../../constants.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

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
          color: primary_black,
        ),
        // the App.build method, and use it to set our appbar title.
        title: Obx(
          () => Text(
            Get.find<HomeController>().TITLE.toString(),
            // textAlign: TextAlign.left,
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: size.height * 0.40,
            decoration: const BoxDecoration(
              color: Color(0xFFF8c102),
              borderRadius: BorderRadius.all(
                Radius.circular(25),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 100,
                ),
                Container(
                  margin: const EdgeInsets.all(30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome Back,",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Henok,",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "shivshekhar74@gmail,com",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      Stack(
                        children: [
                          SizedBox(
                            width: 80,
                            height: 80,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(80),
                              child: Image.network(
                                'https://oflutter.com/wp-content/uploads/2021/02/girl-profile.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(80),
                                  color: Colors.black),
                              child: const Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: size.height * 0.60,
              decoration: BoxDecoration(
                  color: Colors.grey.shade800,
                  borderRadius: BorderRadius.all(Radius.circular(25))),
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: GestureDetector(
                              onTap: () {
                                Get.toNamed("/BookingView",
                                    arguments: ['parameter1', 'parameter2']);
                              },
                              child: Container(
                                margin: const EdgeInsets.only(top: 1),
                                height: 43,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: primary_black.withOpacity(0.5),
                                    ),
                                    const BoxShadow(
                                      color: secodary_black,
                                      spreadRadius: -2.0,
                                      blurRadius: 1.0,
                                    ),
                                  ],
                                ),
                                child: const Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Icon(Icons.car_rental,color: Colors.yellow),
                                    ),
                                    Expanded(
                                      child: Text('Booking',
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 13)),
                                    ),
                                    Icon(Icons.chevron_right,
                                        color: Colors.white, size: 32),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: GestureDetector(
                              onTap: () {
                                Get.toNamed("/TrackingPage",
                                    arguments: ['parameter1', 'parameter2']);
                              },
                              child: Container(
                                margin: const EdgeInsets.only(top: 1),
                                height: 43,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: primary_black.withOpacity(0.5),
                                    ),
                                    const BoxShadow(
                                      color: secodary_black,
                                      spreadRadius: -2.0,
                                      blurRadius: 1.0,
                                    ),
                                  ],
                                ),
                                child: const Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Icon(Icons.spatial_tracking,color: Colors.yellow),
                                    ),
                                    Expanded(
                                      child: Text('Tracking',
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 13)),
                                    ),
                                    Icon(Icons.chevron_right,
                                        color: Colors.white, size: 32),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: GestureDetector(
                              onTap: () {
                                Get.toNamed("/Loyalty",
                                    arguments: ['parameter1', 'parameter2']);
                              },
                              child: Container(
                                margin: const EdgeInsets.only(top: 1),
                                height: 43,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: primary_black.withOpacity(0.5),
                                    ),
                                    const BoxShadow(
                                      color: secodary_black,
                                      spreadRadius: -2.0,
                                      blurRadius: 1.0,
                                    ),
                                  ],
                                ),
                                child: const Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Icon(Icons.loyalty_rounded,color: Colors.yellow),
                                    ),
                                    Expanded(
                                      child: Text('Loyalty',
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 13)),
                                    ),
                                    Icon(Icons.chevron_right,
                                        color: Colors.white, size: 32),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: GestureDetector(
                              onTap: () {
                                Get.toNamed("/WalletScreen",
                                    arguments: ['parameter1', 'parameter2']);
                              },
                              child: Container(
                                margin: const EdgeInsets.only(top: 1),
                                height: 43,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: primary_black.withOpacity(0.5),
                                    ),
                                    const BoxShadow(
                                      color: secodary_black,
                                      spreadRadius: -2.0,
                                      blurRadius: 1.0,
                                    ),
                                  ],
                                ),
                                child: const Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Icon(Icons.wallet_giftcard,color: Colors.yellow),
                                    ),
                                    Expanded(
                                      child: Text('Wallet',
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 13)),
                                    ),
                                    Icon(Icons.chevron_right,
                                        color: Colors.white, size: 32),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: GestureDetector(
                              onTap: () {
                                Get.toNamed("/LoginPage",
                                    arguments: ['parameter1', 'parameter2']);
                              },
                              child: Container(
                                margin: const EdgeInsets.only(top: 1),
                                height: 43,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: primary_black.withOpacity(0.5),
                                    ),
                                    const BoxShadow(
                                      color: secodary_black,
                                      spreadRadius: -2.0,
                                      blurRadius: 1.0,
                                    ),
                                  ],
                                ),
                                child: const Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Icon(Icons.person,color: Colors.yellow),
                                    ),
                                    Expanded(
                                      child: Text('Join us ',
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 13)),
                                    ),
                                    Icon(Icons.chevron_right,
                                        color: Colors.white, size: 32),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: GestureDetector(
                              onTap: () {
                                Get.toNamed("/ShareApp",
                                    arguments: ['parameter1', 'parameter2']);
                              },
                              child: Container(
                                margin: const EdgeInsets.only(top: 1),
                                height: 43,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: primary_black.withOpacity(0.5),
                                    ),
                                    const BoxShadow(
                                      color: secodary_black,
                                      spreadRadius: -2.0,
                                      blurRadius: 1.0,
                                    ),
                                  ],
                                ),
                                child: const Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Icon(Icons.share,color: Colors.yellow),
                                    ),
                                    Expanded(
                                      child: Text('Share App ',
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 13)),
                                    ),
                                    Icon(Icons.chevron_right,
                                        color: Colors.white, size: 32),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: GestureDetector(
                              onTap: () {
                                Get.toNamed("/Setting",
                                    arguments: ['parameter1', 'parameter2']);
                              },
                              child: Container(
                                margin: const EdgeInsets.only(top: 1),
                                height: 43,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: primary_black.withOpacity(0.5),
                                    ),
                                    const BoxShadow(
                                      color: secodary_black,
                                      spreadRadius: -2.0,
                                      blurRadius: 1.0,
                                    ),
                                  ],
                                ),
                                child: const Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Icon(Icons.settings,color: Colors.yellow),
                                    ),
                                    Expanded(
                                      child: Text('Setting',
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 13)),
                                    ),
                                    Icon(Icons.chevron_right,
                                        color: Colors.white, size: 32),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: GestureDetector(
                              onTap: () {
                                Get.toNamed("/printer",
                                    arguments: ['parameter1', 'parameter2']);
                              },
                              child: Container(
                                margin: const EdgeInsets.only(top: 1),
                                height: 43,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: primary_black.withOpacity(0.5),
                                    ),
                                    const BoxShadow(
                                      color: secodary_black,
                                      spreadRadius: -2.0,
                                      blurRadius: 1.0,
                                    ),
                                  ],
                                ),
                                child: const Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Icon(Icons.print,color: Colors.yellow),
                                    ),
                                    Expanded(
                                      child: Text('Attached Printer',
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 13)),
                                    ),
                                    Icon(Icons.chevron_right,
                                        color: Colors.white, size: 32),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: GestureDetector(
                              onTap: () {
                                Get.toNamed("/ContactUs",
                                    arguments: ['parameter1', 'parameter2']);
                              },
                              child: Container(
                                margin: const EdgeInsets.only(top: 1),
                                height: 43,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: primary_black.withOpacity(0.5),
                                    ),
                                    const BoxShadow(
                                      color: secodary_black,
                                      spreadRadius: -2.0,
                                      blurRadius: 1.0,
                                    ),
                                  ],
                                ),
                                child: const Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Icon(Icons.email,color: Colors.yellow),
                                    ),
                                    Expanded(
                                      child: Text('Contact Us',
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 13)),
                                    ),
                                    Icon(Icons.chevron_right,
                                        color: Colors.white, size: 32),
                                  ],
                                ),
                              ),
                            ),
                          ),

                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
