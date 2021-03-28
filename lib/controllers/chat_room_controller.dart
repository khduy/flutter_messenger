import 'package:flutter_messenger/controllers/auth_controller.dart';
import 'package:flutter_messenger/models/chat_room.dart';
import 'package:flutter_messenger/services/databases.dart';
import 'package:get/get.dart';

class ChatRoomController extends GetxController {
  Rx<List<ChatRoomModel>> listChatRoom = Rx<List<ChatRoomModel>>();
  List<ChatRoomModel> get chatRooms => listChatRoom.value;

  @override
  void onInit() {
    listChatRoom.bindStream(DatabaseMethods().chatRoomsStream(Get.find<AuthController>().user.uid));
    //listChatRoom.bindStream(DatabaseMethods().chatRoomsStream('NFHZhZPJT2bIR0spdWbM3s7FbFJ3'));
    super.onInit();
  }
}
