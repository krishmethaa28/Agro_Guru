import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
      appBar: AppBar(
        title: Text('Image Picker'),
      ),
      body: Center(
        child: _image == null ? Text('Please select an image from camera or gallery') : Image.file(_image),
      ),
      floatingActionButtonLocation:
      FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(10.0),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new FloatingActionButton(
              onPressed: getImage,
              tooltip: 'Camera',
              child: Icon(Icons.add_a_photo),
            ),

            new FloatingActionButton(
              onPressed: getGallery,
              tooltip: 'Gallery',
              child: Icon(Icons.collections),

            ),
          ],
        ),
      ),
    );
  }
}