import 'package:demoapp/constants.dart';
import 'package:demoapp/view/profile/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class WelcomeLogin extends StatelessWidget {
  const WelcomeLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            // Background Image
            Image.asset(
              'assets/images/driverimg.png',
              // Replace with the path to your image
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),

            // Centered Column for Button and Text
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 280.0),
                        Text(
                          'Control',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                            fontFamily: "FontMain",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Pricing:',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                            fontFamily: "FontMain",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'No surging price',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                            fontFamily: "FontMain",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                  const SizedBox(height: 40.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          height: 2, width: 80, color: Colors.white),
                      const SizedBox(width: 10,),
                      Container(
                          height: 2, width: 80, color: Colors.white54),
                      const SizedBox(width: 10,),
                      Container(
                          height: 2, width: 80, color: Colors.white54),
                    ],
                  ),

                  const SizedBox(height: 60.0),


                  // Your Button Widget
                  Column(
                    children: [
                      MaterialButton(
                        color: yellow_box_color,
                        height: 45,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        onPressed: () {

                          Get.toNamed("/LoginPage", arguments: [1]);
                        },
                        child: const SizedBox(
                          width: 250,
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Center(
                                  child: Text(
                                    "LOGIN",
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "FontMain"),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      MaterialButton(
                        color: yellow_box_color,
                        height: 45,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        onPressed: () {

                          Get.toNamed("/profile", arguments: [1]);

                        },
                        child: const SizedBox(
                          width: 250,
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Center(
                                  child: Text(
                                    "SING UP",
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "FontMain"),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
