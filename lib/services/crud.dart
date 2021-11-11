import 'package:cloud_firestore/cloud_firestore.dart';

class crudMethod {
  final CollectionReference dataCollection =
      FirebaseFirestore.instance.collection("users");
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  Future<void> storeData(Map<String, String> mapp) {
    return users
        .add(mapp)
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Stream<QuerySnapshot> get data {
    return users.snapshots();
  }
}
