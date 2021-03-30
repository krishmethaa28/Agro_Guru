import 'package:agro_guru_logncreate/PageTwo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:agro_guru_logncreate/PageFour.dart';
import 'package:agro_guru_logncreate/drawer.dart';



void main() => runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: agroGuruLeafFruitRoot(),
    )
);

class agroGuruLeafFruitRoot extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        builder: (context) => agroGuruLogin()),
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
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return
              Container(
                color: Colors.lightGreen,
                child: SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: viewportConstraints.maxHeight,
                    ),

                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: <Widget>[
                          Container(
                            height: 75.0,
                            padding: EdgeInsets.fromLTRB(45.0, 0.0, 45.0, 0.0),
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              color: Colors.white,
                              onPressed: () async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => agroGuruImagePicker()),
                                );
                              },
                              child: Center(
                                child: Text(
                                  'Leaf',
                                  style: TextStyle(
                                    fontSize: 28.0,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 60.0,),
                          Container(
                            height: 75.0,
                            padding: EdgeInsets.fromLTRB(45.0, 0.0, 45.0, 0.0),
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              color: Colors.white,
                              onPressed: () async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => agroGuruImagePicker()),
                                );
                              },
                              child: Center(
                                child: Text(
                                  'Fruit',
                                  style: TextStyle(
                                    fontSize: 28.0,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 60.0,),
                          Container(
                            height: 75.0,
                            padding: EdgeInsets.fromLTRB(45.0, 0.0, 45.0, 0.0),
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              color: Colors.white,
                              onPressed: () async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => agroGuruImagePicker()),
                                );
                              },
                              child: Center(
                                child: Text(
                                  'Root',
                                  style: TextStyle(
                                    fontSize: 28.0,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                    ),
                  ),
                ),
              );
          },
        ));
  }

}
