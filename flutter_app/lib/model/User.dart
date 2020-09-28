/*
*   Class Name : User class
*   Author : IT17134668
* */

import 'package:cloud_firestore/cloud_firestore.dart';

class User{

  final String firstname;
  final String lastname;
  final String username;
  final String password;
  final String sex;
  final DocumentReference reference;
  User.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['firstname'] != null),
        assert(map['lastname'] != null),
        assert(map['username'] != null),
        assert(map['password'] != null),
        assert(map['sex'] != null),
        firstname = map['firstname'],
        lastname = map['lastname'],
        password = map['password'],
        sex = map['sex'],
        username = map['username'];


  User.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);
  @override
  String toString() => "Record<$password:$username>";

}