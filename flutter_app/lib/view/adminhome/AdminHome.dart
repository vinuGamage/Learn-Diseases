/*
*   Widget Name : AdminHome stateful widget
*   Author : IT17137492
* */

import 'package:flutter/material.dart';
import 'package:flutterapp/view/adminnavbar/AdminNavBar.dart';
import 'package:flutterapp/view/login/Login.dart';

class AdminHome extends StatefulWidget {

  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        title: Text("Learn Diseases", style: TextStyle(color: Colors.white),),
        actions: <Widget>[
          IconButton(
            icon: Icon(
                Icons.account_balance_wallet,
              color: Colors.white,
            ),
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Login()),
              );
            },
          )
        ],
      ),
      body: AdminNavBar(),
    );
  }
}
