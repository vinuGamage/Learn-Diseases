/*
*   Class Name : Disease class
*   Author : IT17137492
* */

import 'package:cloud_firestore/cloud_firestore.dart';

class Disease{

  final String name;
  final String description;
  final String causedby;
  final String symptoms;
  final DocumentReference reference;
  Disease.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        assert(map['description'] != null),
        assert(map['causedby'] != null),
        assert(map['symptoms'] != null),
        name = map['name'],
        causedby = map['causedby'],
        symptoms = map['symptoms'],
        description = map['description'];
  Disease.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);
  @override
  String toString() => "Record<$causedby:$causedby>";

}