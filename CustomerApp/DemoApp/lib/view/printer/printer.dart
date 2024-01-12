import 'package:demoapp/constants.dart';
import 'package:flutter/material.dart';

class printer extends StatefulWidget {
  const printer({Key? key}) : super(key: key);

  @override
  State<printer> createState() => _printerState();
}

class _printerState extends State<printer> {
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
          "Feedback",
          textAlign: TextAlign.left,
          style: TextStyle(
            color: primary_black,
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: size.height * 0.30,
            decoration: const BoxDecoration(
              color: yellow_box_color,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: size.height * 0.17),
                  child: SizedBox(
                    height: size.height * 0.80,
                    child: Stack(
                      children: [
                        Center(
                          child: Container(
                            height: size.height * .75,
                            width: size.width * 0.9,
                            decoration: BoxDecoration(
                              color: secodary_black,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 40,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15, right: 15, bottom: 5),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text("Explain Briefly",
                                                style: TextStyle(
                                                    color: Colors.yellow.shade800,
                                                    fontSize: 25,
                                                    fontWeight: FontWeight.bold)),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextField(
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                          ),
                                          decoration: InputDecoration(
                                            hintText: "    Your feedback",
                                            alignLabelWithHint: true,
                                            contentPadding: const EdgeInsets.symmetric(
                                                vertical: 100.0),
                                            hintStyle: const TextStyle(
                                                fontSize: 13.0,
                                                color: Colors.white),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                              BorderRadius.circular(15),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
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
                            onPressed: () {},
                            child: const Text(
                              "Send",
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
