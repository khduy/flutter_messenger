import 'package:flutter/cupertino.dart';
import 'package:flutter_messenger/controllers/auth_controller.dart';
import 'package:flutter_messenger/views/home.dart';
import 'package:flutter_messenger/views/login.dart';
import 'package:get/get.dart';

class Root extends GetWidget<AuthController> {
  @override
  Widget build(BuildContext context) {
    // return Obx(() {
    //   return Get.find<AuthController>().user != null ? Home() : Login();
    // });
    return Get.find<AuthController>().user != null ? Home() : Login();
  }
}
