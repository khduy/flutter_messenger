import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_messenger/services/databases.dart';
//import 'package:flutter_messenger/services/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
//import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;

  Rx<User> _user = Rx<User>();

  User get user => _user.value;

  // for auto login
  getCurrentUser() async {
    _user.value = auth.currentUser;
  }

  @override
  onInit() {
    getCurrentUser();

    super.onInit();
  }

  logInWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();

      await googleSignIn.signOut(); // for dont auto select account

      GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential authCredential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken,
      );

      UserCredential result = await auth.signInWithCredential(authCredential);

      if (result.user != null) {
        _user.value = result.user;
        // SharedPreferenceHelper().saveUserId(result.user.uid);
        // SharedPreferenceHelper().saveUserEmail(result.user.email);
        // SharedPreferenceHelper().saveUserDisplayName(result.user.displayName);
        // SharedPreferenceHelper().saveUserPhotoUrl(result.user.photoURL);

        Map<String, dynamic> userInfor = {
          'email': result.user.email,
          'name': result.user.displayName,
          'photoUrl': result.user.photoURL,
          'userName': result.user.email.replaceAll('@gmail.com', '')
        };

        final QuerySnapshot snapshot = await FirebaseFirestore.instance
            .collection('users')
            .where('email', isEqualTo: result.user.email)
            .get();

        if (snapshot.docs.isEmpty) {
          print('new user');
          DatabaseMethods().addUserInforToDB(result.user.uid, userInfor);
        } else
          print('old user');

        Get.offNamed('/home');
      }
    } catch (e) {
      Get.snackbar('login failed', e.toString());
    }
  }

  logOut() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.clear();
    //_user.value = null;
    await auth.signOut();
  }
}
