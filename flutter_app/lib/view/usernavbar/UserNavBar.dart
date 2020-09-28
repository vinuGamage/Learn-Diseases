/*
*   Widget Name : UserNavBar stateful widget
*   Author : IT17134668
* */

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/view/diseaselist/UserDiseaseList.dart';
import 'package:flutterapp/view/userprofile/UserProfile.dart';

class UserNavBar extends StatefulWidget {
  String username;
  UserNavBar(this.username);
  @override
  _UserNavBarState createState() => _UserNavBarState(this.username);
}

class _UserNavBarState extends State<UserNavBar> {
  PageController _pageController;
  String username;
  _UserNavBarState(this.username);
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
          controller: _pageController,
        children: <Widget>[
          UserDiseaseList(this.username),
          UserProfile(this.username),
        ],
          onPageChanged: (int index) {
            setState(() {
              _pageController.jumpToPage(index);
            });
          }
      ),
      bottomNavigationBar: CurvedNavigationBar(
        animationCurve: Curves.easeInOutBack,
        index:0,
        items: <Widget>[
          Icon(Icons.list, size: 50,color: Colors.white,),
          Icon(Icons.account_circle, size: 50,color: Colors.white),
        ],
        color: Colors.blueAccent,
        backgroundColor: Colors.white,
        //buttonBackgroundColor: Colors.white,
        height: 50.0,
        onTap: (index) {
          print("INDEX########################## " + index.toString());
          //Handle button tap
          setState(() {
            _pageController.jumpToPage(index);
          });

        },
      ),

    );
  }
}

