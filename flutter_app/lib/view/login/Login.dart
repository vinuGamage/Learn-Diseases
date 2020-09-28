/*
*   Widget Name : Login stateful widget
*   Author : IT17134668
* */

import 'package:flutter/material.dart';
import 'package:flutterapp/view/adminhome/AdminHome.dart';
import 'package:flutterapp/view/register/Register.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:toast/toast.dart';
import 'package:flutterapp/view/userhome/UserHome.dart';

class Login extends StatefulWidget {

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  String username,password;
  final db = Firestore.instance;
  final GlobalKey<FormState> formKey = new GlobalKey();
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
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            textDirection: TextDirection.ltr,

            children: <Widget>[
              Text(
                'Log In',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    wordSpacing: 1.5,
                    fontFamily: 'Montserrat'
                ),
              ),
              SizedBox(height: 20,),
              Text(
                'Welcome !',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    wordSpacing: 1.5,
                    fontFamily: 'Pompiere'
                ),
              ),
              Text(
                'Login to your Learn Disease App Account',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    wordSpacing: 1.5,
                    fontFamily: 'Montserrat'
                ),
              ),
              SizedBox(height: 32,),
              new TextFormField(
                textAlign: TextAlign.center,
                style: TextStyle( color: Colors.white),
                decoration: new InputDecoration(
                  hintText: 'Username',
                  hintStyle: TextStyle(
                    color: Colors.white,
                  ),
//                fillColor: Colors.white,
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide( color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide( color: Colors.white),
                  ),
                ),
                onSaved: (val) => username = val,
                validator: (val) {
                  if(val.length==0) {
                    return "Username cannot be empty";
                  }else{
                    return null;
                  }
                },
                //keyboardType: TextInputType.emailAddress,

              ),
              SizedBox(height: 20,),
              new TextFormField(
                textAlign: TextAlign.center,
                style: TextStyle( color: Colors.white),
                decoration: new InputDecoration(
                  hintText: 'Password',
                  hintStyle: TextStyle(
                    color: Colors.white,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide( color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                onSaved: (val) => password = val,
                validator: (val) {
                  if(val.length==0) {
                    return "Password cannot be empty";
                  }else{
                    return null;
                  }
                },

                obscureText: true,
              ),
              SizedBox(height: 40,),
              Container(
                height: 50.0,
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
                              "LOGIN",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Montserrat',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                              ),
                            ),
                            onTap: validateLogin,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15,),
              Container(
                height: 50.0,
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
                              "SIGN UP",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Montserrat',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                              ),
                            ),
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Register()),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  // validating user login
  void validateLogin() {
    String pass ="";

    if (formKey.currentState.validate()) {
      print('form key :::::::' + formKey.currentContext.toString());
      formKey.currentState.save();
      print('USERNAME ********************** ' + username);
      print('PASSWORD ********************** ' + password);
        var document =Firestore.instance.collection('users').document('$username');
        document.get().then((doc)   {
          //if there are documents
          if (doc.exists){
           //username is not admin
            if(!(username=='admin')){
              String pass = doc.data.values.elementAt(1);
              print('PASSWORD FROM DATABASE ********************** ' + pass);
              if(pass==password){
                //where passwords are matching
                Toast.show("$username You have successfully logged in", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserHome(username)),
                );
                //create toast and login
              }else {
                //error message username password incorrect
                Toast.show("Your password or username is incorrect", context,
                    duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
              }
            }
            else{
              //where username is admin
              String pass = doc.data.values.elementAt(3);
              //success message
              if(pass==password){
                Toast.show("$username You have successfully logged in", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdminHome()),
                );
                //create toast and login
              }else {
                //error message username password incorrect
                Toast.show("Your password or username is incorrect", context,
                    duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
              }
            }
          }
          else
            print('no user available');
        }).catchError((e){
          print('error validating user ' +e);
        });
    }
  }

}

