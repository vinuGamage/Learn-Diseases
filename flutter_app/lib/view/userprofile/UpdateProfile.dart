/*
*   Widget Name : UpdateProfile stateful widget
*   Author : IT17134668
* */

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterapp/view/userhome/UserHome.dart';
import 'package:toast/toast.dart';

class UpdateProfile extends StatefulWidget {

  String username;
  String firstname;
  String password;
  String lastname;
  String sex;
  UpdateProfile(this.firstname,this.lastname,this.password,this.username,this.sex);
  @override
  _UpdateProfileState createState() => _UpdateProfileState(this.firstname,this.lastname,this.password,this.username,this.sex);
}

class _UpdateProfileState extends State<UpdateProfile> {
  //final record = User.fromSnapshot(data);
  String username;
  String firstname;
  String password;
  String lastname;
  String sex;
  _UpdateProfileState(this.firstname,this.lastname,this.password,this.username,this.sex);
  final _formKey = GlobalKey<FormState>();
  TextEditingController controller,lastNameController,usernameController,passwordController,sexController;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: this.firstname);
    lastNameController =  TextEditingController(text: this.lastname);
     usernameController =  TextEditingController(text: this.username);
     passwordController =  TextEditingController(text: this.password);
    sexController =  TextEditingController(text: this.sex);
  }

  @override
  Widget build(BuildContext context) {
    //Navigator.pop(context,true);
    return Container(
      //padding: EdgeInsets.only(top: 1.0,bottom: 50.0),
      child: AlertDialog(
        content: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 20.0),
                child: this.sex=='Female' ? Container(
                  padding: EdgeInsets.only(left: 30.0),
                  height:100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(100),
                    image: DecorationImage(
                      image: AssetImage('assets/girl.jpg'),
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
                      image: AssetImage('assets/boy.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),

                ),

              ),
              SizedBox(height:10.0),
              Text(
                'Update Profile',
                style: TextStyle(
                  fontSize: 30.0,
                ),
              ),
              SizedBox(height:10.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Username ",
                  labelStyle: TextStyle(
                    fontSize: 20.0
                  ),
                ),
                controller: usernameController,
                onSaved: (val){
                  username = val;
                },
                readOnly: true,
              ),
              SizedBox(height: 5.0,),
               TextFormField(
                decoration: InputDecoration(
                  labelText: "First Name ",
                  labelStyle: TextStyle(
                      fontSize: 20.0
                  ),
                ),
                 controller: controller,
                 onSaved: (val){
                    firstname = val;
                 },
              ),
              SizedBox(height: 10.0,),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Last Name ",
                  labelStyle: TextStyle(
                      fontSize: 20.0
                  ),
                ),
                controller: lastNameController,
                onSaved: (val){
                  lastname = val;
                },
              ),
              SizedBox(height: 5.0,),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Password ",
                  labelStyle: TextStyle(
                      fontSize: 20.0
                  ),
                ),
                controller: passwordController,
                obscureText: true,
                onSaved: (val){
                  password = val;
                },
              ),
              SizedBox(height: 5.0,),
              new DropdownButton<String>(
                focusColor: Colors.black26,
                iconDisabledColor: Colors.black26,
                iconEnabledColor: Colors.black26,
                hint: Text(
                  'Select gender',
                  style: TextStyle(
                      color: Colors.white
                  ),
                ),
                items: <String>['Male', 'Female'].map((String value) {
                  return new DropdownMenuItem<String>(
                    value: value,
                    child: new Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    this.sex = value;
                  });
                },
                value: this.sex,
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
                              "UPDATE PROFILE",
                              style: TextStyle(
                                color: Colors.blueAccent,
                                fontFamily: 'Montserrat',
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1,
                              ),
                            ),
                            onTap: updateProfile,

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


  //updating user profile
  void updateProfile() async{
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      Firestore.instance.collection("users").document("$username").updateData({
        'firstname': '$firstname',
        'lastname': '$lastname',
        'username': '$username',
        'password': '$password',
        'sex': '$sex'
      });//updating data
      Toast.show("$username You have successfully updated your profile", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => UserHome(username)),
      );
    }

  }



}
