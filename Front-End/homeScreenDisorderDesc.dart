import 'package:cropmedic/Disorder/CitrusCanker.dart';
import 'package:cropmedic/Disorder/EmergentDisease.dart';
import 'package:cropmedic/Disorder/FungiDisease.dart';
import 'package:cropmedic/Disorder/RottenApples.dart';
import 'package:flutter/material.dart';
import 'Disorder/PepperBellBacterialSpot.dart';
import 'Disorder/TomatoBacterialSpot.dart';

class DisorderList extends StatelessWidget {
  // Trending disorders
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: 220,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.all(10.0),
        children: <Widget>[
          // Pepper Bacterial Spot on trending
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PepperBellBacterialSpot()),
              );
            },
            child: disorder('assets/pepperBellBacSpot.JPG', 'Trending',
                'Pepper Bell Bacterial Spot'),
          ),
          // Citrus Canker on trending
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CitrusCanker()),
              );
            },
            child: disorder(
                'assets/CitrusCanker.jpg', 'Trending', 'Citrus Canker'),
          ),
          // Emergent Disease on trending
          GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EmergentDisease()),
                );
              },
              child:
                  disorder('assets/emDi.jpg', 'Trending', 'EmergentDisease')),
          // Tomato Bacterial Spot in trending
          GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TomatoBacterialSpot()),
                );
              },
              child: disorder('assets/tomBacSpot.JPG', 'Trending',
                  'Tomato Bacterial Spot')),
          // Rotten Apple on trending
          GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RottenApples()),
                );
              },
              child:
                  disorder('assets/RotApple.png', 'Trending', 'Rotten Apple')),
          // Fungi Disease on trending
          GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FungiDisease()),
                );
              },
              child:
                  disorder('assets/fungi3.jpg', 'Trending', 'Fungi Disease')),
          GestureDetector()
        ],
      ),
    );
  }

  // disorder widget
  Widget disorder(
    String imageurl,
    String tag,
    String name,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Stack(
            children: <Widget>[
              Image.asset(
                imageurl,
                height: 340,
                width: 230,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 16,
                left: 140,
                child: Container(
                    height: 25.0,
                    width: 80.00,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3.0),
                        color: Color(0xff0F0F0F),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xff0F0F0F).withOpacity(0.3),
                          )
                        ]),
                    child: Center(
                      child: Text(
                        tag,
                        style: TextStyle(color: Colors.white),
                      ),
                    )),
              )
            ],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 5,
          margin: EdgeInsets.all(10),
        ),
        Padding(
          padding: EdgeInsets.only(left: 16),
          child: Text(
            name,
            style: TextStyle(fontFamily: 'ConcertOne-Regular'),
          ),
        ),
      ],
    );
  }
}
