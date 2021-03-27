import 'package:cloud_firestore/cloud_firestore.dart';
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

  Future<void> addMessage(String chatRoomId, String userId, String message) async {
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
        'timestamp': DateTime.now(),
      });
    } catch (e) {}
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
}
