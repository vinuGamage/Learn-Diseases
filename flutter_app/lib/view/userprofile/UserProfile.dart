/*
*   Widget Name : UserProfile stateful widget
*   Author : IT17134668
* */

import 'package:flutter/material.dart';
import 'package:flutterapp/model/User.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterapp/view/register/Register.dart';
import 'package:flutterapp/view/userprofile/UpdateProfile.dart';


class UserProfile extends StatefulWidget {
  String username;
  UserProfile(this.username);
  @override
  _UserProfileState createState() => _UserProfileState(this.username);
}

class _UserProfileState extends State<UserProfile> {
  String username;
  _UserProfileState(this.username);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context,this.username),
    );
  }
}

Widget _buildBody(BuildContext context,username) {
  //retrieving data from users collection(snapshot)
  return StreamBuilder<DocumentSnapshot>(
    stream: Firestore.instance.collection('users').document(username).snapshots(),
    builder: (context,snapshot){
      if(!snapshot.hasData) return LinearProgressIndicator();
      return _buildListItem(context, snapshot.data);
    },
  );
}

Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
  final record = User.fromSnapshot(data);

  return Container(
    padding: const EdgeInsets.only(left: 20.0,right:20.0,top: 40.0),

    child: Material(
      key: ValueKey(record.username),
      color: Colors.white,
      elevation: 10,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        height: 600,
        width: 500,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          //color: Colors.red
        ),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 150.0,top: 30.0),
                  child: Center(
                    child: record.sex=='Female' ? Container(
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
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.only(left: 80.0,top: 20.0),
              child: Row(
               children: <Widget>[
                 Text(
                   'Welcome ',
                   style: TextStyle(color: Colors.black54, fontSize: 30),
                   textAlign: TextAlign.center,

                 ),
                 Text(record.username, style: TextStyle(color: Colors.black54, fontSize: 30, ),),
               ],
              ),
            ),
            Container(
              color: Colors.white,
              width: MediaQuery.of(context).size.width - 100,
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 80.0,top: 30.0),
                    child: Row(
                      children: <Widget>[
                        Text("First Name :", style: TextStyle(color: Colors.black54, fontSize: 20,),),
                        Text(record.firstname, style: TextStyle(color: Colors.black38, fontSize: 20,),),
                        SizedBox(width: 30,),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 80.0,top: 10.0),
                    child: Row(
                      children: <Widget>[
                        Text("Last Name :", style: TextStyle(color: Colors.black54, fontSize: 20,),),
                        Text(record.lastname, style: TextStyle(color: Colors.black38, fontSize: 20, ),),
                        SizedBox(width: 30,),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 80.0,top: 10.0),
                    child: Row(
                      children: <Widget>[
                        Text("Username  :", style: TextStyle(color: Colors.black54, fontSize: 20,),),
                        Text(record.username, style: TextStyle(color: Colors.black38, fontSize: 20, ),),
                        SizedBox(width: 30,),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 80.0,top: 10.0),
                    child: Row(
                      children: <Widget>[
                        Text("Password  :", style: TextStyle(color: Colors.black54, fontSize: 20,),),
                        Text(record.password, style: TextStyle(color: Colors.black38, fontSize: 20, ),),
                        SizedBox(width: 30,),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 80.0,top: 10.0),
                    child: Row(
                      children: <Widget>[
                        Text("Gender       :", style: TextStyle(color: Colors.black54, fontSize: 20,),),
                        Text(record.sex, style: TextStyle(color: Colors.black38, fontSize: 20,),),
                        SizedBox(width: 30,),
                      ],
                    ),
                  ),
                ],

              ),

            ),
            SizedBox(height: 25,),
            Container(
              padding: EdgeInsets.only(left: 70.0,top: 20.0,right: 70.0),
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
                            onTap: (){
                              Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => UpdateProfile(record.firstname,record.lastname,record.password,record.username,record.sex)),
                            );
                            },


                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 70.0,top: 20.0,right: 70.0),
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
                            "DELETE PROFILE",
                            style: TextStyle(
                              color: Colors.blueAccent,
                              fontFamily: 'Montserrat',
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1,
                            ),
                          ),
                          onTap: (){
                            Firestore.instance.collection('users').document(record.username).delete();
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Register()),
                            );
                          },
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



