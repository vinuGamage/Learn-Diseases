/*
*   Widget Name : Register stateful widget
*   Author : IT17134668
* */

import 'package:flutter/material.dart';
import 'package:flutterapp/view/login/Login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:toast/toast.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  String id;
  final db = Firestore.instance;
  final _formKey = GlobalKey<FormState>();
  String firstName;
  String lastName;
  String username;
  String password;
  String sex;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(30.0),
        decoration: BoxDecoration(
          image: DecorationImage(
              colorFilter: new ColorFilter.mode(Colors.grey[900].withOpacity(0.3), BlendMode.hardLight),
              image: AssetImage('assets/background2.jpeg'),
              fit: BoxFit.cover
          ),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            textDirection: TextDirection.ltr,

            children: <Widget>[
              Text(
                'Register',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    wordSpacing: 1.5,
                    fontFamily: 'gothic'
                ),
              ),
              SizedBox(height: 10,),
              TextFormField(
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
                decoration: new InputDecoration(
                  hintText: 'First Name',
                  hintStyle: TextStyle(
                    color: Colors.white,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                onSaved: (val) => firstName = val,
                validator: (val) {
                  if (val.length == 0) {
                    return "First name cannot be empty";
                  } else {
                    return null;
                  }
                },
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 10,),
               TextFormField(
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
                decoration: new InputDecoration(
                  hintText: 'Last Name',
                  hintStyle: TextStyle(
                    color: Colors.white,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                onSaved: (val) => lastName = val,
                validator: (val) {
                  if (val.length == 0) {
                    return "Last name cannot be empty";
                  } else {
                    return null;
                  }
                },
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 10,),
              TextFormField(
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
                decoration: new InputDecoration(
                  hintText: 'Username',
                  hintStyle: TextStyle(
                    color: Colors.white,
                  ),
//                fillColor: Colors.white,
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                onSaved: (val) => username = val,
                validator: (val) {
                  if (val.length == 0) {
                    return "Username cannot be empty";
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(height: 10,),
              TextFormField(
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
                decoration: new InputDecoration(
                  hintText: 'Password',
                  hintStyle: TextStyle(
                    color: Colors.white,
                  ),
//                fillColor: Colors.white,
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                obscureText: true,
                onSaved: (val) => password = val,
                validator: (val) {
                  if (val.length == 0) {
                    return "Password cannot be empty";
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(height: 10,),
              new DropdownButton<String>(
                focusColor: Colors.white,
                iconDisabledColor: Colors.white,
                iconEnabledColor: Colors.white,
                hint: Text(
                    'Select gender',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16
                  ),
                ),
                items: <String>['Male', 'Female'].map((String value) {
                  return new DropdownMenuItem<String>(
                    value: value,
                    child: new Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    this.sex = value;
                  });
                },
                value: this.sex,
                style: new TextStyle(
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10,),
              Container(
                height: 34.0,
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                        style: BorderStyle.solid,
                        width: 1.0,
                      ),
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Center(
                          child: InkWell(
                            child: Text(
                              "REGISTER",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'gothic',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                              ),
                            ),
                            onTap: createData,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Already have an account ?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      wordSpacing: 1.5,
                      fontFamily: 'gothic'
                    ),
                  ),
                  InkWell(
                    child: Text(
                      ' Sign In',
                      style: TextStyle(
                        color:  Colors.brown[500],
                        fontSize: 16.0,
                        wordSpacing: 1.5,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'gothic'
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  //Registering user to the application
  void createData() async {
    if (_formKey.currentState.validate()) {
      print('form key :::::::' + _formKey.currentContext.toString());
      _formKey.currentState.save();
      print('firstname ::::::::::::' + firstName);
      var document =Firestore.instance.collection('users').document('$username');
      document.get().then((doc) {
        //no documents exists
        if(!doc.exists){
          db.collection("users").document("$username").setData({
            'firstname': '$firstName',
            'lastname': '$lastName',
            'username': '$username',
            'password': '$password',
            'sex': '$sex'
          });//adding data
          Toast.show("$username You have successfully registered", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Login()),
          );
        }else{
          Toast.show("Username $username already exists. Please use a different username", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Register()),
          );
        }
      });
    }
  }

}