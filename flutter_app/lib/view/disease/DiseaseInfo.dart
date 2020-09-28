/*
*   Widget Name : DiseaseInfo stateful widget
*   Author : IT17137492
* */

import 'package:flutter/material.dart';
import 'package:flutterapp/model/Disease.dart';
import 'package:flutterapp/view/adminhome/AdminHome.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterapp/view/updatedisease/UpdateDisease.dart';

class DiseaseInfo extends StatefulWidget {
  String name;
  DiseaseInfo(this.name);
  @override
  _DiseaseInfoState createState() => _DiseaseInfoState(this.name);
}

class _DiseaseInfoState extends State<DiseaseInfo> {
  String name;
  _DiseaseInfoState(this.name);
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        title: Text("Learn Diseases", style: TextStyle(color: Colors.white),),
      ),
      body: _buildBody(context,this.name),
    );
  }
}

Widget _buildBody(BuildContext context,name) {
  //retrieving data from database
  return StreamBuilder<DocumentSnapshot>(
    stream: Firestore.instance.collection('diseases').document(name).snapshots(),
    builder: (context,snapshot){
      if(!snapshot.hasData) return LinearProgressIndicator();
      return _buildList(context, snapshot.data);
    },
  );
}

Widget _buildList(BuildContext context, DocumentSnapshot data) {
  return _buildListItem(context, data);
}

Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
  final record = Disease.fromSnapshot(data);

  return Container(
    padding: const EdgeInsets.only(left: 20.0,right:20.0,top: 70.0),

    child: Material(
      key: ValueKey(record.name),
      color: Colors.white,
      elevation: 10,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        height: 600,
        //width: 500,
        padding: EdgeInsets.only(top: 40.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 150.0),
                  //width: 90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                    //color: Colors.red
                  ),
                  child: Center(
                    child: record.causedby=='virus' ? Container(
                      padding: EdgeInsets.only(left: 30.0),
                      height:80,
                      width: 80,
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
                      height:80,
                      width: 80,
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
                ),
              ],
            ),
            Container(
              color: Colors.white,
              width: MediaQuery.of(context).size.width - 100,
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(right: 10.0,top: 30.0),
                    child: Row(
                      children: <Widget>[
                        Text("Disease Name :", style: TextStyle(color: Colors.black54, fontSize: 20,),),
                        Text(record.name, style: TextStyle(color: Colors.black38, fontSize: 20,),),
                        SizedBox(width: 30,),
                      ],
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(height: 60,),
                      Text('Description :',
                        style: TextStyle(color: Colors.black54, fontSize: 20,
                        ),),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10.0,right: 10.0),
                    child: Text(record.description,
                      style: TextStyle(color: Colors.black38, fontSize: 16,),),
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 10.0,top: 10.0),
                    child: Row(
                      children: <Widget>[
                        Text("Caused By  :", style: TextStyle(color: Colors.black54, fontSize: 20,),),
                        Text(record.causedby, style: TextStyle(color: Colors.black38, fontSize: 20),),
                        SizedBox(width: 30,),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 10.0,top: 10.0),
                    child: Row(
                      children: <Widget>[
                        Text("Symptoms  :", style: TextStyle(color: Colors.black54, fontSize: 20,),),
                        SizedBox(width: 5,),
                      ],
                    ),
                  ),
                  Text(record.symptoms, style: TextStyle(color: Colors.black38, fontSize: 20,),),
                  SizedBox(width: 30,),
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
                            "UPDATE DISEASE",
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
                              MaterialPageRoute(builder: (context) => UpdateDisease(record.name,record.description,record.causedby,record.symptoms)),
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
                            "HOME",
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
                              MaterialPageRoute(builder: (context) => AdminHome()),
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
