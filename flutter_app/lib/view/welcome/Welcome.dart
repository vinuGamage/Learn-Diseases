/*
*   Widget Name : Welcome stateful widget
*   Author : IT17134668
* */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/view/login/Login.dart';
import 'package:flutterapp/view/register/Register.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {

    return
      Scaffold(

        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
                //colorFilter: new ColorFilter.mode(Colors.lightBlue[200].withOpacity(0.1), BlendMode.colorBurn),
              colorFilter: new ColorFilter.mode(Colors.transparent.withOpacity(0.5), BlendMode.colorBurn),
                image: AssetImage('assets/background1.jpg'),
                fit: BoxFit.cover
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Welcome',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 50.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Prompiere',
                ),
              ),
              SizedBox(height: 100,),
              Container(
                height: 1,
                width: 150,
                color: Colors.white,
              ),
              SizedBox(height: 20,),
              Text(
                "Get to know about diseases",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Prompiere',
                ),
              ),
              SizedBox(height: 100,),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      width: 2,
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(60))
                ),
                height: 50,
                width: 300,
                child: Center(
                    child: RaisedButton(
                      child: Text("Sign Up", style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold,fontFamily: 'Prompiere',),),
                      color: Colors.transparent,
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Register()),
                        );
                      },
                    )
                ),
              ),
              SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 1,
                    width: 60,
                    color: Colors.white,
                  ),
                  Text("OR SKIP", style: TextStyle(fontSize: 16, color: Colors.white),),
                  Container(
                    height: 1,
                    width: 60,
                    color: Colors.white,
                  ),
                ],
              ),
              SizedBox(height: 15,),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      width: 2,
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(60))
                ),
                height: 50,
                width: 300,
                child: Center(
                    child: RaisedButton(
                      child: Text("Login", style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold,fontFamily: 'Prompiere',),),
                      color: Colors.transparent,
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Login()),
                        );
                      },
                    )
                ),
              ),
            ],
          ),
        ),
      );
  }
}