import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:agro_guru_logncreate/PageTwo.dart';


void main() => runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: agroGuruLognCreate(),
    )
);

class agroGuruLognCreate extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[

                          Padding(
                            padding: EdgeInsets.all(100.0),
                            child: Image(
                              image: AssetImage('assets/agro.jpg'),
                            ),
                          ),

                          SizedBox(height: 100.0,
                            child: Container(
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            color: Colors.white,
                            height: 50.0,
                            padding: EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 1.0),
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              color: Colors.lightGreenAccent,
                              onPressed: () async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => agroGuruLogin()),
                                );
                              },
                              child: Center(
                                child: Text(
                                  'Log In',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            color: Colors.white,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Expanded(
                                    child: Divider(
                                      height: 65.0,
                                      indent: 50.0,
                                      endIndent: 10.0,
                                      color: Colors.black,
                                    )
                                ),

                                Text("OR"),

                                Expanded(
                                    child: Divider(
                                      indent: 10.0,
                                      endIndent: 50.0,
                                      color: Colors.black,
                                    )
                                ),
                              ]
                            ),
                          ),
                          Container(
                            color: Colors.white,
                            height: 50.0,
                            padding: EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 1.0),
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: Colors.black
                                ),
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              color: Colors.white,
                              onPressed: () {},
                              child: Center(
                                child: Text(
                                  'Create an account',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 80.0,
                            child: Container(
                              color: Colors.white,
                            ),
                          ),
                        ],


                      ),
                    ),
                  ),
              );
          },
        )
    );
  }

}
