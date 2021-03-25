import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_messenger/controllers/auth_controller.dart';
import 'package:get/get.dart';

class Login extends GetWidget<AuthController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Flutter Messenger',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black54),
              ),
              SizedBox(height: 80),
              CupertinoButton(
                child: Container(
                  height: 50,
                  width: Get.width / 2,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.green,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 2,
                        offset: Offset(0, 1),
                      )
                    ],
                  ),
                  child: Text(
                    'Login with Google',
                    style:
                        TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 20),
                  ),
                ),
                onPressed: () {
                  controller.logInWithGoogle();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
