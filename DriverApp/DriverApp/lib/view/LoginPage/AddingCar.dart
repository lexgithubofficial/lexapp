
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants.dart';
import 'AddCarController.dart';

class AddingCar extends StatefulWidget {
  const AddingCar({Key? key}) : super(key: key);

  @override
  State<AddingCar> createState() => _AddingCarState();

}

class _AddingCarState extends State<AddingCar> {
  final cltcarname     = TextEditingController();
  final cltcarno       = TextEditingController();
  final cltliencenceno = TextEditingController();
  final cltcarmodel    = TextEditingController();

  final AddCarController AddCarControllerobj = Get.put(AddCarController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    AddCarControllerobj. cont(context);
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        // the App.build method, and use it to set our appbar title.
        title: const Text(
          "Add Car",
          textAlign: TextAlign.left,
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontFamily: "FontMain"),
        ),
      ),
      body: Container(
        color: Colors.black87,
        child: Stack(
          children: [
            Container(
              height: size.height * 0.35,
              decoration: const BoxDecoration(
                color: yellow_box_color,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
            ),
            SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding:  EdgeInsets.only(top: size.height * 0.20),
                  child: SizedBox(
                    height: size.height * 0.70,
                    width: size.width * 0.9,
                    child: Stack(
                      children: [
                        Center(
                          child: Container(
                            height: size.height * 0.65,
                            width: size.width * 0.9,
                            decoration: BoxDecoration(
                              color: const Color(0xFF3c3c3c),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(35),
                              child: Column(
                                children: [
                                  const Text(
                                    "Your Car Details",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "FontMain"),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                   const Row(
                                     mainAxisAlignment: MainAxisAlignment.end,
                                     children: [
                                       Text(
                                        "Change Photo ",
                                        style: TextStyle(
                                            color: Colors.amber,
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "FontMain"),
                                  ),
                                     ],
                                   ),
                                  Image.asset('assets/images/car.png',height: 120,width: 120,),
                                  TextFormField(
                                    keyboardType: TextInputType.text,
                                    controller: cltcarname,
                                    style: const TextStyle(
                                        color: Colors.white),
                                    decoration:  const InputDecoration(
                                      border: UnderlineInputBorder(),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white),
                                      ),

                                      labelStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontFamily: "FontMain"),
                                      labelText: 'Car Name',

                                    ),
                                  ),
                                  TextFormField(
                                    keyboardType: TextInputType.text,
                                    controller: cltcarno,
                                    style: const TextStyle(
                                        color: Colors.white),
                                    decoration:  const InputDecoration(
                                      border: UnderlineInputBorder(),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white),
                                      ),

                                      labelStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontFamily: "FontMain"),
                                      labelText: 'Car Number Plate ',

                                    ),
                                  ),
                                  TextFormField(
                                    keyboardType: TextInputType.text,
                                    controller: cltliencenceno,
                                    style: const TextStyle(
                                        color: Colors.white),
                                    decoration:  const InputDecoration(
                                      border: UnderlineInputBorder(),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white),
                                      ),

                                      labelStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontFamily: "FontMain"),
                                      labelText: 'License Number ',

                                    ),
                                  ),
                                  TextFormField(
                                    keyboardType: TextInputType.text,
                                    controller: cltcarmodel,
                                    style: const TextStyle(
                                        color: Colors.white),
                                    decoration:  const InputDecoration(
                                      border: UnderlineInputBorder(),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white),
                                      ),

                                      labelStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontFamily: "FontMain"),
                                      labelText: 'Car Model ',

                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: size.height * 0.65),
                          child: Align(
                            child: MaterialButton(
                              color: yellow_box_color,
                              height: 45,
                              minWidth: size.width * 0.6,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              onPressed: () {

                                String cltcarnamev     =cltcarname.text.toString();
                                String cltcarnov       =cltcarno.text.toString();
                                String cltliencencenov =cltliencenceno.text.toString();
                                String cltcarmodelv    =cltcarmodel.text.toString();

                                AddCarControllerobj.submit(cltcarnamev,cltcarnov,cltliencencenov,cltcarmodelv);
                                if( AddCarControllerobj.isLoading ==true){
                                  const SizedBox(
                                    height: 50.0,
                                    width: 50.0,
                                    child: Center(child: CircularProgressIndicator()),
                                  );
                                }

                              },
                              child:SizedBox(
                                width:size.width * 0.6,
                                child: const Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 32.0),
                                        child: Text(
                                          "REGISTER",
                                          textAlign: TextAlign.center, style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "FontMain"),
                                        ),
                                      ),
                                    ),
                                    Icon(Icons.arrow_right_alt, size: 32.0,)
                                  ],
                                ),
                              ),
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
  }
}
