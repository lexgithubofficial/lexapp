import 'package:demoapp/view/AppReports/AppReportsController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants.dart';

class appreport extends StatefulWidget {
  const appreport({super.key});

  @override
  _SendFeedbackPageState createState() => _SendFeedbackPageState();
}

class _SendFeedbackPageState extends State<appreport> {
  final AppReportsController AppReportsControllerobj = Get.put(AppReportsController());
  final feedback = TextEditingController();

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
          title: const Text(
            "App Reports",
            style: TextStyle(color: Colors.black,  fontFamily: "FontMain",fontWeight: FontWeight.bold),
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
                                      children: [
                                        const SizedBox(
                                          height: 40,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 15, right: 15, bottom: 5),
                                          child: Center(
                                            child: Text("Explain Briefly",
                                                style: TextStyle(
                                                    color: Colors.yellow.shade800,
                                                    fontSize: 22,
                                                    fontFamily: "FontMain",
                                                    fontWeight: FontWeight.bold)),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SizedBox(
                                            height: 250.0,
                                            child: TextField(
                                              controller: feedback,

                                              keyboardType: TextInputType.multiline,
                                              minLines: 1, // <-- SEE HERE
                                              maxLines: 10,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.white,
                                              ),
                                              decoration: InputDecoration(
                                                hintText: "    Your feedback",
                                                alignLabelWithHint: true,
                                                hintStyle: const TextStyle(
                                                    fontSize: 13.0,
                                                    fontFamily: "FontMain",
                                                    color: Colors.white),
                                                border: OutlineInputBorder(borderRadius:
                                                  BorderRadius.circular(15),
                                                ),
                                              ),
                                            ),
                                          ),


                                        ),
                                        const Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              "400 Maximum characters    ",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontFamily: "FontMain",
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
                                String fe = feedback.text.toString().trim();
                                AppReportsControllerobj.saveFeedback(fe);


                              },
                              child: const Text(
                                "Send",
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
                  ),

                ],
              ),
            ),
          ],
        ));
  }
}
