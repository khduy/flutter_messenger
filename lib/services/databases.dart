import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_messenger/models/user.dart';

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
}
