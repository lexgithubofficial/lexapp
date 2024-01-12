
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../constants.dart';
import 'AccountController.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AccountController controller = Get.put(AccountController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: orange_box_backgound_color,
      ),
      body: Stack(
        children: [
          Container(
            color: Colors.black,
          ),
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.width * .60,
            decoration: const BoxDecoration(
                color: Color(0xFFF8c102),
                borderRadius: BorderRadius.all(Radius.circular(25))),
            child: Column(
              children: [
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
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Henok,",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "shivshekhar74@gmail,com",
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                        ],
                      ),
                      Stack(
                        children: [
                          SizedBox(
                            width: 100,
                            height: 100,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(80),
                                child: Image.network(
                                  'https://oflutter.com/wp-content/uploads/2021/02/girl-profile.png',
                                  fit: BoxFit.cover,
                                  width: 90,
                                  height: 90,
                                )),
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
          Positioned(
            top: MediaQuery.of(context).size.width * .40,
            left: 15,
            right: 15,
            bottom: 20,
            child: Container(
              width: MediaQuery.of(context).size.width * 1,
              decoration: BoxDecoration(
                  color: Colors.grey.shade800,
                  borderRadius: BorderRadius.all(Radius.circular(25))),
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.toNamed("/BookingPage",
                                  arguments: ['parameter1', 'parameter2']);
                            },
                            child: Container(
                              height: 45,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(Icons.car_rental,
                                        color: Colors.yellow, size: 30),
                                  ),
                                  Expanded(
                                    child: const Text('Booking',
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 13)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(Icons.chevron_right,
                                        color: Colors.white, size: 32),
                                  ),
                                ],
                              ),
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.shade700,
                                        spreadRadius: 1,
                                        blurRadius: 5)
                                  ],
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                      width: 2, color: Colors.grey.shade800)),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 15),
                            height: 45,
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(Icons.spatial_tracking,
                                      color: Colors.yellow, size: 32),
                                ),
                                Expanded(
                                  child: const Text('Tracking',
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 13)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(Icons.chevron_right,
                                      color: Colors.white, size: 32),
                                ),
                              ],
                            ),
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.shade700,
                                      spreadRadius: 1,
                                      blurRadius: 5)
                                ],
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    width: 2, color: Colors.grey.shade800)),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 15),
                            height: 45,
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(Icons.loyalty_rounded,
                                      color: Colors.yellow, size: 30),
                                ),
                                Expanded(
                                  child: const Text('Loyalty',
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 13)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(Icons.chevron_right,
                                      color: Colors.white, size: 32),
                                ),
                              ],
                            ),
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.shade700,
                                      spreadRadius: 1,
                                      blurRadius: 5)
                                ],
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    width: 2, color: Colors.grey.shade800)),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 15),
                            height: 45,
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(Icons.wallet_giftcard,
                                      color: Colors.yellow, size: 30),
                                ),
                                Expanded(
                                  child: const Text('Wallet',
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 13)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(Icons.chevron_right,
                                      color: Colors.white, size: 32),
                                ),
                              ],
                            ),
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.shade700,
                                      spreadRadius: 1,
                                      blurRadius: 5)
                                ],
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    width: 2, color: Colors.grey.shade800)),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 15),
                            height: 45,
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(Icons.person,
                                      color: Colors.yellow, size: 25),
                                ),
                                Expanded(
                                  child: const Text('Join us ',
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 13)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(Icons.chevron_right,
                                      color: Colors.white, size: 32),
                                ),
                              ],
                            ),
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.shade700,
                                      spreadRadius: 1,
                                      blurRadius: 5)
                                ],
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    width: 2, color: Colors.grey.shade800)),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 15),
                            height: 45,
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(Icons.share,
                                      color: Colors.yellow, size: 25),
                                ),
                                Expanded(
                                  child: const Text('Share App',
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 13)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(Icons.chevron_right,
                                      color: Colors.white, size: 32),
                                ),
                              ],
                            ),
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.shade700,
                                      spreadRadius: 1,
                                      blurRadius: 5)
                                ],
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    width: 2, color: Colors.grey.shade800)),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 15),
                            height: 45,
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(Icons.settings,
                                      color: Colors.yellow, size: 25),
                                ),
                                Expanded(
                                  child: const Text('Setting',
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 13)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(Icons.chevron_right,
                                      color: Colors.white, size: 32),
                                ),
                              ],
                            ),
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.shade700,
                                      spreadRadius: 1,
                                      blurRadius: 5)
                                ],
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    width: 2, color: Colors.grey.shade800)),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 15),
                            height: 45,
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(Icons.print,
                                      color: Colors.yellow, size: 25),
                                ),
                                Expanded(
                                  child: const Text('Attached Printer',
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 13)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(Icons.chevron_right,
                                      color: Colors.white, size: 32),
                                ),
                              ],
                            ),
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.shade700,
                                      spreadRadius: 1,
                                      blurRadius: 5)
                                ],
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    width: 2, color: Colors.grey.shade800)),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 15),
                            height: 45,
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(Icons.email,
                                      color: Colors.yellow, size: 25),
                                ),
                                Expanded(
                                  child: const Text('Contact Us',
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 13)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(Icons.chevron_right,
                                      color: Colors.white, size: 32),
                                ),
                              ],
                            ),
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.shade700,
                                      spreadRadius: 1,
                                      blurRadius: 5)
                                ],
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    width: 2, color: Colors.grey.shade800)),
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
