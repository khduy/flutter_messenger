import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_messenger/controllers/auth_controller.dart';
import 'package:flutter_messenger/controllers/chat_room_controller.dart';
import 'package:flutter_messenger/models/user.dart';
import 'package:flutter_messenger/services/databases.dart';
import 'package:flutter_messenger/views/chat.dart';
import 'package:flutter_messenger/views/login.dart';
import 'package:flutter_messenger/views/search.dart';
import 'package:get/get.dart';

class Home extends GetWidget<AuthController> {
  final ChatRoomController chatRoomController = Get.put(ChatRoomController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chats'),
        //centerTitle: true,
        leading: Container(
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
              Get.off(() => Login());
            },
          ),
        ],
      ),
      body: Obx(
        () {
          if (chatRoomController != null && chatRoomController.chatRooms != null) {
            return chatRoomController.chatRooms.length != 0
                ? ListView.builder(
                    itemCount: chatRoomController.chatRooms.length,
                    itemBuilder: (context, index) {
                      String peerUserId =
                          chatRoomController.chatRooms[index].users[0] == controller.user.uid
                              ? chatRoomController.chatRooms[index].users[1]
                              : chatRoomController.chatRooms[index].users[0];

                      return ChatRoomTile(
                        UniqueKey(),
                        chatRoomController.chatRooms[index].chatRoomId,
                        chatRoomController.chatRooms[index].lastMessage,
                        peerUserId,
                      );
                    },
                  )
                : Center(
                    child: Text('You haven\'t chat with anyone yet'),
                  );
          } else
            return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class ChatRoomTile extends StatefulWidget {
  final String chatRoomId, lastMessage, peerUserId;
  ChatRoomTile(Key key, this.chatRoomId, this.lastMessage, this.peerUserId) : super(key: key);
  @override
  _ChatRoomTileState createState() => _ChatRoomTileState();
}

class _ChatRoomTileState extends State<ChatRoomTile> {
  UserModel user;

  getUserInfor() async {
    user = await DatabaseMethods().getUserInforById(widget.peerUserId);
    setState(() {});
  }

  @override
  void initState() {
    getUserInfor();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return user != null
        ? ListTile(
            title: Text(user.name),
            subtitle: Text(widget.lastMessage),
            leading: Container(
              width: 50,
              height: 50,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.network(user.photoUrl),
              ),
            ),
            onTap: () => Get.to(() => ChatScreen(), arguments: user),
          )
        : ListTile(
            title: Center(child: CircularProgressIndicator()),
          );
  }
}
