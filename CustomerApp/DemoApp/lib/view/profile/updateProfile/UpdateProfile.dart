import 'package:demoapp/Getx/api/ApiConstants.dart';
import 'package:demoapp/constants.dart';
import 'package:demoapp/view/profile/updateProfile/UpdateProfileController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({Key? key}) : super(key: key);

  @override
  State<UpdateProfile> createState() => _profileState();
}

class _profileState extends State<UpdateProfile> {
  final cltFullName = TextEditingController();
  final cltEmailId = TextEditingController();
  final cltphoneNumber = TextEditingController();
  final cltpassword = TextEditingController();
  final cltconfirmpassword = TextEditingController();
  final UpdateProfileController UpdateProfileControllerobj = Get.put(UpdateProfileController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
          "Update Account",
          textAlign: TextAlign.left,
          style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: "FontMain"),
        ),
      ),
      body: SingleChildScrollView(child:Stack(
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
            margin: EdgeInsets.only(
                left: 20, right: 20, top: size.height * 0.25),
            decoration: const BoxDecoration(
              color: grey_back,
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            child: Container(
              margin: EdgeInsets.only(
                  top: size.height * 0.08, left: 20, right: 20),
              child: Obx(() {
                return UpdateProfileControllerobj.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : UpdateProfileControllerobj.UserData_obj?.data.fullName==""
                    ? const Center(child: CircularProgressIndicator())
                    : Column(
                  children: [
                    const Text(
                      "Get on Update",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: "FontMain"),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: cltFullName..text = UpdateProfileControllerobj.UserData_obj!.data.fullName,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        labelStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontFamily: "FontMain"),
                        labelText: 'Full Name',
                      ),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: cltEmailId..text = UpdateProfileControllerobj.UserData_obj!.data.email,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        labelStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontFamily: "FontMain"),
                        labelText: 'Email',
                      ),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: cltphoneNumber..text = UpdateProfileControllerobj.UserData_obj!.data.phone,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        labelStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontFamily: "FontMain"),
                        labelText: 'Phone Number',
                      ),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      controller: cltpassword..text = UpdateProfileControllerobj.UserData_obj!.data.password,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        labelStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontFamily: "FontMain"),
                        labelText: 'Password',
                      ),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      controller: cltconfirmpassword..text = UpdateProfileControllerobj.UserData_obj!.data.password,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        labelStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontFamily: "FontMain"),
                        labelText: 'Confirm Password',
                      ),
                    ),
                    const SizedBox(
                      height: 15,
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
              return UpdateProfileControllerobj.isLoading.value
                  ? const Center()
                  : UpdateProfileControllerobj.UserData_obj?.data.fullName==""
                  ? const Center()
                  :Column(
                children: [
                  SizedBox(
                    width: 80,
                    height: 80,
                    child: Obx(() {
                      return UpdateProfileControllerobj.imgPick?.value == "" ? Center(
                          child:    Center(
                            child: CircleAvatar(
                              radius: 40.0,
                              backgroundImage: NetworkImage(
                                ApiConstants.imgviewbasepath+UpdateProfileControllerobj.UserData_obj!.data.profileImage!,
                              ),
                            ),
                          ))
                          : Container(
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: FileImage(UpdateProfileControllerobj.imagePath),
                                  fit: BoxFit.cover)));
                    }),

                  ),
                ],
              );
            }),

          ),
          GestureDetector(
            onTap: () {
              UpdateProfileControllerobj.alertShow(context, "test");
            },
            child: Container(
              width: 20,
              height: 20,
              margin: EdgeInsets.only(
                  left: size.height * 0.26,
                  top: size.height * 0.28),
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
          Container(
            margin: EdgeInsets.only(top: size.height * 0.82),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: MaterialButton(
                color: yellow_box_color,
                height: 45,
                minWidth: size.width * 0.6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                onPressed: () {
                  String fullName = cltFullName.text.toString();
                  String emailId = cltEmailId.text.toString();
                  String phoneNumber =
                  cltphoneNumber.text.toString();
                  String password = cltpassword.text.toString();
                  String confirmpassword = cltconfirmpassword.text.toString();

                  UpdateProfileControllerobj.nextClick(context, fullName, emailId,
                      phoneNumber, password, confirmpassword);

                },
                child: SizedBox(
                  width: size.width * 0.6,
                  child: const Row(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 32.0),
                          child: Text(
                            "UPDATE",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                fontFamily: "FontMain"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
