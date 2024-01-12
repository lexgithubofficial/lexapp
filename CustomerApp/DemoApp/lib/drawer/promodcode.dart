import 'package:flutter/material.dart';

import '../constants.dart';

class promodcode extends StatefulWidget {
  const promodcode({super.key});

  @override
  _SendFeedbackPageState createState() => _SendFeedbackPageState();
}

class _SendFeedbackPageState extends State<promodcode> {
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
          color: Colors.black,
        ),
        // the App.build method, and use it to set our appbar title.
        title: Text("Promo Code",style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: "FontMain"),),
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
                  height: size.height * 0.6,
                  width: size.width * 0.9,
                  child: Stack(
                    children: [
                      Center(
                        child: Container(
                          height: size.height * 0.55,
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
                                  "Add Promo Code",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "FontMain"),
                                ),
                                const SizedBox(
                                  height: 50,
                                ),
                                TextFormField(
                                  decoration:  InputDecoration(

                                    border: new OutlineInputBorder(),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(10.0),

                                    ),

                                    labelStyle: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontFamily: "FontMain"),
                                    labelText: 'Your promo code will be here',

                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                const Text(
                                  "Please use the Promo Code to get leverage",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontFamily: "FontMain"),
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
                            "CONTINUE",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
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
      ),
    );
  }
}
