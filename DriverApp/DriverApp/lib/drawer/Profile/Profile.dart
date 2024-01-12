import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Getx/api/ApiConstants.dart';
import 'ProfileControllerUpadte.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _profileState();
}

class _profileState extends State<Profile> {
  final cltmobileno = TextEditingController();
  final cltjobtype = TextEditingController();
  final cltasignteam = TextEditingController();
  final ProfileControllerUpadte ProfileControlleronj =
      Get.put(ProfileControllerUpadte());

  @override
  void initState() {
    super.initState();
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
            "Profile",
            style: TextStyle(
                color: Colors.black,
                fontFamily: "FontMain",
                fontWeight: FontWeight.bold),
          ),
        ),
        body: Container(
          color: Colors.black,
          child: Obx(() {
            return ProfileControlleronj.isLoading.value
                ? const Center(child: CircularProgressIndicator())
                : ProfileControlleronj.View == 0
                    ? const Center(child: CircularProgressIndicator())
                    : Stack(
                        children: [
                          SingleChildScrollView(
                            child: Column(
                              children: [
                                Container(
                                  margin:
                                      EdgeInsets.only(top: size.height * 0.41),
                                  child: Stack(
                                    children: [
                                      Center(
                                        child: Container(
                                          height: size.height * .55,
                                          width: size.width * 0.9,
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF3c3c3c),
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    top: 20, left: 30),
                                                child: const Text(
                                                    "More Details",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                        fontFamily: "FontMain",
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ),
                                              const Divider(
                                                color: Colors.white70,
                                              ),
                                              const Padding(
                                                padding: EdgeInsets.only(
                                                    left: 15,
                                                    right: 15,
                                                    top: 15),
                                                child: Text("Phone Number",
                                                    style: TextStyle(
                                                        color: Colors.white54,
                                                        fontFamily: "FontMain",
                                                        fontSize: 13)),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.black87
                                                            .withOpacity(0.5),
                                                      ),
                                                      const BoxShadow(
                                                        color:
                                                            Color(0xFF3c3c3c),
                                                        spreadRadius: -2.0,
                                                        blurRadius: 2.0,
                                                      ),
                                                    ],
                                                  ),
                                                  child: SizedBox(
                                                    height: 45.0,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 20),
                                                      child: TextField(
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        controller: cltmobileno
                                                          ..text =
                                                              ProfileControlleronj
                                                                  .profileModel
                                                                  .data
                                                                  .phone,
                                                        style: const TextStyle(
                                                            fontSize: 16,
                                                            color:
                                                                Colors.white54),
                                                        decoration: const InputDecoration(
                                                            hintStyle: TextStyle(
                                                                fontSize: 12.0,
                                                                fontFamily:
                                                                    "FontMain",
                                                                color: Colors
                                                                    .white)),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const Padding(
                                                padding: EdgeInsets.only(
                                                    left: 15,
                                                    right: 15,
                                                    top: 15),
                                                child: Text("Job Type",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontFamily: "FontMain",
                                                        fontSize: 14)),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.black87
                                                            .withOpacity(0.5),
                                                      ),
                                                      const BoxShadow(
                                                        color:
                                                            Color(0xFF3c3c3c),
                                                        spreadRadius: -2.0,
                                                        blurRadius: 2.0,
                                                      ),
                                                    ],
                                                  ),
                                                  child: SizedBox(
                                                    height: 45.0,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 20),
                                                      child: TextField(
                                                        keyboardType:
                                                            TextInputType.text,
                                                        controller: cltjobtype
                                                          ..text =
                                                              ProfileControlleronj
                                                                  .profileModel
                                                                  .data
                                                                  .jobType,
                                                        style: const TextStyle(
                                                            fontSize: 16,
                                                            color:
                                                                Colors.white54),
                                                        decoration: const InputDecoration(
                                                            hintStyle: TextStyle(
                                                                fontSize: 12.0,
                                                                fontFamily:
                                                                    "FontMain",
                                                                color: Colors
                                                                    .white)),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const Padding(
                                                padding: EdgeInsets.only(
                                                    left: 15,
                                                    right: 15,
                                                    top: 15),
                                                child: Text("Assigned Team",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontFamily: "FontMain",
                                                        fontSize: 14)),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.black87
                                                            .withOpacity(0.5),
                                                      ),
                                                      const BoxShadow(
                                                        color:
                                                            Color(0xFF3c3c3c),
                                                        spreadRadius: -2.0,
                                                        blurRadius: 2.0,
                                                      ),
                                                    ],
                                                  ),
                                                  child: SizedBox(
                                                    height: 45.0,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 20),
                                                      child: TextField(
                                                        keyboardType:
                                                            TextInputType.text,
                                                        controller: cltasignteam
                                                          ..text =
                                                              ProfileControlleronj
                                                                  .profileModel
                                                                  .data
                                                                  .assigTeam,
                                                        style: const TextStyle(
                                                            fontSize: 16,
                                                            color:
                                                                Colors.white54),
                                                        decoration: const InputDecoration(
                                                            hintStyle: TextStyle(
                                                                fontSize: 12.0,
                                                                fontFamily:
                                                                    "FontMain",
                                                                color: Colors
                                                                    .white)),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const Divider(
                                                color: Colors.white70,
                                              ),
                                              SizedBox(
                                                height: 70,
                                                width: double.infinity,
                                                child:   Image.asset('assets/images/Profile2.png'),
                                              )

                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Visibility(
                            visible: true,
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: MaterialButton(
                                color: const Color(0xFFf8c102),
                                height: 45,
                                minWidth: size.width * 0.5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                onPressed: () {
                                  String mobileno = cltmobileno.text.toString();
                                  String jobtype = cltjobtype.text.toString();
                                  String asignteam =
                                      cltasignteam.text.toString();
                                  ProfileControlleronj.submit(
                                      mobileno, jobtype, asignteam);
                                },
                                child: const Text(
                                  "UPDATE",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 14,
                                    fontFamily: "FontMain",
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: size.height * 0.42,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              color: Color(0xFFf8c102),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(30),
                                bottomRight: Radius.circular(30),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(height: 30),
                                SizedBox(
                                  height: 90,
                                  width: 90,
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    fit: StackFit.expand,
                                    children: [
                                      Obx(() {
                                        return ProfileControlleronj
                                                    .imgPick.value ==
                                                ""
                                            ? Center(
                                                child: CircleAvatar(
                                                radius: 40.0,
                                                backgroundImage: NetworkImage(
                                                  ApiConstants.imgviewbasepath +
                                                      ProfileControlleronj
                                                          .profileModel
                                                          .data
                                                          .profileImage,
                                                ),
                                              ))
                                            : Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.grey,
                                                    shape: BoxShape.circle,
                                                    image: DecorationImage(
                                                        image: FileImage(
                                                            ProfileControlleronj
                                                                .imagePath),
                                                        fit: BoxFit.cover)));
                                      }),
                                      Positioned(
                                          bottom: 0,
                                          right: 0,
                                          child: SizedBox(
                                            width: 30,
                                            height: 30,
                                            child: RawMaterialButton(
                                              onPressed: () {
                                                ProfileControlleronj.alertShow(
                                                    context);
                                              },
                                              elevation: 2.0,
                                              fillColor:
                                                  const Color(0xFFF5F6F9),
                                              padding:
                                                  const EdgeInsets.all(1.0),
                                              shape: const CircleBorder(),
                                              child: const Icon(
                                                Icons.add,
                                                color: Colors.blue,
                                                size: 20,
                                              ),
                                            ),
                                          )),
                                    ],
                                  ),
                                ),
                                Text(
                                    ProfileControlleronj
                                        .profileModel.data.fullName,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "FontMain",
                                    )),
                                Text(
                                    ProfileControlleronj
                                        .profileModel.data.carName,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontFamily: "FontMain",
                                    )),
                                Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  width: 200,
                                  height: 42,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black87.withOpacity(0.5),
                                      ),
                                      const BoxShadow(
                                        color: Color(0xFFf8c102),
                                        spreadRadius: -2.0,
                                        blurRadius: 2.0,
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Text(
                                        ProfileControlleronj
                                            .profileModel.data.carNo,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontFamily: "FontMain",
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
          }),
        ));
  }
}
