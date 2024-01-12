import 'package:demoapp/constants.dart';
import 'package:demoapp/view/profile/LoginController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _profileState();
}

@override
void initState() {
  initState();
}

class _profileState extends State<LoginPage> {
  Future<bool> _onPop() async {
    return false;
  }

  final cltEmailId = TextEditingController();
  final cltpassword = TextEditingController();
  final sendemail = TextEditingController();

  final LoginController LoginController_obj = Get.put(LoginController());
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
        onWillPop: _onPop,
        child: Scaffold(
          backgroundColor: primary_black,
          extendBodyBehindAppBar: true,
          body: SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  height: size.height * 0.40,
                  width: size.height * 0.9,
                  decoration: const BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Welcome Back",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            fontFamily: "FontMain"),
                      ),
                      Text(
                        "Please login to continue",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 15,
                            fontFamily: "FontMain"),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: size.height * 0.45,
                  width: size.height * 0.9,
                  margin: EdgeInsets.only(
                      left: 20, right: 20, top: size.height * 0.30),
                  decoration: const BoxDecoration(
                    color: secodary_black,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  child: Container(
                    margin: EdgeInsets.only(
                        top: size.height * 0.08, left: 20, right: 20),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(
                                    left: 15, right: 15, top: 15),
                                child: Text("Email or Phone Number",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                        fontFamily: "FontMain")),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  height: 50.0,
                                  child: TextField(
                                    keyboardType: TextInputType.emailAddress,
                                    controller: cltEmailId,
                                    style: const TextStyle(
                                        fontSize: 14, color: Colors.white),
                                    decoration: InputDecoration(
                                      hintText: "Email or phone number",
                                      hintStyle: const TextStyle(
                                          fontSize: 13.0,
                                          fontFamily: "FontMain",
                                          color: Colors.white),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: const BorderSide(
                                              color: Colors.amber)),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 15, right: 15),
                                child: Text("Password",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                        fontFamily: "FontMain")),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  height: 50.0,
                                  child: TextField(
                                    keyboardType: TextInputType.visiblePassword,
                                    controller: cltpassword,
                                    obscureText: _obscureText,
                                    style: const TextStyle(
                                        fontSize: 14, color: Colors.white),
                                    decoration: InputDecoration(
                                      suffixIcon: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _obscureText = !_obscureText;
                                          });
                                        },
                                        child: Icon(
                                          _obscureText
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                        ),
                                      ),
                                      hintText: "*****",
                                      hintStyle: const TextStyle(
                                          fontSize: 15.0,
                                          fontFamily: "FontMain",
                                          color: Colors.white),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: const BorderSide(
                                              color: Colors.amber)),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.topRight,
                              child: GestureDetector(
                                onTap: () {
                                  Get.dialog(
                                    SizedBox(
                                      height: size.width * .85,
                                      width: size.width * .8,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 40),
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(20),
                                                ),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(20.0),
                                                child: Material(
                                                  child: Column(
                                                    children: [
                                                      const SizedBox(height: 3),
                                                      const Text(
                                                        " Forgot password     ",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            color: Colors.blue,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 17),
                                                      ),
                                                      TextField(
                                                        keyboardType:
                                                            TextInputType
                                                                .emailAddress,
                                                        controller: sendemail,
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.black54),
                                                        decoration:
                                                            const InputDecoration(
                                                          enabledBorder:
                                                              UnderlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                                    color: Colors
                                                                        .grey),
                                                          ),
                                                          labelStyle: TextStyle(
                                                              color: Colors
                                                                  .black54,
                                                              fontSize: 15,
                                                              fontFamily:
                                                                  "FontMain"),
                                                          labelText: 'Email',
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                          height: 10),
                                                      MaterialButton(
                                                        color: yellow_box_color,
                                                        height: 45,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                        ),
                                                        onPressed: () {
                                                          String emailId =
                                                              sendemail.text
                                                                  .toString();

                                                          LoginController_obj
                                                              .forgotPassword(
                                                                  emailId);
                                                        },
                                                        child: const SizedBox(
                                                          width: 250,
                                                          child: Row(
                                                            children: <Widget>[
                                                              Expanded(
                                                                child: Center(
                                                                  child: Text(
                                                                    "SEND",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontFamily:
                                                                            "FontMain"),
                                                                  ),
                                                                ),
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
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                child: const Text("Forgot password   ",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 13,
                                        decoration: TextDecoration.underline,
                                        fontFamily: "FontMain")),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: size.height * 0.73),
                  child: Column(
                    children: [
                      MaterialButton(
                        color: yellow_box_color,
                        height: 45,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        onPressed: () {
                          String emailId = cltEmailId.text.toString();
                          String Password = cltpassword.text.toString();
                          LoginController_obj.nextClick(context, emailId, Password);
                        },
                        child: const SizedBox(
                          width: 250,
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Center(
                                  child: Text(
                                    "LOGIN",
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
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Text("Don't have a account? ",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontFamily: "FontMain")),
                            GestureDetector(
                              onTap: () {
                                Get.toNamed("/profile",
                                    arguments: ['parameter1', 'parameter2']);
                              },
                              child: const Text("Create One",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 15,
                                      fontFamily: "FontMain")),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              height: 1, width: 70, color: Colors.white54),
                          const Text("  or continue with  ",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontFamily: "FontMain")),
                          Container(
                              height: 1, width: 70, color: Colors.white54),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            'assets/images/google.png',
                            height: 25,
                            width: 25,
                          ),
                          const SizedBox(
                            width: 22,
                          ),
                          Image.asset(
                            'assets/images/fb.png',
                            height: 25,
                            width: 25,
                          ),
                          const SizedBox(
                            width: 22,
                          ),
                          Image.asset(
                            'assets/images/apple.png',
                            height: 25,
                            width: 25,
                            color: Colors.white,
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
