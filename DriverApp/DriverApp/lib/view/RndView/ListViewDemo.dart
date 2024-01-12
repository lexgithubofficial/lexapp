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
      home: const MyHomePage(title: 'ListViewDemo Page'),
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
    var aarName = ["Hemant", "shekhar", "pate", "jaunpur", "sachin"];
    return Scaffold(
        appBar: AppBar(
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: ListView.separated(
          itemBuilder: (context, index) {
            return Center(
              child: Container(
                padding: EdgeInsets.all(20),
                child: Text(aarName[index].toUpperCase(), style: TextStyle(fontSize: 20,color: Colors.white
                )),
                decoration: BoxDecoration(
                    color: Colors.cyan,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: 2, color: Colors.green),
                boxShadow: [BoxShadow(
                  blurRadius: 30,
                  color: Colors.green
                )]),
              ),
            );
          },
          itemCount: aarName.length,
          padding: const EdgeInsets.all(10),
          separatorBuilder: (context, index) {
            return Divider();
          },
        ));
  }
}
