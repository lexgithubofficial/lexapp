import 'package:demoapp/constants.dart';
import 'package:demoapp/view/Booking/BookingController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingView extends StatelessWidget {
  const BookingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final BookingController _p = Get.put(BookingController());
     _p.LevelUp();
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
          "Add your address",
          textAlign: TextAlign.left,
          style: TextStyle(
            fontFamily: "FontMain",
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
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(top: (size.height * 0.5) / 4),
              child: IntrinsicWidth(
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: secodary_black, width: 8),
                    boxShadow: [
                      BoxShadow(color: yellow_box_color.withOpacity(0.5)),
                      const BoxShadow(
                        color: yellow_box_color,
                        spreadRadius: -2.0,
                        blurRadius: 2.0,
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        "Booking",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: primary_black,
                          fontFamily: "FontMain",
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 180),
              child: Container(
                height: size.height * 0.20,
                width: size.width * 0.9,
                decoration: BoxDecoration(
                  color: secodary_black,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  children: [
                     Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                const Text(
                                  "Pickup Location",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: yellow_box_color,
                                      fontFamily: "FontMain",
                                  ),
                                ),
                                const Spacer(),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.clear,
                                    color: yellow_box_color,
                                  ),
                                ),
                              ],
                            ),
                            const Divider(
                              color: Colors.white,
                            ),
                            Row(
                              children: [
                                const Text(
                                  "Destination Location",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: yellow_box_color,
                                  ),
                                ),

                                const Spacer(),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.clear,
                                    color: yellow_box_color,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                  // mainAxisAlignment: ,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: size.height * 0.55,
              width: size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Nearby Location",
                      // textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                          fontFamily: "FontMain",
                      ),
                    ),
                    Expanded(
                      // Display all products in home screen
                        child: ListView.builder(
                            itemCount: _p.items.length,
                            padding: EdgeInsets.zero,
                            // List item widget
                            itemBuilder: (context, index) {
                              final product = _p.items[index];
                              return Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    //set border radius more than 50% of height and width to make circle
                                  ),
                                key: ValueKey(product.id),
                                margin: const EdgeInsets.symmetric(
                                    vertical: 5),
                                color: Colors.grey.shade800,
                                child: ListTile(
                                  leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.asset(
                                      'assets/images/bookimg.jpg',

                                    ),
                                  ),


                                  iconColor: Colors.red,
                                  title: Text(product.name,style: const TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold,fontFamily: "FontMain"),),
                                  subtitle: Text(product.price,style: const TextStyle(color: Colors.yellow,fontSize: 13,fontFamily: "FontMain")),
                                  // Use Obx(()=> to update icon color when product.inWishList change
                                  trailing: Obx(() => IconButton(
                                    onPressed: () {
                                      if (product.inWishList.value == false) {
                                        _p.addItem(product.id);
                                      } else {
                                        _p.removeItem(product.id);
                                      }
                                    },
                                    icon: Icon(
                                      Icons.favorite,
                                      color: product.inWishList.value == false
                                          ? Colors.white
                                          : Colors.red,
                                    ),
                                  )),
                                ),
                              );
                            })),
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
                "DONE",
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                    fontFamily: "FontMain"
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}