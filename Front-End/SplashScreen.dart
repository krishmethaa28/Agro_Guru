import 'package:flutter/material.dart';
import 'package:agro_guru_logncreate/PageOne.dart';
import 'dart:async';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _modeCheckForSession().then(
        (status) {
          if (status) {
            _navigateToLogin();
          }
        }
    );
  }

  Future<bool> _modeCheckForSession() async{
    await Future.delayed(Duration(milliseconds: 5000), () {});

    return true;
  }

  void _navigateToLogin() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
          builder: (BuildContext context) => agroGuruLognCreate()
      )
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreenAccent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Image(image: AssetImage('assets/agro.jpg'),),
          ),
        ],
        
      ),
    );
  }
}
