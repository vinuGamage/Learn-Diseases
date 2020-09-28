/*
*   Widget Name : DiseaseList Stateful widget
*   Author : IT17137492
* */

import 'package:flutter/material.dart';
import 'package:flutterapp/model/Disease.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DiseaseList extends StatefulWidget {
  @override
  _DiseaseListState createState() => _DiseaseListState();
}

class _DiseaseListState extends State<DiseaseList> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20, top: 30),
            width: double.infinity,
            child: Text("Devastating Infectious Diseases", style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
          ),
          Container(
            height: MediaQuery.of(context).size.height-220,
            child: _buildBody(context),
          ),

        ],
      ),
    );
  }
}

Widget _buildBody(BuildContext context) {
 //retrieving all data from diseases collection
  return StreamBuilder<QuerySnapshot>(
    stream: Firestore.instance.collection('diseases').snapshots(),
    builder: (context,snapshot){
      if(!snapshot.hasData) return LinearProgressIndicator();
      return _buildList(context, snapshot.data.documents);
    },
  );
}

Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
  return ListView(
    padding: const EdgeInsets.only(top: 20.0),
    children: snapshot.map((data) => _buildListItem(context, data)).toList(),
  );
}

Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
  final record = Disease.fromSnapshot(data);

  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 8.0),
    child: Material(
      key: ValueKey(record.name),
      color: Colors.white,
      elevation: 10,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          //color: Colors.red
        ),
        child: Row(
          children: <Widget>[
            Container(
              width: 90,
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

                ) : Material(
                  //color: Colors.transparent,
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
                      SizedBox(width: 10,height: 30,),
                      Text(record.name, style: TextStyle(color: Colors.black38,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),),
                    ],
                  ),
                  Text(record.description,
                    style: TextStyle(color: Colors.black38, fontSize: 14,),),
                 Row(
                   children: <Widget>[
                     Text('Symptoms :',
                       style: TextStyle(color: Colors.black54, fontSize: 14,
                       ),),
                     Text(record.symptoms,
                       style: TextStyle(color: Colors.black38, fontSize: 14,
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