import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'AddBankAccountController.dart';

class AddBankAccount extends StatefulWidget {
  const AddBankAccount({Key? key}) : super(key: key);

  @override
  State<AddBankAccount> createState() => AddBankAccountState();
}

class AddBankAccountState extends State<AddBankAccount> {
  final clrFullName     = TextEditingController();
  final clrCode     = TextEditingController();
  final clrCity     = TextEditingController();
  final clrIBAN     = TextEditingController();
  final clrBIC     = TextEditingController();
  final clrBankName     = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final AddBankAccountController AddBankAccountControllerobj = Get.put(AddBankAccountController());
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
          title:const Text("Add Bank Account",style: TextStyle(color: Colors.black, fontFamily: "FontMain",fontWeight: FontWeight.bold),),
        ),
        body: Container(
          color:  Colors.black,
          child:Stack(
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
                      margin: EdgeInsets.only(top: size.height * 0.16),
                      child: Stack(
                        children: [
                          Center(
                            child: Container(
                              height: size.height * .82,
                              width: size.width * 0.9,
                              decoration: BoxDecoration(
                                color: Color(0xFF3c3c3c),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Column(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Center(
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: 15, right: 15, top: 15),
                                            child: Text("Add Bank Account",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                    fontFamily: "FontMain",
                                                    fontWeight: FontWeight.bold)),
                                          ),
                                        ),
                                        Center(
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: 15, right: 15, top: 3),
                                            child: Text("Please fill out following to add you bank account",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: "FontMain",
                                                    fontSize: 13)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              left: 15, right: 15,top: 10),
                                          child: Text("FULL NAME",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 13,
                                                  fontFamily: "FontMain",
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(4),
                                          child: SizedBox(
                                            height: 45.0,
                                            child: TextField(
                                              keyboardType: TextInputType.text,
                                              controller: clrFullName,
                                              style: const TextStyle(
                                                  fontSize: 16, color: Colors.white),
                                              decoration: InputDecoration(
                                                hintText: "Enter your name",
                                                hintStyle: const TextStyle(
                                                    fontSize: 12.0,
                                                    fontFamily: "FontMain",
                                                    color: Colors.white),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(15),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              left: 15, right: 15),
                                          child: Text("CODE",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 13,
                                                  fontFamily: "FontMain",
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SizedBox(
                                            height: 45.0,
                                            child: TextField(
                                              keyboardType: TextInputType.text,
                                              controller: clrCode,
                                              style: const TextStyle(
                                                  fontSize: 16, color: Colors.white),
                                              decoration: InputDecoration(
                                                hintText: "Enter your code",
                                                hintStyle: const TextStyle(
                                                    fontSize: 12.0,
                                                    fontFamily: "FontMain",
                                                    color: Colors.white),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(15),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              left: 15, right: 15),
                                          child: Text("CITY",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 13,
                                                  fontFamily: "FontMain",
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(4),
                                          child: SizedBox(
                                            height: 45.0,
                                            child: TextField(
                                              keyboardType: TextInputType.text,
                                              controller: clrCity,
                                              style: const TextStyle(
                                                  fontSize: 16, color: Colors.white),
                                              decoration: InputDecoration(
                                                hintText: "Enter your city",
                                                hintStyle: const TextStyle(
                                                    fontSize: 12.0,
                                                    fontFamily: "FontMain",
                                                    color: Colors.white),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(15),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              left: 15, right: 15),
                                          child: Text("IBAN",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 13,
                                                  fontFamily: "FontMain",
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SizedBox(
                                            height: 45.0,
                                            child: TextField(
                                              keyboardType: TextInputType.text,
                                              controller: clrIBAN,
                                              style: const TextStyle(
                                                  fontSize: 16, color: Colors.white),
                                              decoration: InputDecoration(
                                                hintText: "Enter your iban",
                                                hintStyle: const TextStyle(
                                                    fontSize: 12.0,
                                                    fontFamily: "FontMain",
                                                    color: Colors.white),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(15),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              left: 15, right: 15),
                                          child: Text("BIC/SWIFT",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 13,
                                                  fontFamily: "FontMain",
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SizedBox(
                                            height: 45.0,
                                            child: TextField(
                                              keyboardType: TextInputType.text,
                                              controller: clrBIC,
                                              style: const TextStyle(
                                                  fontSize: 16, color: Colors.white),
                                              decoration: InputDecoration(
                                                hintText: "Enter your bic",
                                                hintStyle: const TextStyle(
                                                    fontSize: 12.0,
                                                    fontFamily: "FontMain",
                                                    color: Colors.white),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(15),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              left: 15, right: 15),
                                          child: Text("BANK NAME",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 13,
                                                  fontFamily: "FontMain",
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SizedBox(
                                            height: 45.0,
                                            child: TextField(
                                              keyboardType: TextInputType.text,
                                              controller: clrBankName,
                                              style: const TextStyle(
                                                  fontSize: 16, color: Colors.white),
                                              decoration: InputDecoration(
                                                hintText: "Enter your bank details",
                                                hintStyle: const TextStyle(
                                                    fontSize: 12.0,
                                                    fontFamily: "FontMain",
                                                    color: Colors.white),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(15),
                                                ),
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
                  color:const Color(0xFFf8c102),
                  height: 45,
                  minWidth: size.width * 0.5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  onPressed: () {

                    String FullName = clrFullName.text.toString();
                    String Code = clrCode.text.toString();
                    String city = clrCity.text.toString();
                    String IBAN = clrIBAN.text.toString();
                    String BIC = clrBIC.text.toString();
                    String BankName = clrBankName.text.toString();

                    AddBankAccountControllerobj.saveBankDetails(FullName,Code,city,IBAN,BIC,BankName);



                  },
                  child: const Text(
                    "ADD Bank",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.red,
                      fontFamily: "FontMain",
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }
}

