import 'package:demoapp/constants.dart';
import 'package:demoapp/view/ContactUs/CantactUsController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  final cltFullName = TextEditingController();
  final cltEmailId = TextEditingController();
  final cltphoneNumber = TextEditingController();
  final cltmessage = TextEditingController();
  final CantactUsController CantactUsControllerobj = Get.put(CantactUsController());

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
          "Contact Us",
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
                                      const Padding(
                                        padding: EdgeInsets.only(
                                            left: 15, right: 15, top: 15),
                                        child: Text("Your Name",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontFamily: "FontMain",
                                                fontWeight: FontWeight.bold)),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SizedBox(
                                          height: 50.0,
                                          child: TextField(
                                            keyboardType: TextInputType.text,
                                            controller: cltFullName,
                                            style: const TextStyle(

                                                fontSize: 16, color: Colors.white),
                                            decoration: InputDecoration(
                                              hintText: "Enter your name",
                                              hintStyle: const TextStyle(
                                                  fontSize: 13.0,
                                                  fontFamily: "FontMain",
                                                  color: Colors.white),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(
                                            left: 15, right: 15, bottom: 5),
                                        child: Text("Your Email",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontFamily: "FontMain",
                                                fontWeight: FontWeight.bold)),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SizedBox(
                                          height: 50.0,
                                          child: TextField(
                                            keyboardType: TextInputType.emailAddress,
                                            controller: cltEmailId,
                                            style: const TextStyle(
                                                fontSize: 16, color: Colors.white),
                                            decoration: InputDecoration(
                                              hintText: "Enter your email id",
                                              hintStyle: const TextStyle(
                                                  fontSize: 13.0,
                                                  fontFamily: "FontMain",
                                                  color: Colors.white),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(
                                            left: 15, right: 15, bottom: 5),
                                        child: Text("Phone Number",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: "FontMain",
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SizedBox(
                                          height: 50.0,
                                          child: TextField(
                                            keyboardType: TextInputType.number,
                                            controller: cltphoneNumber,
                                            style: const TextStyle(
                                                fontSize: 16, color: Colors.white),
                                            decoration: InputDecoration(
                                              hintText: "Enter your phone no",
                                              hintStyle: const TextStyle(
                                                  fontSize: 13.0,
                                                  fontFamily: "FontMain",
                                                  color: Colors.white),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(
                                            left: 15, right: 15, bottom: 5),
                                        child: Text("Your Message",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontFamily: "FontMain",
                                                fontWeight: FontWeight.bold)),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextField(
                                          controller: cltmessage,
                                          keyboardType: TextInputType.multiline,
                                          minLines: 1, // <-- SEE HERE
                                          maxLines: 10,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                          ),
                                          decoration: InputDecoration(
                                            hintText: "    Write your message here",
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
                            onPressed: () {

                              String fullName=cltFullName.text.toString();
                              String emailId=cltEmailId.text.toString();
                              String phoneNumber=cltphoneNumber.text.toString();
                              String message=cltmessage.text.toString();

                              CantactUsControllerobj.nextClick(context,fullName,emailId,phoneNumber,message);



                            },
                            child: const Text(
                              "SUBMIT",
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
      ),
    );
  }
}
