
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
      home: const MyHomePage(title: 'Home Page'),
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
    return Scaffold(
        appBar: AppBar(
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Container(

                      margin: EdgeInsets.all(10),
                      height: 200,
                      width: 200,
                      color: Colors.green,
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      height: 200,
                      width: 200,
                      color: Colors.green,
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      height: 200,
                      width: 200,
                      color: Colors.green,
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(30),
                      height: 200,
                      width: 200,
                      color: Colors.green,
                      decoration: BoxDecoration(
                          color: Colors.cyan,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(width: 2, color: Colors.green)),

                    ),

                    Container(
                      margin: EdgeInsets.all(10),
                      height: 200,
                      width: 200,
                      color: Colors.green,
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                height: 200,
                width: 200,
                color: Colors.green,
              ),
              Container(
                margin: EdgeInsets.all(10),
                width: 200,
                height: 200,
                color: Colors.black,
              ),
              Container(
                margin: EdgeInsets.all(10),
                width: 200,
                height: 200,
                color: Colors.green,
              ),
              Container(
                margin: EdgeInsets.all(10),
                width: 200,
                height: 200,
                color: Colors.green,
              ),
              Container(
                margin: EdgeInsets.all(10),
                width: 200,
                height: 200,
                color: Colors.green,
              ),
              Container(
                margin: EdgeInsets.all(10),
                width: 200,
                height: 200,
                color: Colors.green,
              ),
              Container(
                margin: EdgeInsets.all(10),
                width: 200,
                height: 200,
                color: Colors.green,
              ),
              Container(
                margin: EdgeInsets.all(10),
                width: 200,
                height: 200,
                color: Colors.green,
              ),
              Image.asset('assets/images/logo.png'),
              ElevatedButton(onPressed: (){
              //  Navigator.push(context, MaterialPageRoute(builder: (context) => IntroScreen()));

              }, child: Text("click me"))
            ],
          ),
        ));
  }
}
