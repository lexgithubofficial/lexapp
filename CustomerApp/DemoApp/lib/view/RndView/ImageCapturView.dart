import 'dart:io';

import 'package:demoapp/Controller/ImageCapture.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageCapturView extends StatefulWidget {
  const ImageCapturView({Key? key}) : super(key: key);

  @override
  State<ImageCapturView> createState() => _ImageCapturViewState();
}

class _ImageCapturViewState extends State<ImageCapturView> {
  @override
  Widget build(BuildContext context) {
    //***controller****///
    final ImageCapture ctrlImageCaptur = Get.put(ImageCapture());

    return Scaffold(
        body: Scaffold(
      appBar: AppBar(
        title: Text("capture photo"),
      ),
      body:Obx(() {
        return  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
                radius: 30,
                backgroundImage: ctrlImageCaptur.imgPick.isEmpty
                    ? FileImage(File(ctrlImageCaptur.imgPick.toString()))
                    : null),
            ElevatedButton(
                onPressed: () {
                  ctrlImageCaptur.getImage();
                },
                child: Text("CAMERA")),
            Container(
              height: 14,
            ),
            ElevatedButton(onPressed: () {
              ctrlImageCaptur.getImageg();
            }, child: Text("GALLERY")),
          ],
        );
      }),
    ));
  }
}
