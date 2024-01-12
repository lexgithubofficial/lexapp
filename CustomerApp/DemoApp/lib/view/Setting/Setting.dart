import 'package:demoapp/constants.dart';
import 'package:demoapp/view/Setting/SettingController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/dropdown/gf_dropdown.dart';
class Setting extends StatefulWidget {

  const Setting({Key? key}) : super(key: key);


  @override
  State<Setting> createState() => _SettingState();

}

class _SettingState extends State<Setting> {

  ThemeMode _themeMode = ThemeMode.system;
  void changeTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }

  final SettingController SettingControllerobj = Get.put(SettingController());
  var dropdownValue;
  var languageValue;

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
          "Setting",
          textAlign: TextAlign.left,
          style: TextStyle(
            color: primary_black,
            fontFamily: "FontMain",
            fontWeight: FontWeight.bold
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 30),
            child: Icon(Icons.logout, size: 30),
          ),
        ],
      ),
      body: Stack(
        children: [

          Container(
            height: size.height * 0.5,
            width: size.height * 0.9,
            decoration: const BoxDecoration(
              color: yellow_box_color,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                    height: size.height * 0.15
                ),
                Container(
                    decoration:  BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        const BoxShadow(
                          color: Colors.black87,
                        ),
                        BoxShadow(
                          color: Colors.grey.shade800,
                          spreadRadius: -12.0,
                          blurRadius: 12.0,
                        ),
                      ],
                    ),

                    child:const Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Icon(Icons.dark_mode_outlined, size: 40,color: Colors.white,),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10,right: 15),
                            child: Text("Dark Mode",style: TextStyle(color:Colors.white54,fontSize: 12,fontWeight: FontWeight.bold, fontFamily: "FontMain",),),
                          )
                        ],
                      ),
                    )

                ),
                const SizedBox(
                    height: 15
                ),
                Container(
                    margin: const EdgeInsets.only(left: 30,right: 30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: primary_black.withOpacity(0.5),
                        ),
                         BoxShadow(
                          color: Colors.grey.shade800,
                          blurRadius: 1.0,
                        ),
                      ],
                    ),
                    child:const Padding(
                      padding: EdgeInsets.all(3),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:  [
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text("Automatic",style: TextStyle(color: Colors.white54,fontSize: 13, fontFamily: "FontMain",),),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10,right: 15),
                            child: SwitchExample(),

                          )
                        ],
                      ),
                    )

                )
              ],
            ),

          ),
          Container(
            height: size.height * 0.5,
            width: size.height * 0.9,
            margin: EdgeInsets.only(left: 20,right: 20,top: size.height * 0.35),
            decoration:  BoxDecoration(
              color: Colors.grey.shade800,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 20,top: 30),
                  child: Text("Currency",style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold, fontFamily: "FontMain",),),
                ),
                Container(
                  margin: const EdgeInsets.all(15),
                  height: 45,
                  child:  GetX<SettingController>(
                      builder: (state) {
                        return
                          DropdownButtonHideUnderline(
                            child: GFDropdown(
                              hint: const Text('Tab to select Currency',style: TextStyle(color: Colors.white54, fontFamily: "FontMain",fontSize: 13),),
                              borderRadius: BorderRadius.circular(15),
                              border: const BorderSide(
                                  color: Colors.black26, width: 2),
                              dropdownButtonColor: const Color(0xFF3c3c3c),
                              dropdownColor: Colors.grey.shade800,
                              value: dropdownValue,

                              items: state.currency.value.map((value) => DropdownMenuItem(
                                value: value,
                                child: Text(value,style: const TextStyle(color: Colors.white,fontFamily: "FontMain",fontSize: 13),),
                              )).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  dropdownValue = newValue;
                                });
                              },
                            ),
                          );
                      }
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 20,top: 10),
                  child: Text("Language",style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold, fontFamily: "FontMain",),),
                ),
                Container(
                  margin: const EdgeInsets.all(15),

                  height: 45,
                  child: GetX<SettingController>(
                    builder: (state) {
                      return state.isLoading.value? const Center(child: CircularProgressIndicator()) : DropdownButtonHideUnderline(
                        child: GFDropdown(
                          hint: const Text('Tab to select language',style: TextStyle(color: Colors.white54, fontFamily: "FontMain",fontSize: 13),),
                          borderRadius: BorderRadius.circular(15),
                          border: const BorderSide(
                              color: Colors.black26, width: 2),
                          dropdownButtonColor: const Color(0xFF3c3c3c),
                          dropdownColor: Colors.grey.shade800,
                          value: languageValue,

                          items: state.laungauge.value.map((value) => DropdownMenuItem(
                            value: value,
                            child: Text(value,style: const TextStyle(color: Colors.white,fontFamily: "FontMain",fontSize: 13),),
                          )).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              languageValue = newValue;
                            });
                          },
                        ),
                      );
                    }
                  ),
                ),


                const SizedBox(height: 25,),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children:  [
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text("Log Out",style: TextStyle(color: Colors.white54,fontSize: 13, fontFamily: "FontMain",),),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10,right: 15),
                      child: Icon(Icons.logout, size: 25),

                    )
                  ],
                )

              ],

            ),
          ),
        ],
      ),
    );
  }

}
class SwitchExample extends StatefulWidget {
  const SwitchExample({super.key});

  @override
  State<SwitchExample> createState() => _SwitchExampleState();
}
class _SwitchExampleState extends State<SwitchExample> {
  bool light = true;

  @override
  Widget build(BuildContext context) {
    return Switch(
      // This bool value toggles the switch.
      value: light,
      activeColor: Colors.green,
      onChanged: (bool value) {
        // This is called when the user toggles the switch.
        setState(() {
          light = value;
          if(light ==true){
            Get.changeThemeMode(ThemeMode.light);
          }else{
            Get.changeThemeMode(ThemeMode.dark);
          }
        });
      },
    );
  }
}
