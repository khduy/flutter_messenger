import 'package:flutter_messenger/controllers/auth_controller.dart';
import 'package:flutter_messenger/controllers/chat_room_controller.dart';
import 'package:flutter_messenger/controllers/search_controller.dart';
import 'package:get/get.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => SearchController());
  }
}
