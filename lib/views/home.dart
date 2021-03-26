import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_messenger/controllers/auth_controller.dart';
import 'package:flutter_messenger/views/search.dart';
import 'package:get/get.dart';

class Home extends GetWidget<AuthController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.user.email),
        //centerTitle: true,
        leading: Padding(
          padding: EdgeInsets.all(10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.network(controller.user.photoURL),
          ),
        ),
        actions: [
          CupertinoButton(
            child: Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
              showSearch(context: context, delegate: Search());
            },
          ),
          CupertinoButton(
            child: Icon(
              Icons.logout,
              color: Colors.white,
            ),
            onPressed: () {
              controller.logOut();
            },
          ),
        ],
      ),
    );
  }
}
