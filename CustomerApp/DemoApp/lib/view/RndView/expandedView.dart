import 'package:demoapp/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class expandedView extends StatefulWidget {
  const expandedView({Key? key}) : super(key: key);

  @override
  State<expandedView> createState() => _expandedViewState();
}

class _expandedViewState extends State<expandedView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: const Text(
          "Add your address",
          textAlign: TextAlign.left,
          style: TextStyle(
            color: primary_black,
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(14),
        child: Column(
          children: [
            Expanded(flex: 0,
                child: Icon(FontAwesomeIcons.user, size: 20)),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  "HERE GOES TffefefefrererererrereO TITLEhhghttytytytytytytytyyyyyttyty", style: TextStyle(fontSize: 14),),
              ),),
            Expanded(
                flex: 0,
                child: Icon(FontAwesomeIcons.arrowRightArrowLeft, size: 20)),

          ],
        ),
      ),
    );
  }
}
/////

