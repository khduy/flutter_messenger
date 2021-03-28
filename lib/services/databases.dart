import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_messenger/models/chat_room.dart';
import 'package:flutter_messenger/models/message.dart';
import 'package:flutter_messenger/models/user.dart';
import 'package:random_string/random_string.dart';

class DatabaseMethods {
  addUserInforToDB(String userId, Map<String, dynamic> userInfor) async {
    return await FirebaseFirestore.instance.collection('users').doc(userId).set(userInfor);
  }

  Stream<List<UserModel>> getUserByUserName(String userName) {
    return FirebaseFirestore.instance
        .collection('users')
        .where('userName', isEqualTo: userName)
        .snapshots()
        .map((snapShot) {
      List<UserModel> rs = [];
      snapShot.docs.forEach((element) {
        rs.add(UserModel.fromDocumentSnapshot(element));
      });
      return rs;
    });
  }

  Future<void> addMessage(
    String chatRoomId,
    String userId,
    String message,
    DateTime timestamp,
  ) async {
    String messageId = randomAlphaNumeric(12);
    try {
      await FirebaseFirestore.instance
          .collection('chatRooms')
          .doc(chatRoomId)
          .collection('messages')
          .doc(messageId)
          .set({
        'sendBy': userId,
        'message': message,
        'timestamp': timestamp,
      });
    } catch (e) {}
    updateChatRoomInfo(chatRoomId, message, userId, timestamp);
  }

  Stream<List<MessageModel>> messageStream(String chatRoomId) {
    return FirebaseFirestore.instance
        .collection('chatRooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((querySnapshot) {
      List<MessageModel> rs = [];
      querySnapshot.docs.forEach((element) {
        rs.add(MessageModel.fromDocumentSnapshot(element));
      });
      return rs;
    });
  }

  Stream<List<ChatRoomModel>> chatRoomsStream(String userId) {
    return FirebaseFirestore.instance
        .collection('chatRooms')
        .orderBy('lastTimestamp', descending: true)
        .where('users', arrayContains: userId)
        .snapshots()
        .map((querySnapshot) {
      List<ChatRoomModel> rs = [];
      if (querySnapshot.docs.isNotEmpty) {
        querySnapshot.docs.forEach((element) {
          rs.add(ChatRoomModel.fromDocumentSnapshot(element));
        });
      }
      return rs;
    });
  }

  String createChatRoomId(String a, String b) {
    if (a.hashCode <= b.hashCode) return '$a-$b';
    return '$b-$a';
  }

  Future<void> createChatRoom(String chatRoomId, String myUserId, String peerUserId,
      String lastMessage, DateTime timestamp) async {
    var snapshot = await FirebaseFirestore.instance.collection('chatRooms').doc(chatRoomId).get();
    if (!snapshot.exists) {
      return FirebaseFirestore.instance.collection('chatRooms').doc(chatRoomId).set({
        'users': [myUserId, peerUserId],
        'lastMessage': lastMessage,
        'lastTimestamp': timestamp,
        'sendBy': myUserId,
      });
    }
  }

  Future<void> updateChatRoomInfo(
      String chatRoomId, String lastMessage, String userId, DateTime timestamp) {
    return FirebaseFirestore.instance.collection('chatRooms').doc(chatRoomId).update({
      'lastMessage': lastMessage,
      'sendBy': userId,
      'lastTimestamp': timestamp,
    });
  }

  Future<UserModel> getUserInforById(String userId) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .get()
        .then((value) => UserModel.fromDocumentSnapshot(value));
  }
}
