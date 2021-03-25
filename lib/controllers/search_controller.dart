import 'package:flutter_messenger/models/user.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  Rx<List<UserModel>> listUser = Rx<List<UserModel>>();
  get getListUser => listUser.value;
}
