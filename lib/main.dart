import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_messenger/controllers/auth_controller.dart';
import 'package:flutter_messenger/views/chat.dart';
import 'package:flutter_messenger/views/home.dart';
import 'package:flutter_messenger/views/login.dart';

import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: Get.put<AuthController>(AuthController()).user != null ? '/home' : '/login',
      //initialBinding: AuthBinding(),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      getPages: [
        GetPage(name: '/home', page: () => Home()),
        GetPage(name: '/chatScreen', page: () => ChatScreen()),
        GetPage(name: '/login', page: () => Login()),
      ],
      //home: Root(),
    );
  }
}
