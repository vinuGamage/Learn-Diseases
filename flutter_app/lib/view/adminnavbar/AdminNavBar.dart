/*
*   Widget Name : AdminNavBar stateful widget
*   Author : IT17137492
* */

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/view/adddisease/AddDisease.dart';
import 'package:flutterapp/view/diseaselist/DiseaseList.dart';
import 'package:flutterapp/view/updatedisease/UpdateForm.dart';

class AdminNavBar extends StatefulWidget {

  @override
  _AdminNavBarState createState() => _AdminNavBarState();
}

class _AdminNavBarState extends State<AdminNavBar> {

  PageController _pageController;

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
            DiseaseList(),
            AddDisease(),
            UpdateForm(),
            //UserProfile()
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
          Icon(Icons.list, size: 30,color: Colors.white,),
          Icon(Icons.add_circle_outline, size: 30,color: Colors.white,),
          Icon(Icons.update, size: 30,color: Colors.white,),
        ],
        color: Colors.blueAccent,
        backgroundColor: Colors.white,
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
