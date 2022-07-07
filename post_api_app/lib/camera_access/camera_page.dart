// ignore_for_file: avoid_print, prefer_const_constructors

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class MyCamera extends StatefulWidget {
  const MyCamera({Key? key}) : super(key: key);

  @override
  State<MyCamera> createState() => _MyCameraState();
}

class _MyCameraState extends State<MyCamera> {
  File? image;
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } catch (e) {
      print('$e');
    }
  }

  Future clickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } catch (e) {
      print('$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image pick Demo"),
      ),
      body: Column(children: [
        IconButton(
            onPressed: () {
              clickImage();
            },
            icon: Icon(Icons.camera_alt_outlined)),
        SizedBox(
          height: 20,
        ),
        IconButton(
            onPressed: () {
              pickImage();
            },
            icon: Icon(Icons.insert_drive_file_outlined)),
        image != null
            ? Image.file(
                image!,
                width: 160,
                height: 160,
                fit: BoxFit.cover,
              )
            : Container()
      ]),
    );
  }
}
