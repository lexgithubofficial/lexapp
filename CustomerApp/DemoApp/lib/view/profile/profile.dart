
import 'package:demoapp/constants.dart';
import 'package:demoapp/view/profile/ProfileController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class profile extends StatefulWidget {
  const profile({Key? key}) : super(key: key);

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  final cltFullName = TextEditingController();
  final cltEmailId = TextEditingController();
  final cltphoneNumber = TextEditingController();
  final cltpassword = TextEditingController();
  final cltconfirmpassword = TextEditingController();
  final ProfileController ProfileControllerobj = Get.put(ProfileController());

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
          "Create Account",
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
                child: Column(
                  children: [
                    const Text(
                      "Get on Board",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          fontFamily: "FontMain"),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: cltFullName,
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
                      controller: cltEmailId,
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
                      controller: cltphoneNumber,
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
                      controller: cltpassword,
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
                      controller: cltconfirmpassword,
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
                ),
              ),
            ),
            Center(
              child: Container(
                height:90,
                width: 90,
                margin: EdgeInsets.only(top: size.height * 0.20),
                child: Obx(() {
                  return ProfileControllerobj.imgPick.value == "" ? Center(
                          child: Image.asset('assets/images/dummyprofile.png',
                          fit: BoxFit.cover,
                        ))
                      : Container(
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: FileImage(ProfileControllerobj.imagePath),
                                  fit: BoxFit.cover)));
                }),
              ),
            ),
            GestureDetector(
              onTap: () {
                ProfileControllerobj.alertShow(context, "test");
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
                    String phoneNumber = cltphoneNumber.text.toString();
                    String password = cltpassword.text.toString();
                    String confirmpassword = cltconfirmpassword.text.toString();

                    ProfileControllerobj.nextClick(context, fullName, emailId,
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
                              "NEXT",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "FontMain"),
                            ),
                          ),
                        ),
                        Icon(
                          Icons.arrow_right_alt,
                          size: 32.0,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
