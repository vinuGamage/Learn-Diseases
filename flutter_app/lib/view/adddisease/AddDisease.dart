/*
* Widget Name : AddDisease stateful widget
* Author : IT17137492
* */

import 'package:flutter/material.dart';
import 'package:flutterapp/view/adminhome/AdminHome.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:toast/toast.dart';

class AddDisease extends StatefulWidget {
  @override
  _AddDiseaseState createState() => _AddDiseaseState();
}

class _AddDiseaseState extends State<AddDisease> {
  String id;
  final db = Firestore.instance;
  final _formKey = GlobalKey<FormState>();
  String name;
  String causedby;
  String description;
  String symptoms;
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(30.0),
        decoration: BoxDecoration(
          image: DecorationImage(
              colorFilter: new ColorFilter.mode(Colors.transparent.withOpacity(0.2), BlendMode.colorBurn),
              image: AssetImage('assets/background3.jpeg'),
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
                'Add Disease',
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
                  hintText: 'Disease Name',
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
                onSaved: (val) => name = val,
                validator: (val) {
                  if (val.length == 0) {
                    return "Disease name cannot be empty";
                  } else {
                    return null;
                  }
                },
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 5,),
              TextFormField(
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
                decoration: new InputDecoration(
                  hintText: 'Description',
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
                onSaved: (val) => description = val,
                validator: (val) {
                  if (val.length == 0) {
                    return "Description cannot be empty";
                  } else {
                    return null;
                  }
                },
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 5,),
              TextFormField(
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
                decoration: new InputDecoration(
                  hintText: 'Symptoms',
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
                onSaved: (val) => symptoms = val,
                validator: (val) {
                  if (val.length == 0) {
                    return "Symptoms cannot be empty";
                  } else {
                    return null;
                  }
                },
                //keyboardType: TextInputType.password,
              ),
              SizedBox(height: 5,),
              new DropdownButton<String>(
                focusColor: Colors.white,
                iconDisabledColor: Colors.white,
                iconEnabledColor: Colors.white,
                hint: Text(
                  'Caused By',
                  style: TextStyle(
                      color: Colors.white
                  ),
                ),
                items: <String>['virus', 'bacteria'].map((String value) {
                  return new DropdownMenuItem<String>(
                    value: value,
                    child: new Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    this.causedby = value;
                  });
                },
                value: this.causedby,
                style: new TextStyle(
                  color: Colors.black54,
                ),
              ),
              SizedBox(height: 5,),
              Container(
                height: 37.0,
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
                              "ADD DISEASE",
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

            ],
          ),
        ),
      ),
    );
  }

  //Add the disease to the application
  void createData() async {
    if (_formKey.currentState.validate()) {
      print('form key :::::::' + _formKey.currentContext.toString());
      _formKey.currentState.save();
      var document =Firestore.instance.collection('diseases').document('$name');
      document.get().then((doc) {
        //If documents exists
        if(!doc.exists){
          db.collection("diseases").document("$name").setData({
            'name': '$name',
            'description': '$description',
            'causedby': '$causedby',
            'symptoms': '$symptoms'
          });
          Toast.show("$name was successfully added", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AdminHome()),
          );
        }else{
          //Documents does not exists
          Toast.show("Information on disease $name already exists. Please enter another new disease.", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddDisease()),
          );
        }
      });

    }
  }


}
