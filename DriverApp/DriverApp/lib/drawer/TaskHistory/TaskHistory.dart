import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../constants.dart';
import 'TaskHistoryController.dart';

class TaskHistory extends StatefulWidget {
  const TaskHistory({super.key});

  @override
  _TaskHistoryState createState() => _TaskHistoryState();
}

class _TaskHistoryState extends State<TaskHistory> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final TaskHistoryController RidesControllerobj = Get.put(TaskHistoryController());
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
          title: const Text("Task History",style: TextStyle(color: Colors.black,fontFamily: "FontMain",fontWeight: FontWeight.bold),),
        ),
        body: Stack(
          children: [
            Container(

              height: size.height * 0.5,
              decoration: const BoxDecoration(
                color: yellow_box_color,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: size.height * 0.2,left: 20,right: 20),
              height: size.height * 0.8,
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius: BorderRadius.circular(30),
              ),
              child:  SizedBox(
                height: size.height * 0.45,
                width: size.width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 25,left: 20),
                        child: const Text(
                          "Task History",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: "FontMain",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: Obx(() {
                          return RidesControllerobj.isLoading.value
                              ? const Center(child: CircularProgressIndicator())
                              : RidesControllerobj.dataSize== 0
                              ? Center(
                              child: Column(
                                children: [
                                  Image.asset(
                                    "assets/images/todaytask.png",
                                    height: 300,
                                  ),
                                ],
                              ))
                              : SizedBox(
                            height: 320,
                            child: ListView.builder(
                              physics:
                              const AlwaysScrollableScrollPhysics(),
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              itemCount: RidesControllerobj
                                  .allTaskModel.data.length,
                              itemBuilder:
                                  (BuildContext context, int index) {
                                return Container(
                                  margin: const EdgeInsets.only(top: 13),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          height: 47,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(20),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.5),
                                              ),
                                              BoxShadow(
                                                color: Colors.grey.shade900,
                                                spreadRadius: -2.0,
                                                blurRadius: 2.0,
                                              ),
                                            ],
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Row(
                                              children: [
                                                Container(
                                                  margin: const EdgeInsets.only(left: 10),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    children:[
                                                      Text(
                                                        "Earning: ""${RidesControllerobj
                                                            .allTaskModel
                                                            .data[index]
                                                            .bid} CHF",
                                                        // textAlign: TextAlign.left,
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 13,
                                                          fontFamily: "FontMain",
                                                          // fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const Spacer(),
                                                Container(
                                                  margin: const EdgeInsets.only(right: 5),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                  formate( RidesControllerobj.allTaskModel.data[index].acceptedTime.toString()),

                                                        style: const TextStyle(
                                                            color: Colors.grey,
                                                            fontFamily: "FontMain",
                                                            fontSize: 11),
                                                      ),
                                                      const Icon(Icons.calendar_month,
                                                          color: Colors.grey, size: 20),

                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          );
                        }),

                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
String formate(var date){
  DateTime parseDate =
  DateFormat("yyyy-MM-dd HH:mm:ss").parse(date);
  var inputDate = DateTime.parse(parseDate.toString());
  var outputFormat = DateFormat('MM/dd/yyyy');
  var outputDate = outputFormat.format(inputDate);
  return outputDate;
}