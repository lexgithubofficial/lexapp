import 'package:demoapp/constants.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
class ShareApp extends StatefulWidget {
  const ShareApp({Key? key}) : super(key: key);

  @override
  State<ShareApp> createState() => _ShareAppState();
}

class _ShareAppState extends State<ShareApp> {
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
          "Share",
          textAlign: TextAlign.left,
          style: TextStyle(
            color: primary_black,
            fontFamily: "FontMain",
            fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: size.height * 0.55,
            decoration: const BoxDecoration(
              color: yellow_box_color,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
          ),
          Container(
            height: size.height * 0.43,

            margin: EdgeInsets.only(left:  15,right: 15,top:size.height * 0.18),
            decoration: BoxDecoration(
              color: secodary_black,
              borderRadius: BorderRadius.circular(30),
            ),
            child:Padding(
              padding: const EdgeInsets.all(60),
              child: Image.asset(
                "assets/images/share.jpg",
              ),
            )
          ),

          Container(
            margin: EdgeInsets.only(top: size.height * 0.65),
            child: Column(
              children: [
                const Text(
                  "Share Via",
                  style: TextStyle(color: Colors.white, fontSize: 18,fontFamily: "FontMain"),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        'assets/images/fb.png',
                        height: 30,
                        width: 30,
                      ),
                      Image.asset(
                        'assets/images/insta.png',
                        height: 30,
                        width: 30,
                      ),
                      Image.asset(
                        'assets/images/twitter.png',
                        height: 30,
                        width: 30,
                      ),
                      Image.asset(
                        'assets/images/whatsapp.png',
                        height: 30,
                        width: 30,
                      ),
                      Image.asset(
                        'assets/images/gmail.png',
                        height: 30,
                        width: 30,
                      ),
                    ],
                  ),
                ),

                ElevatedButton.icon(
                  onPressed: () async {
                    // _onShare method:
                    final box = context.findRenderObject() as RenderBox?;
                    await Share.share(
                      "Download the app \n Click here - https://play.google.com/store/search?q=ola&c=apps",
                      subject: "",
                      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
                    );
                  },
                  icon: const Icon( // <-- Icon
                    Icons.share,
                    size: 24.0,
                    color: Colors.black,
                  ),
                  label: const Padding(
                    padding: EdgeInsets.only(left: 30,right: 30),
                    child: Text('Share Vai Link',style: TextStyle(fontSize:12,color: Colors.black,fontWeight: FontWeight.bold, fontFamily: "FontMain",),),
                  ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.yellow.shade700, // background// foreground
                    ),
                ),
                const Padding(
                  padding: EdgeInsets.all(20),
                  child: Text("Share with your friend by taping share button",style: TextStyle(color: Colors.white, fontFamily: "FontMain",fontSize: 13),),
                )
              ],
            ),
          )
        ],

      ),

    );
  }
}
