/*
*   Widget Name : updateDisease stateful widget
*   Author : IT17137492
* */

import 'package:flutter/material.dart';
import 'package:flutterapp/view/adminhome/AdminHome.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:toast/toast.dart';

class UpdateDisease extends StatefulWidget {
  String name;
  String description;
  String causedby;
  String symptoms;
  UpdateDisease(this.name,this.description,this.causedby,this.symptoms);

  @override
  _UpdateDiseaseState createState() => _UpdateDiseaseState(this.name,this.description,this.causedby,this.symptoms);
}

class _UpdateDiseaseState extends State<UpdateDisease> {
  String name;
  String description;
  String causedby;
  _UpdateDiseaseState(this.name,this.description,this.causedby,this.symptoms);
  String symptoms;
  final _formKey = GlobalKey<FormState>();
  TextEditingController controller,descriptionController,causedbyController,symptomsController;
  @override
  void initState() {
    controller = TextEditingController(text: this.name);
    descriptionController = TextEditingController(text: this.description);
    causedbyController =TextEditingController(text: this.causedby);
    symptomsController = TextEditingController(text: this.symptoms);
  }


  @override
  Widget build(BuildContext context) {
    //Navigator.pop(context,true);
    return Container(
      padding: EdgeInsets.only(top: 60.0,bottom: 90.0),
      child: AlertDialog(
        content: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Container(
                child: this.causedby=='virus' ? Container(
                  padding: EdgeInsets.only(left: 30.0),
                  height:100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(100),
                    image: DecorationImage(
                      image: AssetImage('assets/virus.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),

                ) : Container(
                  padding: EdgeInsets.only(left: 30.0),
                  height:100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(100),
                    image: DecorationImage(
                      image: AssetImage('assets/bacteria.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),

                ),

              ),
              SizedBox(height:15.0),
              Text(
                'Update Disease',
                style: TextStyle(
                  fontSize: 30.0,
                ),
              ),
              SizedBox(height:15.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Disease Name ",
                  labelStyle: TextStyle(
                      fontSize: 20.0
                  ),
                  //hintText: firstname,
                  //helperText: _firstNameController.text,
                ),
                controller: controller,
                onSaved: (val){
                  name = val;
                },
                readOnly: true,
                //controller: _firstNameController,
              ),
              SizedBox(height: 5.0,),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Description ",
                  labelStyle: TextStyle(
                      fontSize: 20.0
                  ),
                ),
                controller: descriptionController,
                onSaved: (val){
                  description = val;
                },
              ),
              SizedBox(height: 15.0,),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Symptoms ",
                  labelStyle: TextStyle(
                      fontSize: 20.0
                  ),
                ),
                controller: symptomsController,
                onSaved: (val){
                  symptoms = val;
                },
              ),
              SizedBox(height: 5.0,),
              new DropdownButton<String>(
                focusColor: Colors.black26,
                iconDisabledColor: Colors.black26,
                iconEnabledColor: Colors.black26,
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
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 15.0,),
              Container(
                padding: EdgeInsets.only(left: 30.0,top: 20.0,right: 30.0),
                height: 50.0,
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.blueAccent,
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
                                color: Colors.blueAccent,
                                fontFamily: 'Montserrat',
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1,
                              ),
                            ),
                            onTap: updateDisease,
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

  //update disease profile
  void updateDisease() async{
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      Firestore.instance.collection("diseases").document("$name").updateData({
        'name': '$name',
        'description': '$description',
        'causedby': '$causedby',
        'symptoms':'$symptoms'
      });//updating documents
      Toast.show("$name disease successfully updated", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AdminHome()),
      );
    }

  }
}


