/*
*   Widget Name : UserDiseaseList stateful widget
*   Author : IT17134668
* */


import 'package:flutter/material.dart';
import 'package:flutterapp/model/Disease.dart';
import 'package:flutterapp/view/disease/UserDiseaseInfo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserDiseaseList extends StatefulWidget {
  String username;
  UserDiseaseList(this.username);
  @override
  _UserDiseaseListState createState() => _UserDiseaseListState(this.username);
}

class _UserDiseaseListState extends State<UserDiseaseList> {
  String name;
  String username;
  _UserDiseaseListState(this.username);
  final GlobalKey<FormState> formKey = new GlobalKey();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20, top: 30),
            width: double.infinity,
            child: Text("Devastating Infectious Diseases", style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
          ),
          Container(
            padding: EdgeInsets.only(left: 30,right: 30),
            child:Column(
              children: <Widget>[
                Form(
                  key: formKey,
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "Disease Name ",
                      labelStyle: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black45
                      ),
                    ),
                    onSaved: (val) => name = val,
                    validator: (val) {
                      if (val.length == 0) {
                        return "Disease Name cannot be empty";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                SizedBox(height: 20.0,),
                Container(
                    /*child:IconButton(
                      icon: Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                      onPressed: directToDiseaseInfo,

                    )*/
                    //padding: EdgeInsets.only(left: 80.0,right: 80.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.blueAccent,
                        style: BorderStyle.solid,
                        width: 1.0,
                      ),
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child:Center(
                      child: InkWell(
                        child: Text(
                          "SEARCH",
                          style: TextStyle(
                            color: Colors.blueAccent,
                            fontFamily: 'Montserrat',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                        onTap: directToDiseaseInfo,
                      ),
                    )
                ),
              ],
            ),
          ),


          Container(
            height: MediaQuery.of(context).size.height-330,
            child: _buildBody(context),
          ),

        ],
      ),
    );
  }

  //navigating to disease information page
  void directToDiseaseInfo(){
    if (formKey.currentState.validate()) {
      //print('form key :::::::' + formKey.currentContext.toString());
      formKey.currentState.save();
      //print('disease HIIIIIII ********************** ' + name);
      //print('user HIIIIIII ********************** ' + username);
      var document = Firestore.instance.collection('diseases').document('$name');
      document.get().then((doc) {
        //If document exists
        if (doc.exists) {
          print('Documents exists');
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => UserDiseaseInfo(name,username)),
          );
        } else {
          //where no data existsF
          print('ERORRRRRRRRRRRRRRRR');
        }
      });
    }
  }

}

Widget _buildBody(BuildContext context) {
  //retrieving data from diseases collection
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