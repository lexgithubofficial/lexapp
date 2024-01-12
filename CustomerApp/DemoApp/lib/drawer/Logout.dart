import 'package:demoapp/SharedPref.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class Logout extends StatefulWidget {
  const Logout({super.key});

  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<Logout> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var dropdownValue;
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
          title:const Text("Logout",style: TextStyle(color: Colors.white, fontFamily: "FontMain",fontWeight: FontWeight.bold),),
        ),
        body:Center(
          child: Stack(
            children: [
              Container(
                height: size.height * 1,
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/Online.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                margin:
                EdgeInsets.only(top: size.height * 0.35, left: 20, right: 20),
                height: size.height * 0.4,
                decoration: BoxDecoration(
                  color: Color(0xFF3c3c3c),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: SizedBox(
                  height: size.height * 0.50,
                  width: size.width,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        "LOG OUT?",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                            fontFamily: "FontMain",
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Are you sure want to logout?",
                        style: TextStyle(
                            fontSize: 13,
                            color: Colors.white,
                          fontFamily: "FontMain",
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      MaterialButton(
                        color:const Color(0xFFf8c102),
                        height: 45,
                        minWidth: size.width * 0.6,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        onPressed: () {
                          SharedPref.clearSharedPref();

                          Navigator.of(context) .pushNamedAndRemoveUntil("/LoginPage", (route) => false);
                        //  Navigator.popAndPushNamed(context, '/LoginPage');


                        },
                        child: const Text(
                          "LOG OUT",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 14,
                            fontFamily: "FontMain",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      MaterialButton(
                        color:const Color(0xFFf8c102),
                        height: 45,
                        minWidth: size.width * 0.6,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        onPressed: () {

                          Get.toNamed("/navmain",
                              arguments: ['parameter1', 'parameter2']);

                        },
                        child: const Text(
                          "CANCEL",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontFamily: "FontMain",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),


                    ],
                  ),),

              ),

            ],
          ),
        )
    );
  }
}
