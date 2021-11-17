import 'package:cloud_firestore/cloud_firestore.dart';

class crudMethod {


  // Future<void> storeData(Map<String, String> mapp) {
  //   return users
  //       .add(mapp)
  //       .then((value) => print("User Added"))
  //       .catchError((error) => print("Failed to add user: $error"));
  // }

  Stream<QuerySnapshot> get data {
    CollectionReference users = FirebaseFirestore.instance.collection("trainee");
    return users.snapshots();
  }
  CollectionReference trainee =
      FirebaseFirestore.instance.collection("trainee");
}
