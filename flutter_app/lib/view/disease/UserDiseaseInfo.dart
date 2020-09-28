/*
*   Widget Name : UserDiseaseInfo Stateful widget
*   Author : IT17134668
* */

import 'package:flutter/material.dart';
import 'package:flutterapp/model/Disease.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterapp/view/userhome/UserHome.dart';

class UserDiseaseInfo extends StatefulWidget {
  String name;
  String username;
  UserDiseaseInfo(this.name,this.username);
  @override
  _UserDiseaseInfoState createState() => _UserDiseaseInfoState(this.name,this.username);
}

class _UserDiseaseInfoState extends State<UserDiseaseInfo> {
  String name;
  String username;
  _UserDiseaseInfoState(this.name,this.username);
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        title: Text("Learn Diseases", style: TextStyle(color: Colors.white),),
      ),
      body: Container(
        child:Column(
          children:<Widget>[
            _buildBody(context,this.name),
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
                              MaterialPageRoute(builder: (context) => UserHome(this.username)),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ]
        )
      )
    );
  }

}

Widget _buildBody(BuildContext context,name) {
  //retrieving data from diseases collection(as snapshots)
  return StreamBuilder<DocumentSnapshot>(
    stream: Firestore.instance.collection('diseases').document(name).snapshots(),
    builder: (context,snapshot){
      if(!snapshot.hasData) return LinearProgressIndicator();
      return _buildListItem(context, snapshot.data);
    },
  );
}

Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
  final record = Disease.fromSnapshot(data);

  return Container(
   // padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 8.0),
    padding: EdgeInsets.only(top: 70.0,left: 20.0,right: 20.0),
    child: Material(
      key: ValueKey(record.name),
      color: Colors.white,
      elevation: 10,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        height: 600,
        width: 500,
        padding: EdgeInsets.only(top: 40.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: <Widget>[
            Container(
              width: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
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

                ) : Material(
                  child: Container(
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
            ),
            Container(
              color: Colors.white,
              width: MediaQuery
                  .of(context)
                  .size
                  .width - 100,
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      SizedBox(width: 10,height: 60,),
                      Text("Disease Name : ", style: TextStyle(color: Colors.black54,
                          fontSize: 20,),),
                      Text(record.name, style: TextStyle(color: Colors.black38,
                          fontSize: 20,),),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(width: 10,height: 60,),
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
                  Row(
                    children: <Widget>[
                      SizedBox(width: 10,height: 60,),
                      Text('Symptoms :',
                        style: TextStyle(color: Colors.black54, fontSize: 20,
                        ),),

                    ],
                  ),
                  Text(record.symptoms,
                    style: TextStyle(color: Colors.black38, fontSize: 16,
                    ),),
                  Row(
                    children: <Widget>[
                      SizedBox(width: 10,height: 60,),
                      Text('Caused By :',
                        style: TextStyle(color: Colors.black54, fontSize: 20,
                        ),),
                      Text(record.causedby,
                        style: TextStyle(color: Colors.black38, fontSize: 16,
                        ),),
                    ],
                  )
                ],

              ),

            ),

          ],

        ),

      ),

    ),
  );


}

