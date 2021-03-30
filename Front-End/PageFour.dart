import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:agro_guru_logncreate/PageThree.dart';
import 'package:agro_guru_logncreate/drawer.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: agroGuruImagePicker(),
    );
  }
}

class agroGuruImagePicker extends StatefulWidget {
  @override
  _agroGuruImagePicker createState() => _agroGuruImagePicker();
}

class _agroGuruImagePicker extends State<agroGuruImagePicker> {
  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedCamera = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedCamera != null) {
        _image = File(pickedCamera.path);
      } else {
        print('No image is selected.');
      }
    });
  }

  Future getGallery() async {
    final pickedGallery = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedGallery != null) {
        _image = File(pickedGallery.path);
      } else {
        print('No image is selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,

        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 5.0),
            child: Container(
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => agroGuruLeafFruitRoot()),
                  );
                },
                icon: Icon(Icons.cancel_outlined),
                iconSize: 35.0,
              ),
              alignment: Alignment.topLeft,
            ),
          ),

          Padding(
            padding: EdgeInsets.only(right: 5.0),
            child: IconButton(
              onPressed: () {

              },
              icon: Icon(Icons.notifications_none),
            ),
          ),
        ],
      ),

      drawer: MainDrawer(),

      body: Center(
        child: _image == null ? Icon(Icons.crop_free_sharp,
        size: 250.0, color: Colors.grey[400],) : Image.file(_image),
      ),
      floatingActionButtonLocation:
      FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 15.0, right: 20.0, left: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new FloatingActionButton(
              heroTag: "btn1",
              onPressed: getImage,
              tooltip: 'Image',
              child: Icon(Icons.camera_alt_outlined),
              backgroundColor: Colors.lightGreen,
            ),
            new FloatingActionButton(
              heroTag: "btn2",
              onPressed: getGallery,
              tooltip: 'Gallery',
              child: Icon(Icons.add_photo_alternate_outlined),
              backgroundColor: Colors.lightGreen,
            ),
          ],
        ),
      ),
    );
  }
}