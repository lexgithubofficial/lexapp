import 'package:demoapp/Controller/LoginCantroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginActivity extends StatelessWidget {
  const LoginActivity({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(title: 'Login'),
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
  bool isCheck = false;
  final cltUserID = TextEditingController();
  final cltPassword = TextEditingController();
  bool _isObscure = true;

  @override
  void dispose() {
    cltUserID.dispose();
    super.dispose();
    // widget.title
  }

  @override
  Widget build(BuildContext context) {
    //***controller****///

    print("bulid");
    final formKey = GlobalKey<FormState>();
    // than having to individually change instances of widgets.

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Image.asset('assets/images/join_us.jpg'),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "User name cannot be blank";
                    }
                  },
                  keyboardType: TextInputType.text,
                  controller: cltUserID,
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: IntrinsicWidth(
                        child: IntrinsicHeight(
                          child: Row(
                            children: [
                              Icon(
                                Icons.account_box,
                                color: Colors.black,
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              VerticalDivider(
                                indent: 13,
                                endIndent: 13,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    hintText: "Enter user id",
                    labelText: "Username",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                        borderSide: BorderSide(color: Colors.grey, width: 1)),
                  ),
                ),
                Container(
                  height: 20,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password cannot be blank";
                    }
                  },
                  keyboardType: TextInputType.text,
                  obscureText: _isObscure,
                  controller: cltPassword,
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: IntrinsicWidth(
                        child: IntrinsicHeight(
                          child: Row(
                            children: [
                              Icon(
                                Icons.key,
                                color: Colors.black,
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              VerticalDivider(
                                indent: 13,
                                endIndent: 13,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                          _isObscure ? Icons.visibility : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                    ),
                    hintText: "Enter password",
                    labelText: "Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 20,
                ),
                Container(
                  height: 15,
                ),
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 45,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          var userId =
                              "intermind@ryal"; //cltUserID.text.toString();
                          var userPassword =
                              "Intermind@321456"; //cltPassword.text.toString();
                          /*  Get.toNamed("/RegisterActivity",arguments: [
                            'RAHUL',
                            'DRAVID'
                          ]);*/
                          // controller.incrementcounter();
                          // controller.changebutonname();
                          // Get.toNamed("/RegisterActivity");
                        },
                        icon: Icon(
                          Icons.login_outlined,
                          size: 20.0,
                        ),
                        label: Center(child: Obx(
                          () {
                            return Text(
                                Get.find<LoginCantroller>().NAME.toString());
                          },
                        )),
                      ),
                    ),
                    Center(child: Obx(
                      () {
                        return Text(
                            Get.find<LoginCantroller>().count.toString());
                      },
                    )),
                    Text("NOTIFICATION"),
                    Obx(() => Switch(
                        value: Get.find<LoginCantroller>().swichFlag.value,
                        onChanged: (v) {
                          Get.find<LoginCantroller>().changeswichbtn(v);
                          print(v);
                        }))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
