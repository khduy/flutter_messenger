import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String id;
  String email;
  String userName;
  String name;
  String photoUrl;

  UserModel({this.id, this.userName, this.email, this.name, this.photoUrl});

  UserModel.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    id = documentSnapshot.id;
    userName = documentSnapshot['userName'];
    email = documentSnapshot['email'];
    name = documentSnapshot['name'];
    photoUrl = documentSnapshot['photoUrl'];
  }
}
