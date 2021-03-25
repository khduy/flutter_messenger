import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  static String userIdKey = 'USERIDKEY';
  static String userNameKey = 'USERNAMEKEY';
  static String userDisplayNameKey = 'USERDISPLAYNAMEKEY';
  static String userEmailKey = 'USEREMAILKEY';
  static String userPhotoUrlKey = 'USERPHOTOURLKEY';

  // save
  saveUserId(String userId) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.setString(userIdKey, userId);
  }

  saveUserName(String userName) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.setString(userNameKey, userName);
  }

  saveUserDisplayName(String userDisplayName) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.setString(userDisplayNameKey, userDisplayName);
  }

  saveUserEmail(String userEmail) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.setString(userEmailKey, userEmail);
  }

  saveUserPhotoUrl(String userPhotoUrl) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.setString(userPhotoUrlKey, userPhotoUrl);
  }

  // get
  getUserId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(userIdKey);
  }

  getUserName() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(userNameKey);
  }

  getUserDisplayName() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(userDisplayNameKey);
  }

  getUserEmail() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(userEmailKey);
  }

  Future<String> getUserPhotoUrl() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(userPhotoUrlKey);
  }
}
