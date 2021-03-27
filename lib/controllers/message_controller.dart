import 'package:flutter_messenger/models/message.dart';
import 'package:get/get.dart';

class MessageController extends GetxController {
  Rx<List<MessageModel>> messageList = Rx<List<MessageModel>>();
  List<MessageModel> get messages => messageList.value;
}
