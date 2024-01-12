
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class RegisterActivity extends StatefulWidget {
   var name;
   RegisterActivity({Key? key,this.name}) : super(key: key);

  @override
  State<RegisterActivity> createState() => _RegisterActivityState();

}

class _RegisterActivityState extends State<RegisterActivity> {

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
    final formKey = GlobalKey<FormState>();

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
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return "User name cannot be blank";
                    }
                  },
                  keyboardType: TextInputType.text,
                  controller: cltUserID,
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: IntrinsicWidth(
                        child:
                        IntrinsicHeight(
                          child:  Row(
                            children: [
                              Icon(
                                Icons.account_box,
                                color: Colors.black,
                              ),
                              SizedBox(width: 3,),
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
                  validator: (value){
                    if(value == null || value.isEmpty){
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
                        child:
                        IntrinsicHeight(
                          child:  Row(
                            children: [
                              Icon(
                                Icons.key,
                                color: Colors.black,
                              ),
                              SizedBox(width: 3,),
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
                        borderSide: BorderSide(color: Colors.grey, width: 1)),

                  ),
                ),
                Container(
                  height: 20,
                ),
                Container(
                  height: 15,
                ),
                Container(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      var userId    = "intermind@ryal";//cltUserID.text.toString();
                      var userPassword = "Intermind@321456";//cltPassword.text.toString()
                      Get.snackbar(  Get.arguments[0], userPassword,backgroundColor: Colors.amberAccent,snackPosition:SnackPosition.BOTTOM );
                    },
                    icon: Icon(Icons.login_outlined, size: 20.0,),
                    label: Text('REGISTER'),
                  ),
                ),
                Container(
                  height: 15,
                ),
                Container(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Get.toNamed("/ImageCapturView");
                    },
                    icon: Icon(Icons.login_outlined, size: 20.0,),
                    label: Text('back'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
