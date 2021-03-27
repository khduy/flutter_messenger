import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String id;
  String message;
  String sendBy;
  Timestamp timestamp;

  MessageModel({this.id, this.message, this.sendBy, this.timestamp});

  MessageModel.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    id = documentSnapshot.id;
    message = documentSnapshot['message'];
    sendBy = documentSnapshot['sendBy'];
    timestamp = documentSnapshot['timestamp'];
  }
}
