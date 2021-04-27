import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'Login.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String _email, _password, _cpassword, _username;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   leading: IconButton(
      //     icon: Icon(Icons.arrow_back, color: Colors.white),
      //     onPressed: () => Navigator.push(
      //         context, MaterialPageRoute(builder: (context) => Login())),
      //   ),
      //   title: Text(
      //     "Agro Guru",
      //     style: TextStyle(color: Colors.white),
      //     textAlign: TextAlign.left,
      //   ),
      //   backgroundColor: Colors.lightGreen.shade700,
      //   centerTitle: false,
      // ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              // SizedBox(
              //   height: 45,
              // ),
              Image(
                image: AssetImage("assets/def.png"),
                //height: 180,
                fit: BoxFit.fitHeight,
              ),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true,
                  labelText: "Username",
                  prefixIcon: Icon(
                    Icons.person,
                    color: Colors.lightGreen.shade700,
                  ),
                ),
                validator: validateUsername,
                autovalidate: false,
                onSaved: (input) => _username = input,
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true,
                  labelText: "Email ID",
                  prefixIcon: Icon(
                    Icons.email,
                    color: Colors.lightGreen.shade700,
                  ),
                ),
                validator: validateEmail,
                autovalidate: false,
                onSaved: (input) => _email = input,
              ),
              SizedBox(height: 20),
              TextFormField(
                validator: validatePassword,
                onSaved: (input) => _password = input,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true,
                  labelText: "Password",
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Colors.lightGreen.shade700,
                  ),
                ),
                obscureText: true,
              ),
              SizedBox(height: 20),
              TextFormField(
                validator: validatePassword,
                onSaved: (input) => _password = input,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true,
                  labelText: "Confirm Password",
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Colors.lightGreen.shade700,
                  ),
                ),
                obscureText: true,
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                  height: 50,
                  width: 380,
                  child: RaisedButton(
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                        side: BorderSide(color: Colors.lightGreen.shade700)),
                    onPressed: signUp,
                    color: Colors.lightGreen.shade700,
                    textColor: Colors.white,
                    child: Text("Sign UP".toUpperCase(),
                        style: TextStyle(fontSize: 17)),
                  )),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                alignment: Alignment.bottomCenter,
                child: Center(
                    child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 95,
                    ),
                    Text(
                      'Already have an account ?',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Login()));
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(
                            color: Colors.lightGreen.shade700,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    )
                  ],
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Firebase Authentication
  Future<void> signUp() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      try {
        AuthResult auth = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: _email, password: _password);
        Navigator.of(context).pop();
        Fluttertoast.showToast(msg: 'You have successfully Registered');
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Login()));
      } catch (e) {
        print(e.message);
      }
    }
  }

  // Email Validation
  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (value.isEmpty) {
      return 'Please enter the email address';
    } else if (!regex.hasMatch(value)) {
      return 'Invalid Email! Please Enter the Valid Email address';
    }
    return null;
  }

  // Password Validation
  String validatePassword(String value) {
    if (value.isEmpty) {
      return ' Please enter the Password';
    } else if (value.length < 6) {
      return "Your password needs to be atleast 6 characters";
    }
    return null;
  }

  // Username Validation
  String validateUsername(String value) {
    if (value.isEmpty) {
      return 'Please enter Username';
    }
    return null;
  }
}
