/*
*   Widget Name : SliderHome stateful widget
*   Author : IT17134668
* */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/view/welcome/Welcome.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:intro_slider/intro_slider.dart';

class SliderHome extends StatefulWidget {
  @override
  _SliderHomeState createState() => _SliderHomeState();
}

class _SliderHomeState extends State<SliderHome> {
  //Create List of Slides
  List<Slide> slides = new List();

  //Create goToTab function
  Function goToTab;

  //Initialize Images
  @override
  void initState() {
    super.initState();

    slides.add(
      new Slide(
        title: "Register and Login",
        colorBegin: Color(0xff112c4a),
        colorEnd: Color(0xff112c4a),
        styleTitle: TextStyle(
            color: Colors.white,
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoMono'),
        pathImage: "assets/register.jpeg",
        foregroundImageFit: BoxFit.cover,
        description:
        "Create an account and register and login to the system",
        styleDescription: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontStyle: FontStyle.italic,
            fontFamily: 'Raleway'),

      ),
    );
    slides.add(
      new Slide(
        title: "Get Information About Diseases",
        colorBegin: Color(0xff112c4a),
        colorEnd: Color(0xff112c4a),
        styleTitle: TextStyle(
            color: Colors.white,
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoMono'),
        description:
        "Search on the diease to get to know more about it",
        styleDescription: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontStyle: FontStyle.italic,
            fontFamily: 'Raleway'),
        pathImage: "assets/diseases.jpeg",

      ),
    );

  }

  //Create Other functions
  void onDonePress() {
    // Back to the first tab
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Welcome()),
    );
  }

  //renderNextByn()
  Widget renderNextBtn() {
    return Icon(
      Icons.navigate_next,
      color: Colors.blueAccent,
      size: 35.0,
    );
  }

  //renderDoneBtn()
  Widget renderDoneBtn() {
    return Icon(
      Icons.done,
      size: 35,
      color: Colors.blueAccent,
    );
  }

  /*Widget renderSkipBtn() {
    return Icon(
      Icons.skip_next,
      color: Color(0xffffcc5c),
    );
  }*/

  //Custom Tabs
  List<Widget> renderListCustomTabs() {
    List<Widget> tabs = new List();
    for (int i = 0; i < slides.length; i++) {
      Slide currentSlide = slides[i];
      tabs.add(Container(
        width: double.infinity,
        height: double.infinity,
        child: Container(
          margin: EdgeInsets.only(bottom: 30.0, top: 30.0),
          child: ListView(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top:80.0),
                child: Text(
                  currentSlide.title,
                  style: currentSlide.styleTitle,
                  textAlign: TextAlign.center,
                ),
                margin: EdgeInsets.only(top: 20.0),
              ),
              Container(
                padding: EdgeInsets.only(top:40.0),
                child: GestureDetector(
                    child: Image.asset(
                      currentSlide.pathImage,
                      width: 100.0,
                      height: 300.0,
                      fit: BoxFit.contain,
                    )),
              ),
              Container(
                child: Text(
                  currentSlide.description,
                  style: currentSlide.styleDescription,
                  textAlign: TextAlign.center,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                ),
                margin: EdgeInsets.only(top: 20.0,left:50.0,right:50.0),
              ),
            ],
          ),
        ),
      ));
    }
    return tabs;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: IntroSlider(
          // List slides
          slides: this.slides,

          /*// Skip button
          //renderSkipBtn: this.renderSkipBtn(),
          colorSkipBtn: Color(0x33ffcc5c),
          highlightColorSkipBtn: Color(0xffffcc5c),*/

          // Next button
          renderNextBtn: this.renderNextBtn(),

          // Done button
          renderDoneBtn: this.renderDoneBtn(),
          onDonePress: this.onDonePress,
          colorDoneBtn: Colors.white,
          highlightColorDoneBtn: Colors.white30,

          // Dot indicator
          colorDot: Colors.white,
          sizeDot: 13.0,

          // Tabs
          listCustomTabs: this.renderListCustomTabs(),
          backgroundColorAllSlides: Color(0xff112c4a),
          refFuncGoToTab: (refFunc) {
            this.goToTab = refFunc;
          },

          // Show or hide status bar
          shouldHideStatusBar: true,

        ),
      ),
    );
  }
}
