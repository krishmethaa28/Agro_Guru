import 'dart:io';
import 'package:cropmedic/Disorder/CitrusBlackSpot.dart';
import 'package:cropmedic/Disorder/CitrusCanker.dart';
import 'package:cropmedic/Disorder/CitrusGreening.dart';
import 'package:cropmedic/Disorder/CitrusScab.dart';
import 'package:cropmedic/Disorder/EmergentDisease.dart';
import 'package:cropmedic/Disorder/FungiDisease.dart';
import 'package:cropmedic/Disorder/PepperBellBacterialSpot.dart';
import 'package:cropmedic/Disorder/PotatoEarlyBlight.dart';
import 'package:cropmedic/Disorder/PotatoLateBlight.dart';
import 'package:cropmedic/Disorder/RootRotten.dart';
import 'package:cropmedic/Disorder/RottenApples.dart';
import 'package:cropmedic/Disorder/RottenBanana.dart';
import 'package:cropmedic/Disorder/RottenOranges.dart';
import 'package:cropmedic/Disorder/TomatoTargetSpot.dart';
import 'package:cropmedic/Disorder/TomatoMosaicVirus.dart';
import 'package:cropmedic/Disorder/TomatoBacterialSpot.dart';
import 'package:cropmedic/Disorder/TomatoEarlyBlight.dart';
import 'package:cropmedic/Disorder/TomatoYellowLeafCurlVirus.dart';
import 'package:cropmedic/Disorder/TomatoLateBlight.dart';
import 'package:cropmedic/Disorder/TomatoLeafMold.dart';
import 'package:cropmedic/Disorder/TomatoSeptoriaLeafSpot.dart';
import 'package:cropmedic/Disorder/TomatoSpiderMites.dart';
import 'package:cropmedic/Login.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';

import 'homeScreenDisorderDesc.dart';

class DetectMain extends StatefulWidget {
  @override
  _DetectMainState createState() => new _DetectMainState();
}

class _DetectMainState extends State<DetectMain> {
  File _image;
  double _imageWidth;
  double _imageHeight;
  var _recognitions;
  bool dialVisible = true;

  // Load the tflite model for the prediction
  loadModel() async {
    Tflite.close();
    try {
      String res;
      res = await Tflite.loadModel(
        model: "assets/mobilenet.tflite",
        labels: "assets/labels.txt",
      );
      print(res);
    } on PlatformException {
      print("Failed to load the model");
    }
  }

  // Run prediction using TFLite on given image
  Future predict(File image) async {
    var recognitions = await Tflite.runModelOnImage(
        path: image.path,
        // required
        imageMean: 0.0,
        // defaults to 117.0
        imageStd: 255.0,
        // defaults to 1.0
        numResults: 2,
        // defaults to 5
        threshold: 0.2,
        // defaults to 0.1
        asynch: true // defaults to true
        );

    print(recognitions);

    setState(() {
      _recognitions = recognitions;
    });
  }

  // Upload the image to the firebase storage
  uploadFile(File _image) {
    StorageReference storageReference =
        FirebaseStorage.instance.ref().child('images/${DateTime.now()}');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    uploadTask.onComplete;
    print('File Uploaded');
    String returnURL;
    storageReference.getDownloadURL().then((fileURL) {
      returnURL = fileURL;
    });
    return returnURL;
  }

  // Send image to predict method selected from gallery or camera
  sendImage(File image) async {
    if (image == null) return;
    await predict(image);

    // Get the width and height of selected image
    FileImage(image)
        .resolve(ImageConfiguration())
        .addListener((ImageStreamListener((ImageInfo info, bool _) {
          setState(() {
            _imageWidth = info.image.width.toDouble();
            _imageHeight = info.image.height.toDouble();
            _image = image;
          });
        })));
  }

