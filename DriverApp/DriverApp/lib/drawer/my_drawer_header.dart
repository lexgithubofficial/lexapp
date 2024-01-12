import 'package:flutter/material.dart';

class MyHeaderDrawer extends StatefulWidget {
  const MyHeaderDrawer({super.key});

  @override
  _MyHeaderDrawerState createState() => _MyHeaderDrawerState();
}

class _MyHeaderDrawerState extends State<MyHeaderDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFfff8e5),
      width: double.infinity,
      height: 200,
      padding: EdgeInsets.only(top: 40.0),
      child: Image.asset('assets/images/Sidemenu.png')
    );
  }
}
