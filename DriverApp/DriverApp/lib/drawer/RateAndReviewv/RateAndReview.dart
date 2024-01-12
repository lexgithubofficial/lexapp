import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import '../../Getx/api/ApiConstants.dart';
import '../../constants.dart';
import 'RateAndReviewController.dart';

class RateAndReview extends StatefulWidget {
  const RateAndReview({super.key});

  @override
  _RateAndReviewState createState() => _RateAndReviewState();
}

class _RateAndReviewState extends State<RateAndReview> {
  Future<bool> _onPop() async {
    return false;
  }
  TextEditingController comment = TextEditingController();
  @override
  void initState() {
    super.initState();
    comment = TextEditingController();
  }
  void dispose() {
    comment.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final RateAndReviewController RateAndReviewControllerobj = Get.put(RateAndReviewController());
    return WillPopScope(
        onWillPop: _onPop,
        child: Scaffold(
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
                  child: Obx(() {
                    return RateAndReviewControllerobj.isLoading.value
                        ? const Center(child: CircularProgressIndicator())
                        : Column(
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
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 25,
                                        ),
                                        const Center(
                                          child: Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Rate Your Customer ",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 22,
                                                  fontFamily: "FontMain",
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Center(
                                            child: Stack(
                                              children: [
                                                SizedBox(
                                                  width: 80,
                                                  height: 80,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        80),
                                                    child: Image.network(
                                                      ApiConstants.imgviewbasepath+RateAndReviewControllerobj.cprofile_image,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  bottom: 0,
                                                  right: 0,
                                                  child: Container(
                                                    width: 65,
                                                    height: 30,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(60),
                                                        color: Colors.white),
                                                    child:  Center(
                                                      child: Padding(
                                                        padding:
                                                        const EdgeInsets.all(
                                                            6.0),
                                                        child: Row(
                                                          children: [
                                                            const Icon(
                                                              Icons.star,
                                                              color: Colors
                                                                  .amber,
                                                              size: 14,
                                                            ),
                                                            Text(
                                                              RateAndReviewControllerobj.rating1=="null"? "1": RateAndReviewControllerobj.rating1,
                                                              style:
                                                              const TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 13,
                                                                fontFamily:
                                                                "FontMain",
                                                                fontWeight:
                                                                FontWeight
                                                                    .w700,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Center(
                                          child: Text(RateAndReviewControllerobj.cfull_name,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontFamily: "FontMain",
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                        const Center(
                                          child: Text(
                                            "How was your customer",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontFamily: "FontMain",
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
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
                                              RateAndReviewControllerobj.rating = rating.toInt();
                                            },
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 25,
                                        ),
                                        Row(
                                          children: [
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
                                                    RateAndReviewControllerobj.dfull_name,
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontFamily:
                                                        "FontMain",
                                                        fontWeight:
                                                        FontWeight.bold,
                                                        fontSize: 14),
                                                  ),
                                                  const Text("Driver",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontFamily:
                                                        "FontMain",
                                                        fontSize: 11,
                                                      )),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        const Text(
                                          "Comment",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: "FontMain",
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 50.0,
                                          child: TextField(
                                            keyboardType: TextInputType.text,
                                            controller: comment,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.white),
                                            decoration: const InputDecoration(
                                              hintText: "Enter your comment",
                                              hintStyle: TextStyle(
                                                  fontSize: 12.0,
                                                  fontFamily: "FontMain",
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                margin:
                                EdgeInsets.only(top: size.height * .70),
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Visibility(
                                    visible: true,
                                    child: MaterialButton(
                                      color: yellow_box_color,
                                      height: 45,
                                      minWidth: size.width * 0.5,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      onPressed: () {
                                        RateAndReviewControllerobj.savereview(context, int.parse(d_id11), RateAndReviewControllerobj.rating, comment.text.toString());
                                      },
                                      child: const Text(
                                        "DONE",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "FontMain"),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              ],
            ),
          ),
        ));
  }
}
