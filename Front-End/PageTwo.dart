import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:agro_guru_logncreate/PageOne.dart';
import 'package:agro_guru_logncreate/PageThree.dart';

void main() => runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: agroGuruLogin(),
    )
);


class agroGuruLogin extends StatelessWidget {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  void validate() {
    if(formkey.currentState.validate()) {
      print("Validated");
    } else {
      print("Not Validated");
    }
  }

  String validateUsername(String value) {
    Pattern pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])';
    RegExp regex = new RegExp(pattern);
    print(value);
    if (value.isEmpty) {
      return '* Username Required';
    } else {
      if (!regex.hasMatch(value))
        return '* Invalid Username';
      else {
        if (value.length < 8) {
          return 'Username too short';
        }
      }
        return null;
    }
  }

  String validatePassword(String value) {
    Pattern pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])';
    RegExp regex = new RegExp(pattern);
    print(value);
    if (value.isEmpty) {
      return '* Password Required';
    } else {
      if (!regex.hasMatch(value))
        return '* Invalid password';
      else {
        if (value.length < 8) {
          return 'Password too short';
        }
      }
        return null;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 5.0),

          ),

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
                icon: Icon(Icons.near_me),
                iconSize: 35.0,
              ),
              alignment: Alignment.topLeft,
            ),
          ),
        ],
      ),
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return
              Container(
                color: Colors.lightGreen,
                child: SingleChildScrollView(
                  child: Form(
                    key: formkey,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: viewportConstraints.maxHeight,
                      ),

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(bottom: 5.0),
                            child: Container(
                              child: IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => agroGuruLognCreate()),
                                  );
                                },
                                icon: Icon(Icons.cancel_outlined),
                                iconSize: 35.0,
                              ),
                              alignment: Alignment.topLeft,
                            ),
                          ),

                          Container(
                            color: Colors.white,
                            padding: EdgeInsets.only(top: 50.0),
                            child: Text('Log In',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 28,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(
                            color: Colors.white,
                            padding: EdgeInsets.only(top: 35.0, left: 40.0, right: 40.0),
                            child: Center(
                              child: Column(
                                children: <Widget>[
                                  TextFormField(
                                    validator: validateUsername,
                                    decoration: InputDecoration(
                                      labelText: 'User name',
                                      labelStyle: TextStyle(
                                          color: Colors.grey[500],
                                          fontSize: 15
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),


                          Container(
                            color: Colors.white,
                            padding: EdgeInsets.only(top: 35.0, left: 40.0, right: 40.0),
                            child: Column(
                              children: <Widget>[
                                TextFormField(
                                  validator: validatePassword,
                                  decoration: InputDecoration(
                                    labelText: 'Password',
                                    labelStyle: TextStyle(
                                        color: Colors.grey[500],
                                        fontSize: 15
                                    ),
                                  ),
                                  obscureText: true,
                                ),
                              ],
                            ),
                          ),

                          Container(
                            color: Colors.white,
                            alignment: Alignment(0.7, 0.0),
                            padding: EdgeInsets.only(top: 25.0, bottom: 45.0),
                            child: InkWell(
                              child: Text('Forgot Password?',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                          ),
                          Container(
                            color: Colors.white,
                            height: 50.0,
                            padding: EdgeInsets.fromLTRB(40.0, 0.0, 40.0, 1.0),
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              color: Colors.lightGreenAccent,
                              onPressed: validate,
                              child: Center(
                                child: Text(
                                  'Log In',
                                  style: TextStyle(
                                    fontSize: 22.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20.0,
                            child: Container(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
          },
        ));
  }
}