  // Select image from gallery
  selectFromGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    setState(() {});
    sendImage(image);
    // uploadFile(image);
  }

  // Select image from camera
  selectFromCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    if (image == null) return;
    setState(() {});
    sendImage(image);
    // uploadFile(image);
  }

  @override
  void initState() {
    super.initState();

    loadModel().then((val) {
      setState(() {});
    });
  }

  // To print the prediction value
  Widget printValue(rcg) {
    if (rcg == null) {
      return Text('',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700));
    } else if (rcg.isEmpty) {
      return Center(
        child: Text("Are you Sure! Is this a Disorder?",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700)),
      );
    }
    return Column(
      children: <Widget>[
        Center(
          child: Text(
            "Results: " + _recognitions[0]['label'].toString(),
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        SizedBox(
            height: 50,
            width: 380,
            child: RaisedButton(
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10.0),
                  side: BorderSide(color: Colors.lightGreen.shade700)),
              onPressed: () {
                if (_recognitions[0]['label'].toString() ==
                    "Pepper bell bacterial spot") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PepperBellBacterialSpot()),
                  );
                } else if (_recognitions[0]['label'].toString() ==
                    "Potato early blight") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PotatoEarlyBlight()),
                  );
                } else if (_recognitions[0]['label'].toString() ==
                    "Potato late blight") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PotatoLateBlight()),
                  );
                } else if (_recognitions[0]['label'].toString() ==
                    "Tomato target spot") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TomatoTargetSpot()),
                  );
                } else if (_recognitions[0]['label'].toString() ==
                    "Tomato tomato mosaic virus") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TomatoMosaicVirus()),
                  );
                } else if (_recognitions[0]['label'].toString() ==
                    "Tomato tomato yellow leaf curl virus") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TomatoYellowLeafCurlVirus()),
                  );
                } else if (_recognitions[0]['label'].toString() ==
                    "Tomato bacterial spot") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TomatoBacterialSpot()),
                  );
                } else if (_recognitions[0]['label'].toString() ==
                    "Tomato early blight") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TomatoEarlyBlight()),
                  );
                } else if (_recognitions[0]['label'].toString() ==
                    "Tomato late blight") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TomatoLateBlight()),
                  );
                } else if (_recognitions[0]['label'].toString() ==
                    "Tomato leaf mold") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TomatoLeafMold()),
                  );
                } else if (_recognitions[0]['label'].toString() ==
                    "Tomato septoria leaf spot") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TomatoSeptoriaLeafSpot()),
                  );
                } else if (_recognitions[0]['label'].toString() ==
                    "Tomato spider mites two spotted spider mite") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TomatoSpiderMites()),
                  );
                } else if (_recognitions[0]['label'].toString() ==
                    "Citrus black spot") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CitrusBlackSpot()),
                  );
                } else if (_recognitions[0]['label'].toString() ==
                    "Citrus canker") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CitrusCanker()),
                  );
                } else if (_recognitions[0]['label'].toString() ==
                    "Citrus greening") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CitrusGreening()),
                  );
                } else if (_recognitions[0]['label'].toString() ==
                    "Citrus scab") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CitrusScab()),
                  );
                } else if (_recognitions[0]['label'].toString() ==
                    "Rotten apples") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RottenApples()),
                  );
                } else if (_recognitions[0]['label'].toString() ==
                    "Rotten banana") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RottenBanana()),
                  );
                } else if (_recognitions[0]['label'].toString() ==
                    "Rotten oranges") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RottenOranges()),
                  );
                } else if (_recognitions[0]['label'].toString() ==
                    "Rotten oranges") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RottenOranges()),
                  );
                } else if (_recognitions[0]['label'].toString() ==
                    "Emergent diseases") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EmergentDisease()),
                  );
                } else if (_recognitions[0]['label'].toString() ==
                    "Fungi disease") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FungiDisease()),
                  );
                } else if (_recognitions[0]['label'].toString() ==
                    "Root rotten") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RootRotten()),
                  );
                }
              },
              color: Colors.lightGreen.shade700,
              textColor: Colors.white,
              child: Text("Check Remedy".toUpperCase(),
                  style: TextStyle(fontSize: 16)),
            ))
      ],
    );
  }

  // gets called every time the widget need to re-render or build
  @override
  Widget build(BuildContext context) {
    // get the width and height of current screen the app is running on
    Size size = MediaQuery.of(context).size;

    // initialize two variables that will represent final width and height of the segmentation
    // and image preview on screen
    double finalW;
    double finalH;

    // when the app is first launch usually image width and height will be null
    // therefore for default value screen width and height is given
    if (_imageWidth == null && _imageHeight == null) {
      finalW = size.width;
      finalH = size.height;
    } else {
      // ratio width and ratio height will given ratio to
      // scale up or down the preview image
      double ratioW = size.width / _imageWidth;
      double ratioH = size.height / _imageHeight;

      // final width and height after the ratio scaling is applied
      finalW = _imageWidth * ratioW * .90;
      finalH = _imageHeight * ratioH * .50;
    }

    // Function to print the greeting to the user
    String greeting() {
      var hour = DateTime.now().hour;
      if (hour < 12) {
        return 'Good Morning';
      }
      if (hour < 17) {
        return 'Good Afternoon';
      }
      return 'Good Evening';
    }

    return Scaffold(
      // Appbar with heading and login button
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => DetectMain())),
        ),
        title: Text(
          "Agro Guru",
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.left,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.account_circle_rounded,
              color: Colors.white,
              size: 40,
            ),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Login()));
            },
          )
        ],
        backgroundColor: Colors.lightGreen.shade700,
        centerTitle: false,
      ),

      // View of the main page
      body: ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: <Widget>[
          ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: _image == null

                // Disorder description view
                ? <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                          left: 25, right: 14, top: 25, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              RichText(
                                text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: greeting(),
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 20)),
                                    TextSpan(
                                        text: ' User!',
                                        style: TextStyle(
                                            fontFamily: 'ConcertOne-Regular',
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20)),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                  'Browse and Detect the disorder in one click.'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    DisorderList(),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(55.0, 0.0, 0.0, 0.0),
                      child: Column(children: <Widget>[
                        SizedBox(
                          height: 128,
                          //width: 70.0,
                        ),
                        Text(
                          "Click to Upload -->",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        // Text(
                        //   "  ",
                        //   style: TextStyle(
                        //       fontSize: 16, fontWeight: FontWeight.w500),
                        // )
                      ]),
                    )
                  ]

                // View of prediction results with image
                : <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "",
                            style: TextStyle(fontSize: 22, color: Colors.teal),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Image.file(_image,
                              fit: BoxFit.fill, width: finalW, height: finalH),
                          SizedBox(
                            height: 10,
                          ),

                          // RaisedButton(
                          //   color: Colors.green,
                          //   onPressed: () => {
                          //     resultPage(_recognitions)
                          //   },
                          //   child: Text(
                          //     'Check Remedy',
                          //     style: TextStyle(
                          //         fontSize: 18.0, color: Colors.white),
                          //   ),
                          // )
                        ],
                      ),
                    ),
                  ],
          ),

          // To print the class of prediction
          Column(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 30),
                  child: printValue(_recognitions)),
            ],
          ),
        ],
      ),

      // Floating button for camera and gallery
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(color: Colors.white, size: 25),
        visible: dialVisible,
        curve: Curves.bounceInOut,
        onOpen: () => print('OPENING DIAL'),
        onClose: () => print('DIAL CLOSED'),
        tooltip: 'Toggle',
        heroTag: 'toggele-hero-tag',
        backgroundColor: Colors.lightGreen.shade700,
        foregroundColor: Colors.white,
        overlayOpacity: 0.7,
        elevation: 10.0,
        shape: CircleBorder(),
        children: [
          SpeedDialChild(
              child: Icon(
                Icons.camera,
                size: 24,
              ),
              backgroundColor: Colors.redAccent,
              label: 'Camera',
              labelStyle: TextStyle(
                fontSize: 18.0,
              ),
              onTap: () => selectFromCamera()),
          SpeedDialChild(
              child: Icon(
                Icons.image,
                size: 24,
              ),
              backgroundColor: Colors.blueAccent,
              label: 'Gallery',
              labelStyle: TextStyle(fontSize: 18.0),
              onTap: () => selectFromGallery()),
        ],
      ),
    );
  }

  //  void resultPage(BuildContext context, labelForHighest) {}

}
