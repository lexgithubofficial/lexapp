import 'package:demoapp/constants.dart';
import 'package:flutter/material.dart';

class AddCard extends StatefulWidget {
  const AddCard({Key? key}) : super(key: key);

  @override
  State<AddCard> createState() => _profileState();

}

class _profileState extends State<AddCard> {

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
          "Add Your Card",
          textAlign: TextAlign.left,
          style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: "FontMain"),
        ),
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
                                  "Add Your Card",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "FontMain"),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  decoration:  const InputDecoration(
                                    border: UnderlineInputBorder(),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white),
                                    ),

                                    labelStyle: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "FontMain"),
                                    labelText: 'Name of card',

                                  ),
                                ),
                                TextFormField(
                                  decoration:  const InputDecoration(
                                    border: UnderlineInputBorder(),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white),
                                    ),

                                    labelStyle: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "FontMain"),
                                    labelText: 'Card number ',

                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 100,
                                      child: TextFormField(
                                        decoration:  const InputDecoration(
                                          border: UnderlineInputBorder(),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.white),
                                          ),

                                          labelStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: "FontMain"),
                                              labelText: 'Expiry Date',

                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 100,
                                      child: TextFormField(
                                        decoration:  const InputDecoration(
                                          border: UnderlineInputBorder(),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.white),
                                          ),

                                          labelStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: "FontMain"),
                                          labelText: 'CVV',

                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(
                                  height: 30,
                                ),
                                const Text(
                                  "Following category od cards are accepted here",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "FontMain"),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Image.asset('assets/images/paymentType.png'),

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
                            "REGISTER",
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
