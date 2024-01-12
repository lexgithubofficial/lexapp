import 'package:flutter/material.dart';
import 'package:getwidget/components/dropdown/gf_dropdown.dart';

import '../constants.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var dropdownValue;
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
          title:const Text("Setting",style: TextStyle(color: Colors.black,fontFamily: "FontMain",fontWeight: FontWeight.bold),),
        ),
        body:Container(
          child: Stack(
            children: [
              Container(
                height: size.height * 0.5,
                decoration: const BoxDecoration(
                  color: yellow_box_color,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),

              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Container(
                    height: size.height * 0.55,
                    width: size.width * 0.9,

                    decoration: BoxDecoration(
                      color: const Color(0xFF3c3c3c),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Container(
                      margin: const EdgeInsets.all(30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Language Selection",style: TextStyle(color: Colors.white,fontFamily: "FontMain",fontWeight: FontWeight.bold,fontSize: 16),),
                          const SizedBox(
                            height: 15,
                          ),

                          Container(
                            height: 45,
                            child: DropdownButtonHideUnderline(
                              child: GFDropdown(
                                hint: const Text('Tab to select language',style: TextStyle(color: Colors.white,fontFamily: "FontMain",fontSize: 13),),
                                borderRadius: BorderRadius.circular(15),

                                border: const BorderSide(
                                    color: Colors.black54, width: 2),
                                dropdownButtonColor: const Color(0xFF3c3c3c),
                                value: dropdownValue,
                                onChanged: (newValue) {
                                  setState(() {
                                    dropdownValue = newValue;
                                  });
                                },
                                items: [
                                  'Germain',
                                  'French',
                                  'Italian',
                                  'English'
                                ]
                                    .map((value) => DropdownMenuItem(
                                  value: value,
                                  child: Text(value,style: const TextStyle(color: Colors.black54,fontFamily: "FontMain",),),
                                ))
                                    .toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ),
                ),
              ),
              Center(
                child: Visibility(
                  visible: false,
                  child: Container(
                    margin: EdgeInsets.only(top:  size.height * 0.60),
                    child: MaterialButton(
                      color:const Color(0xFFf8c102),
                      height: 45,
                      minWidth: size.width * 0.6,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      onPressed: () {},
                      child: const Text(
                        "DELETE ACCOUNT",
                        textAlign: TextAlign.center,
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
              )

            ],
          ),
        )
    );
  }
}
