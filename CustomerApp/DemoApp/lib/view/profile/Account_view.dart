import 'package:demoapp/Getx/api/ApiConstants.dart';
import 'package:demoapp/SharedPref.dart';
import 'package:demoapp/constants.dart';
import 'package:demoapp/view/profile/AccountViewController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Account_view extends StatefulWidget {
  const Account_view({Key? key}) : super(key: key);

  @override
  State<Account_view> createState() => _profileState();
}

class _profileState extends State<Account_view> {
  @override
  void initState() {
    super.initState();
    SharedPref.getcustmerid().then((value) {
      AccountViewController AccountViewControllerobj = Get.put(AccountViewController());
      AccountViewControllerobj.fetchuserData(value.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final AccountViewController AccountViewControllerobj = Get.put(AccountViewController());
    return Scaffold(
      backgroundColor: primary_black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: primary_black,
        ),
        // the App.build method, and use it to set our appbar title.
        title: const Text(
          "Account",
          textAlign: TextAlign.left,
          style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: "FontMain"),
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: size.height * 0.30,
              width: size.height * 0.9,
              decoration: const BoxDecoration(
                color: yellow_box_color,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
            ),
            Container(
              height: size.height * 0.62,
              width: size.height * 0.9,
              margin:
                  EdgeInsets.only(left: 20, right: 20, top: size.height * 0.25),
              decoration: const BoxDecoration(
                color: grey_back,
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              child: Container(
                margin: EdgeInsets.only(
                    top: size.height * 0.08, left: 20, right: 20),
                child: Obx(() {
                  return AccountViewControllerobj.isLoading.value
                      ? const Center(child: CircularProgressIndicator())
                      : AccountViewControllerobj.UserData_obj?.data.fullName==""
                          ? const Center(child: CircularProgressIndicator())
                          : Column(
                              children: [
                                Text(
                                  "Welcome, ${AccountViewControllerobj.UserData_obj!.data.fullName}",
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "FontMain"),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  AccountViewControllerobj.UserData_obj!.data.email,
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontFamily: "FontMain"),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 15),
                                  width: size.width,
                                  height: 55,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: primary_black.withOpacity(0.5),
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
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [

                                            Text(
                                              AccountViewControllerobj
                                                      .UserData_obj!
                                                      .data
                                                      .fullName!,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: "FontMain",
                                                  fontSize: 14),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        child: Align(
                                          alignment: Alignment.topRight,
                                          child: Center(
                                            child: GestureDetector(
                                              onTap: () {

                                                Get.toNamed("/UpdateProfile", arguments: ['parameter1', 'parameter2']);

                                              },
                                              child: const Row(
                                                children: [
                                                  Icon(
                                                    Icons.edit,
                                                    color: Colors.white,
                                                    size: 20,
                                                  ),
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 15),
                                  width: size.width,
                                  height: 55,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: primary_black.withOpacity(0.5),
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
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              AccountViewControllerobj
                                                      .UserData_obj!
                                                      .data
                                                      .phone!,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: "FontMain",
                                                  fontSize: 14),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        child: Align(
                                          alignment: Alignment.topRight,
                                          child: Center(
                                            child: GestureDetector(
                                              onTap: () {
                                                Get.toNamed("/UpdateProfile", arguments: ['parameter1', 'parameter2']);
                                              },
                                              child: const Row(
                                                children: [
                                                  Icon(
                                                    Icons.edit,
                                                    color: Colors.white,
                                                    size: 20,
                                                  ),
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                const Text(
                                  "Your Payment Methord",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "FontMain",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width: size.width,
                                  height: 70,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: primary_black.withOpacity(0.5),
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
                                      Image.asset(
                                        'assets/images/visa.png',
                                        height: 35,
                                        width: 35,
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      const Expanded(
                                        child: Text(
                                          "************76",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      SizedBox(
                                        child: Align(
                                          alignment: Alignment.topRight,
                                          child: Center(
                                            child: GestureDetector(
                                              onTap: () {
                                                Get.toNamed("/paymentmethord",
                                                    arguments: [
                                                      'parameter1',
                                                      'parameter2'
                                                    ]);
                                              },
                                              child: const Text(
                                                'Change',
                                                style: TextStyle(
                                                  color: Colors.amber,
                                                  decoration:
                                                      TextDecoration.underline,
                                                ),
                                              ),
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
                              ],
                            );
                }),
              ),
            ),

            Container(
              height: size.height * 0.20,
              width: size.height * 0.9,
              margin: EdgeInsets.only(top: size.height * 0.20),
              child: Obx(() {
                return AccountViewControllerobj.isLoading.value
                    ? const Center()
                    : AccountViewControllerobj.UserData_obj!.data.isNull
                    ? const Center()
                    : Column(
                  children: [
                    SizedBox(
                      width: 80,
                      height: 80,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(80),
                        child: Image.network(
                          ApiConstants.imgviewbasepath+AccountViewControllerobj.UserData_obj!.data.profileImage,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                );
              }),

            ),
            GestureDetector(
              onTap: () {
                Get.toNamed("/UpdateProfile", arguments: ['parameter1', 'parameter2']);
              },
              child: Container(
                width: 20,
                height: 20,
                margin: EdgeInsets.only(
                    left: size.height * 0.26, top: size.height * 0.28),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(80),
                    color: Colors.white),
                child: const Icon(
                  Icons.add,
                  color: Colors.black87,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
