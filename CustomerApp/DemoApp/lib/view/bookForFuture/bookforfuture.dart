import 'package:demoapp/view/bookForFuture/BookForFutureController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../constants.dart';
import 'dart:async';

class bookforfuture extends StatefulWidget {
  const bookforfuture({Key? key}) : super(key: key);

  @override
  State<bookforfuture> createState() => _addWalletState();
}

class _addWalletState extends State<bookforfuture> {
  DateTime currentDate = DateTime.now();
  final BookForFutureController BookForFutureControllerobj = Get.put(BookForFutureController());

  var datetime1 = DateFormat("dd-MM-yyyy").format(DateTime.now());
  String selectedTime = DateFormat("hh:mm a").format(DateTime.now());

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 0)),
      lastDate: DateTime(2025),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.black, // <-- SEE HERE
              onPrimary: Colors.amber, // <-- SEE HERE
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: Colors.red, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null && pickedDate != currentDate) {
      setState(() {
        currentDate = pickedDate;
        datetime1 = DateFormat("dd-MM-yyyy").format(currentDate);

      });
    }
  }

  Future<void> displayTimeDialog() async {
    final TimeOfDay? time =
        await showTimePicker
          (context: context, initialTime: TimeOfDay.now(), builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
            primary: Colors.black, // <-- SEE HERE
            onPrimary: Colors.amber, // <-- SEE HERE
            onSurface: Colors.black,
            background: Colors.black// <-- SEE HERE
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              primary: Colors.red, // button text color
            ),
          ),
        ),
        child: child!,
      );
    },);
    if (time != null) {
      setState(() {
        selectedTime = time.format(context);
      });
    }
  }

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
          title: const Text(
            "Book for future",
            style: TextStyle(
                color: Colors.black,
                fontFamily: "FontMain",
                fontWeight: FontWeight.bold),
          ),
        ),
        body: Container(
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
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: size.height * 0.18),
                      child: Stack(
                        children: [
                          Center(
                            child: Container(
                              height: size.height * .80,
                              width: size.width * 0.9,
                              decoration: BoxDecoration(
                                color: Color(0xFF3c3c3c),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                        child: Image.asset(
                                      'assets/images/Bookforfuture.png',
                                      height: 140,
                                      width: 180,
                                    )),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        "Select Date",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
                                          fontFamily: "FontMain",
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        _selectDate(context);
                                      },
                                      child: Container(
                                        width: size.width,
                                        height: 55,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          boxShadow: [
                                            BoxShadow(
                                              color: primary_black
                                                  .withOpacity(0.5),
                                            ),
                                            const BoxShadow(
                                              color: secodary_black,
                                              spreadRadius: -2.0,
                                              blurRadius: 2.0,
                                            ),
                                          ],
                                        ),
                                        child: Row(
                                          children: [
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            const Icon(
                                              Icons.calendar_month,
                                              color: Colors.grey,
                                              size: 22,
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
                                                  const Text(
                                                    "Pick a date",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontFamily: "FontMain",
                                                        fontSize: 11),
                                                  ),
                                                  Text(
                                                    datetime1.toString(),

                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontFamily: "FontMain",
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              child: Align(
                                                alignment: Alignment.topRight,
                                                child: Center(
                                                  child: Row(
                                                    children: const [
                                                      Icon(
                                                        Icons
                                                            .keyboard_arrow_down,
                                                        color: Colors.amber,
                                                        size: 20,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        "Schedule Time",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
                                          fontFamily: "FontMain",
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        displayTimeDialog();
                                      },
                                      child: Container(
                                        width: size.width,
                                        height: 55,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          boxShadow: [
                                            BoxShadow(
                                              color: primary_black
                                                  .withOpacity(0.5),
                                            ),
                                            const BoxShadow(
                                              color: secodary_black,
                                              spreadRadius: -2.0,
                                              blurRadius: 2.0,
                                            ),
                                          ],
                                        ),
                                        child: Row(
                                          children: [
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            const Icon(
                                              Icons.lock_clock,
                                              color: Colors.grey,
                                              size: 22,
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
                                                  const Text(
                                                    "Pick a time",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontFamily: "FontMain",
                                                        fontSize: 11),
                                                  ),
                                                  Text(
                                                    selectedTime.toString(),
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontFamily: "FontMain",
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              child: Align(
                                                alignment: Alignment.topRight,
                                                child: Center(
                                                  child: Row(
                                                    children: const [
                                                      Icon(
                                                        Icons
                                                            .keyboard_arrow_down,
                                                        color: Colors.amber,
                                                        size: 20,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                          ],
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
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: MaterialButton(
                  color: Color(0xFFf8c102),
                  height: 45,
                  minWidth: size.width * 0.5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  onPressed: () {

                    BookForFutureControllerobj.saveData(datetime1.toString(),selectedTime.toString());

                  },
                  child: const Text(
                    "Book",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: "FontMain",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
