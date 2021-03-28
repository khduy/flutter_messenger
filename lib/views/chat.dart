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

  ChatScreen() {
    chatRoomId = DatabaseMethods().createChatRoomId(user.id, authController.user.uid);
  }

  @override
  Widget build(BuildContext context) {
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
      body: Container(
        height: Get.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Obx(() {
              if (messageController.messages != null)
                return Expanded(
                  child: GestureDetector(
                    onTap: () => FocusScope.of(context).unfocus(),
                    child: Container(
                      padding: EdgeInsets.all(15),
                      child: ListView.separated(
                        physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                        reverse: true,
                        itemCount: messageController.messages.length,
                        itemBuilder: (context, index) => Row(
                          mainAxisAlignment:
                              authController.user.uid == messageController.messages[index].sendBy
                                  ? MainAxisAlignment.end
                                  : MainAxisAlignment.start,
                          children: [
                            Container(
                              constraints: BoxConstraints(maxWidth: Get.width * 0.8),
                              padding: EdgeInsets.symmetric(horizontal: 13, vertical: 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: authController.user.uid ==
                                        messageController.messages[index].sendBy
                                    ? Colors.green
                                    : Colors.black12,
                              ),
                              child: Text(
                                messageController.messages[index].message,
                                style: TextStyle(fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                        separatorBuilder: (context, index) => SizedBox(height: 5),
                      ),
                    ),
                  ),
                );
              else
                return Center(
                  child: CircularProgressIndicator(),
                );
            }),
            Container(
              padding: EdgeInsets.only(left: 10, bottom: 10),
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
                        DateTime now = DateTime.now();
                        DatabaseMethods().createChatRoom(chatRoomId, authController.user.uid,
                            user.id, textController.text.trim(), now);
                        DatabaseMethods().addMessage(
                          chatRoomId,
                          authController.user.uid,
                          textController.text.trim(),
                          now,
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
      ),
    );
  }
}
