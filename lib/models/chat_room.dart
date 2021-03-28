import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRoomModel {
  String chatRoomId;
  String lastMessage;
  String sendBy;
  Timestamp timestamp;
  List<dynamic> users;
  ChatRoomModel({this.chatRoomId, this.lastMessage, this.sendBy, this.timestamp, this.users});

  ChatRoomModel.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    chatRoomId = documentSnapshot.id;
    lastMessage = documentSnapshot['lastMessage'];
    sendBy = documentSnapshot['sendBy'];
    timestamp = documentSnapshot['lastTimestamp'];
    users = documentSnapshot['users'];
  }
}
