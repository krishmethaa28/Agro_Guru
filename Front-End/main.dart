import 'package:animated_splash/animated_splash.dart';
import 'package:flutter/material.dart';

import 'Login.dart';
import 'Prediction.dart';

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      // Onboarding page
      // home: AnimatedSplash(
      //   //imagePath: 'assets/icon.PNG',
      //   imagePath: 'assets/1.jpeg',

        home: Login(),
        // duration: 2500,
        // type: AnimatedSplashType.StaticDuration,
      )
      //)
      );
}
