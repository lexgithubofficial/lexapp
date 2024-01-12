import 'package:demoapp/Getx/api/ApiConstants.dart';
import 'package:demoapp/constants.dart';
import 'package:demoapp/view/RateReview/RateAndReviewController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

class RateAndReview extends StatefulWidget {
  const RateAndReview({super.key});

  @override
  _SendFeedbackPageState createState() => _SendFeedbackPageState();
}

TextEditingController comment = TextEditingController();

@override
void initState() {
  comment = TextEditingController();
}

void dispose() {
  comment.dispose();

}
class _SendFeedbackPageState extends State<RateAndReview> {


  Future<bool> _onPop() async {
    final shouldPop = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Do you want skip review?',
            style: TextStyle(
                color: Colors.black,
                fontFamily: "FontMain",
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
          actionsAlignment: MainAxisAlignment.end,
          actions: [
            TextButton(
              onPressed: () {
                Get.toNamed("/HomeActivity",
                    arguments: ['parameter1', 'parameter2']);
              },
              child: const Text(
                'Yes',
                style: TextStyle(
                    color: Colors.black54,
                    fontFamily: "FontMain",
                    fontWeight: FontWeight.bold),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text(
                'No',
                style: TextStyle(
                    color: Colors.black54,
                    fontFamily: "FontMain",
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
    return shouldPop!;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final RateAndReviewController RateAndReviewControllerobj = Get.put(RateAndReviewController());

    return WillPopScope(
        onWillPop: _onPop,
        child:  Scaffold(
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
              "Rate & Review",
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: "FontMain",
                  fontWeight: FontWeight.bold),
            ),
          ),
          body: Container(
            height: double.infinity,
            color: Colors.black,
            child: Stack(
              children: [
                Container(
                  height: size.height * 0.35,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xFFf8c102),
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
                        margin: EdgeInsets.only(top: size.height * 0.18),
                        child: Stack(
                          children: [
                            Center(
                              child: Container(
                                height: size.height * .75,
                                width: size.width * 0.9,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF3c3c3c),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 25,
                                      ),
                                      Center(
                                        child: Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            const Text(
                                              "Order ",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontFamily: "FontMain",
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            Text(
                                              "#$previous_booking_idshow",
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontFamily: "FontMain",
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Container(
                                        width: size.width,
                                        height: 55,
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
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "How was the rides?",
                                                    style: TextStyle(
                                                        color: Colors.amber,
                                                        fontFamily: "FontMain",
                                                        fontSize: 18,
                                                        fontWeight:
                                                        FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Container(
                                        width: size.width,
                                        height: 55,
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
                                            SizedBox(
                                              width: 40,
                                              height: 40,
                                              child: ClipRRect(
                                                borderRadius:
                                                BorderRadius.circular(80),
                                                child: Image.network(
                                                  ApiConstants.imgviewbasepath+RateAndReviewControllerobj.dprofile_image,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    drivernameShow,
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontFamily: "FontMain",
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 14),
                                                  ),
                                                  const Text("Driver",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontFamily: "FontMain",
                                                        fontSize: 11,
                                                      )),
                                                ],
                                              ),
                                            ),
                                             SizedBox(
                                              child: Align(
                                                alignment: Alignment.topRight,
                                                child: Center(
                                                  child: Row(
                                                    children: [
                                                      IconButton(
                                                        color: Colors.white,
                                                        onPressed: () {
                                                          FlutterPhoneDirectCaller.callNumber(
                                                              RateAndReviewControllerobj.phone);

                                                        },
                                                        icon: const Icon(Icons.call),
                                                      ),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                       Padding(
                                                        padding:
                                                        const EdgeInsets.all(
                                                            5),
                                                        child:  IconButton(
                                                          color: Colors.white,
                                                          onPressed: () {

                                                            RateAndReviewControllerobj.send();
                                                          },
                                                          icon: const Icon(Icons.message),
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
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Container(
                                        width: size.width,
                                        height: 230,
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
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                children: [
                                                  const SizedBox(
                                                    height: 15,
                                                  ),
                                                  const Center(
                                                    child: Text(
                                                      "Rate the driver",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontFamily: "FontMain",
                                                          fontSize: 16,
                                                          fontWeight:
                                                          FontWeight.bold),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Center(
                                                    child: RatingBar.builder(
                                                      initialRating: 3,
                                                      minRating: 1,
                                                      direction: Axis.horizontal,
                                                      allowHalfRating: true,
                                                      itemCount: 5,
                                                      itemBuilder: (context, _) =>
                                                      const Icon(
                                                        Icons.star,
                                                        color: Colors.amber,
                                                      ),
                                                      onRatingUpdate: (rating) {
                                                        print(rating);
                                                        RateAndReviewControllerobj.rating = rating.toString();
                                                      },
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Container(
                                                    margin:
                                                    const EdgeInsets.only(right: 20),
                                                    width: size.width,
                                                    height: 100,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                      BorderRadius.circular(5),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: primary_black
                                                              .withOpacity(0.5),
                                                        ),
                                                        const BoxShadow(
                                                          color: secodary_black,
                                                          spreadRadius: -2.0,
                                                          blurRadius: 6.0,
                                                        ),
                                                      ],
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        const SizedBox(
                                                          width: 20,
                                                        ),
                                                        Expanded(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                            children: [
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              const Text(
                                                                "Comment",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontFamily:
                                                                    "FontMain",
                                                                    fontSize: 13,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                              ),
                                                              SizedBox(
                                                                height: 50.0,
                                                                child: TextField(
                                                                  keyboardType: TextInputType.text,
                                                                  controller: comment,
                                                                  style: const TextStyle(
                                                                      fontSize: 16,
                                                                      color: Colors
                                                                          .white),
                                                                  decoration:
                                                                  const InputDecoration(
                                                                    hintText:
                                                                    "Enter your comment",
                                                                    hintStyle: TextStyle(
                                                                        fontSize:
                                                                        12.0,
                                                                        fontFamily:
                                                                        "FontMain",
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
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
                            Container(
                              margin: EdgeInsets.only(top: size.height * .70),
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: MaterialButton(
                                  color: yellow_box_color,
                                  height: 45,
                                  minWidth: size.width * 0.5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  onPressed: () {


                                    RateAndReviewControllerobj.savereview(context,
                                        RateAndReviewControllerobj.rating,comment.text.toString());

                                  },
                                  child: const Text(
                                    "CONFIRM",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "FontMain"),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: size.height * .77),
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: GestureDetector(
                                  onTap: () {

                                    Navigator.of(context) .pushNamedAndRemoveUntil("/navmain", (route) => false);
                                  },
                                  child: const Text(
                                    "Skip",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "FontMain",
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
