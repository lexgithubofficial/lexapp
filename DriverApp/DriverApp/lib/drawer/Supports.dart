import 'package:flutter/material.dart';

import '../constants.dart';

class Supports extends StatefulWidget {
  const Supports({super.key});

  @override
  _Supports createState() => _Supports();
}

class _Supports extends State<Supports> {
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
          title:Text("Supports",style: TextStyle(color: Colors.black,fontFamily: "FontMain",fontWeight: FontWeight.bold),),
        ),
        body:Container(
          color: Colors.black,
          child:Stack(
            children: [
              Container(
                height: size.height * 0.22,
                decoration: const BoxDecoration(
                  color: yellow_box_color,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
              ),
              Container(
                height: size.height * 0.70,
                width: double.infinity,
                margin: EdgeInsets.only(top:  size.height * 0.25),
                child:  Image.asset('assets/images/Support.png'),
              ),
            ],
          ),
        )
    );
  }
}
