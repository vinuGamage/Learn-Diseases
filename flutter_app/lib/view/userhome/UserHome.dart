/*
*   Widget Name : UserHome stateful widget
*   Author : IT17134668
* */

import 'package:flutter/material.dart';
import 'package:flutterapp/view/login/Login.dart';
import 'package:flutterapp/view/usernavbar/UserNavBar.dart';

class UserHome extends StatefulWidget {
  String username;
  UserHome(this.username);
  @override
  _UserHomeState createState() => _UserHomeState(this.username);
}

class _UserHomeState extends State<UserHome> {
  String username;
  _UserHomeState(this.username);
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
      body: UserNavBar(this.username),
    );
  }

}
