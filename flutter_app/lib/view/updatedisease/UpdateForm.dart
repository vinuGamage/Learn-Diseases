/*
*   Widget Name : UpdateForm class
*   Author : IT17137492
* */

import 'package:flutter/material.dart';
import 'package:flutterapp/view/adminhome/AdminHome.dart';
import 'package:flutterapp/view/disease/DiseaseInfo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:toast/toast.dart';

class UpdateForm extends StatefulWidget {
  @override
  _UpdateFormState createState() => _UpdateFormState();
}

class _UpdateFormState extends State<UpdateForm> {
  String name;
  final GlobalKey<FormState> formKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(30.0),
        decoration: BoxDecoration(
          image: DecorationImage(
              colorFilter: new ColorFilter.mode(Colors.transparent.withOpacity(0.2), BlendMode.colorBurn),
              image: AssetImage('assets/background4.jpeg'),
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
              Text("Update Details of a Disease", style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),),
              SizedBox(height: 20,),
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
              SizedBox(height: 20,),
              Container(
                padding: EdgeInsets.only(
                    left: 70.0, top: 20.0, right: 70.0),
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
                              "UPDATE DISEASE",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Montserrat',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                              ),
                            ),
                            /* onTap: ()=>Navigator.of(context).push(new MaterialPageRoute(builder: (_)=>new UpdateProfile(record.firstname,record.lastname,record.password,record.username)),)
                              .then((val)=>val?_getRequests():null)*/
                            onTap: navigateToUpdateDisease,


                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                    left: 70.0, top: 20.0, right: 70.0),
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
                              "DELETE DISEASE",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Montserrat',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                              ),
                            ),
                            onTap: deleteRecord,
                            /* onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => Register()),
                                );
                              },*/
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

  //deleting disease record
  void deleteRecord() {
    if (formKey.currentState.validate()) {
      print('form key :::::::' + formKey.currentContext.toString());
      formKey.currentState.save();
      print('USERNAME ********************** ' + name);
      var document = Firestore.instance.collection('diseases').document('$name');
      document.get().then((doc) {
        //checking document existence
        if (doc.exists) {
          print('Documents exists');
          //deleting disease
          Firestore.instance.collection('diseases').document(name).delete();
          Toast.show("$name disease successfully deleted", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AdminHome()),
          );
        } else {
          Toast.show("$name disease doesnt exists.", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
          print('ERORRRRRRRRRRRRRRRR');
        }
      });
    }
  }

  //navigating to updatedisease page
  void navigateToUpdateDisease(){
    if (formKey.currentState.validate()) {
      print('form key :::::::' + formKey.currentContext.toString());
      formKey.currentState.save();
      print('disease ********************** ' + name);
      var document = Firestore.instance.collection('diseases').document('$name');
      document.get().then((doc) {
        if (doc.exists) {
          print('Documents exists');
          //Firestore.instance.collection('diseases').document(name).delete();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DiseaseInfo(name)),
          );
        } else {
          print('ERORRRRRRRRRRRRRRRR');
        }
      });
    }
  }
}