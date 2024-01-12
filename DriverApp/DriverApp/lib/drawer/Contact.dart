import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';

class Contact extends StatefulWidget {
  const Contact({super.key});

  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> {
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
            "Contact",
            style: TextStyle(
                color: Colors.black,
                fontFamily: "FontMain",
                fontWeight: FontWeight.bold),
          ),
        ),
        body: Container(
          color: Colors.black,
          child: Stack(
            children: [
              Container(
                height: size.height * 0.44,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: yellow_box_color,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/Contact.png",
                      height: 150,
                      width: 300,
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: size.height * 0.20),
                      child: SizedBox(
                        height: size.height * 0.80,
                        child: Stack(
                          children: [
                            Center(
                              child: Container(
                                height: size.height * .60,
                                width: size.width * 0.9,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade800,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(20),
                                      child: const Text("Get in touch",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 22,
                                              fontFamily: "FontMain",
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    const Divider(
                                      color: Colors.grey,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(
                                          left: 50, right: 50, top: 15),
                                      child: const Text(
                                          "Wants to get in touch with us? we'd love to hear from you. Here is how you can reach us.",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 11,
                                              fontFamily: "FontMain",
                                              fontWeight: FontWeight.normal)),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: Container(
                                        height: 45,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            border: Border.all(
                                                width: 1, color: Colors.black)),
                                        child: Row(
                                          children: [
                                            const Expanded(
                                              child: Padding(
                                                padding:
                                                    EdgeInsets.only(left: 20),
                                                child: Text('+41 789717515',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 13)),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: GestureDetector(
                                                onTap: () {
                                                  FlutterPhoneDirectCaller
                                                      .callNumber(
                                                          "+41 789717515");
                                                },
                                                child: Icon(Icons.call,
                                                    color: Colors.white,
                                                    size: 25),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: Container(
                                        height: 45,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            border: Border.all(
                                                width: 1, color: Colors.black)),
                                        child: Row(
                                          children: [
                                            const Expanded(
                                              child: Padding(
                                                padding:
                                                    EdgeInsets.only(left: 20),
                                                child: Text('dispacter@lex.com',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 13,
                                                      fontFamily: "FontMain",
                                                    )),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: GestureDetector(
                                                onTap: () async {
                                                  launch(_emailLaunchUri.toString());

                                                },
                                                child: const Icon(Icons.message,
                                                    color: Colors.white,
                                                    size: 25),
                                              ),
                                            ),
                                          ],
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
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
final Uri _emailLaunchUri = Uri(
  scheme: 'mailto',
  path: "dispacter@lex.com",
  queryParameters: {'subject': "This is my subject", 'body': "Hey here goes the body"},
);