import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../Getx/api/ApiConstants.dart';
import '../../constants.dart';
import 'WalletComtroller.dart';
class addWallet extends StatefulWidget {
  const addWallet({super.key});

  @override
  _addWalleteState createState() => _addWalleteState();
}

class _addWalleteState extends State<addWallet> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final WalletComtroller WalletComtrollerobj = Get.put(WalletComtroller());
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
          title: const Text("Wallet",style: TextStyle(color: Colors.black,fontFamily: "FontMain",fontWeight: FontWeight.bold),),
        ),
        body: Column(
          children: [
            Container(
              color: Colors.black,
              child: Stack(
                children: [
                  Container(
                    height: size.height * 0.42,
                    decoration: const BoxDecoration(
                      color: yellow_box_color,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: size.height * 0.18),
                        child: SizedBox(
                          height: size.height * 0.35,
                          child: Stack(
                            children: [
                              Center(
                                child: Container(
                                  height: size.height * .35,
                                  width: size.width * 0.9,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF3c3c3c),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.all(7),
                                        alignment: Alignment.centerRight,
                                        child: MaterialButton(
                                          color:const Color(0xFFf8c102),
                                          height: 35,
                                          minWidth: 100,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          onPressed: () {},
                                          child: const Text(
                                            "Add Money",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 13,
                                              fontFamily: "FontMain",
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),

                                      Obx(() {
                                        return WalletComtrollerobj.isLoading.value
                                            ? const Center(child: CircularProgressIndicator())
                                            :  Expanded(
                                          child:Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              margin: const EdgeInsets.only(top: 20),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Column(
                                                        children: [
                                                          Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: Container(
                                                              height: 100,
                                                              width: 130,
                                                              decoration: BoxDecoration(
                                                                borderRadius:
                                                                BorderRadius.circular(20),
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    color: Colors.black
                                                                        .withOpacity(0.5),
                                                                  ),
                                                                  const BoxShadow(
                                                                    color:Color(0xFF3c3c3c),
                                                                    spreadRadius: -2.0,
                                                                    blurRadius: 2.0,
                                                                  ),
                                                                ],
                                                              ),
                                                              child:  Padding(
                                                                padding: const EdgeInsets.all(8.0),
                                                                child: Column(
                                                                  children: [

                                                                    const Icon(Icons.savings,
                                                                        color: Colors.amber, size: 20),
                                                                    const SizedBox(
                                                                      height: 5,
                                                                    ),
                                                                    const Text(
                                                                      'Lifetime Earning',
                                                                      style: TextStyle(
                                                                          color: Colors.white,
                                                                          fontFamily: "FontMain",
                                                                          fontSize: 11),
                                                                    ),
                                                                    Text(
                                                                      'CHF ${WalletComtrollerobj.lifetime_earning}',
                                                                      style: const TextStyle(
                                                                          color: Colors.amber,
                                                                          fontFamily: "FontMain",
                                                                          fontSize: 20,fontWeight: FontWeight.bold),
                                                                    ),

                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          )

                                                        ],
                                                      ),
                                                      Column(
                                                        children: [
                                                          Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: Container(
                                                              height: 100,
                                                              width: 130,
                                                              decoration: BoxDecoration(
                                                                borderRadius:
                                                                BorderRadius.circular(20),
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    color: Colors.black
                                                                        .withOpacity(0.5),
                                                                  ),
                                                                  const BoxShadow(
                                                                    color:Color(0xFF3c3c3c),
                                                                    spreadRadius: -2.0,
                                                                    blurRadius: 2.0,
                                                                  ),
                                                                ],
                                                              ),
                                                              child:  Padding(
                                                                padding: EdgeInsets.all(8.0),
                                                                child: Column(
                                                                  children: [

                                                                    const Icon(Icons.real_estate_agent_rounded,
                                                                        color: Colors.amber, size: 20),
                                                                    const SizedBox(
                                                                      height: 5,
                                                                    ),
                                                                    const Text(
                                                                      'Current Balance',
                                                                      style: TextStyle(
                                                                          color: Colors.white,
                                                                          fontFamily: "FontMain",
                                                                          fontSize: 11),
                                                                    ),
                                                                    Text(
                                                                      'CHF ${WalletComtrollerobj.lifetime_earning}',
                                                                      style: const TextStyle(
                                                                          color: Colors.amber,
                                                                          fontFamily: "FontMain",
                                                                          fontSize: 20,fontWeight: FontWeight.bold),
                                                                    ),

                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          )

                                                        ],
                                                      ),
                                                    ],
                                                  )

                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      }),

                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: size.height * 0.10, left: size.height * 0.18),
                    height: 100,
                    width: 100,
                    child:    Center(
                      child:Obx(() {
                        return WalletComtrollerobj.isLoading.value
                            ? const Center()
                            :  CircleAvatar(
                          radius: 40.0,
                          backgroundImage: NetworkImage(
                            ApiConstants.imgviewbasepath + WalletComtrollerobj.profileImage,
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.black,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: size.height * 0.45,
                  width: size.width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 10,left: 20),
                          child: const Text(
                            "Transactional History",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontFamily: "FontMain",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                       Obx(() {
                          return WalletComtrollerobj.isLoading1.value
                              ? const Center(child: CircularProgressIndicator())
                              :WalletComtrollerobj.allTaskModel.data.isEmpty
                              ? const Center(
                              child: CircularProgressIndicator())
                              :  Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 0,
                              ),
                              child: ListView.builder(
                                physics:  const AlwaysScrollableScrollPhysics(),
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                itemCount: WalletComtrollerobj.allTaskModel.data.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            height: 65,
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
                                              padding: const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    margin: const EdgeInsets.only(left: 10),
                                                    child:  Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                      children: [
                                                        Text(
                                                          "CHF ""${WalletComtrollerobj.allTaskModel.data[index].bid}",
                                                          // textAlign: TextAlign.left,
                                                          style: const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12,
                                                            fontWeight:

                                                            FontWeight.bold,
                                                            fontFamily: "FontMain",
                                                          ),
                                                        ),
                                                         Text(
                                                           formate( WalletComtrollerobj.allTaskModel.data[index].acceptedTime.toString()),
                                                          // textAlign: TextAlign.left,
                                                          style: const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 11,
                                                            fontFamily: "FontMain",
                                                            // fontWeight: FontWeight.bold,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const Spacer(),
                                                  Container(
                                                    margin: const EdgeInsets.only(right: 10),
                                                    child:  Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                      children: [
                                                        Text(
                                                        "+CHF ""${WalletComtrollerobj.allTaskModel.data[index].bid}",
                                                          style: const TextStyle(
                                                              color: Colors.green,
                                                              fontFamily: "FontMain",
                                                              fontSize: 12),
                                                        ),
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
                            ),
                          );
                        }),
                      ],
                    ),
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