import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_messenger/controllers/auth_controller.dart';
import 'package:flutter_messenger/controllers/message_controller.dart';
import 'package:flutter_messenger/models/user.dart';
import 'package:flutter_messenger/services/databases.dart';
import 'package:get/get.dart';

class ChatScreen extends StatelessWidget {
  final UserModel user = Get.arguments;
  final TextEditingController textController = TextEditingController();
  final AuthController authController = Get.find<AuthController>();
  final MessageController messageController = Get.put(MessageController());

  String chatRoomId;

  getChatRoomId(String a, String b) {
    if (a.hashCode <= b.hashCode) return '$a-$b';
    return '$b-$a';
  }

  @override
  Widget build(BuildContext context) {
    chatRoomId = getChatRoomId(authController.user.uid, user.id);
    messageController.messageList.bindStream(DatabaseMethods().messageStream(chatRoomId));
    return Scaffold(
      appBar: AppBar(
        title: Row(children: [
          Container(
            height: 50,
            width: 50,
            padding: EdgeInsets.all(5),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.network(user.photoUrl),
            ),
          ),
          SizedBox(width: 5),
          Text(user.name)
        ]),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Obx(() {
            if (messageController.messages != null)
              return Container(
                padding: EdgeInsets.all(10),
                child: ListView.separated(
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  reverse: true,
                  itemCount: messageController.messages.length,
                  itemBuilder: (_, index) => Row(
                    mainAxisAlignment: user.id == messageController.messages[index].sendBy
                        ? MainAxisAlignment.start
                        : MainAxisAlignment.end,
                    children: [
                      Container(
                        constraints: BoxConstraints(maxWidth: Get.width * 0.7),
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: user.id == messageController.messages[index].sendBy
                              ? Colors.black12
                              : Colors.green,
                        ),
                        child: Text(
                          messageController.messages[index].message,
                          style: TextStyle(fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                  separatorBuilder: (_, index) => SizedBox(height: 5),
                ),
              );
            else
              return Center(
                child: CircularProgressIndicator(),
              );
          }),
          Container(
            padding: EdgeInsets.only(left: 10, bottom: 5),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextField(
                      minLines: 1,
                      maxLines: 3,
                      controller: textController,
                      decoration: InputDecoration(
                        fillColor: Colors.blue,
                        border: InputBorder.none,
                        hintText: 'Aa',
                      ),
                    ),
                  ),
                ),
                CupertinoButton(
                  child: Icon(
                    Icons.send_rounded,
                    size: 30,
                  ),
                  padding: EdgeInsets.all(0),
                  onPressed: () {
                    if (textController.text.trim().isNotEmpty) {
                      DatabaseMethods().addMessage(
                        chatRoomId,
                        authController.user.uid,
                        textController.text,
                      );
                      textController.text = '';
                    }
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
