import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'D Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // than having to individually change instances of widgets.
    var aarName = ["Hemant","Hemant","Hemant","Hemant","Hemant", "shekhar", "pate", "jaunpur", "sachin"];
    return Scaffold(
        appBar: AppBar(
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: ListView.separated(
          itemBuilder: (context, index){
            return Card(
              elevation: 4,
              child: Container(
                child: CircleAvatar(
                  child: Text('gggg',style: TextStyle(fontSize: 30,color: Colors.white,fontFamily: 'FontMain'),),
                  backgroundColor: Colors.cyan,
                  maxRadius: 60,
                ),
              ),
            );
          },
          itemCount: aarName.length,
          padding: EdgeInsets.all(10),
          separatorBuilder: (context, index) {
            return Divider();
          },
        ));
  }
}
