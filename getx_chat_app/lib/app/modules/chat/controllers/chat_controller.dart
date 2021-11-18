import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:getx_chat_app/model/model.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatController extends GetxController {
  Rx<bool> show = false.obs;
  FocusNode focusNode = FocusNode();
  Rx<bool> sendButton = false.obs;
  RxList<MessageModel> messages = RxList<MessageModel>();
  TextEditingController textcontroller = TextEditingController();
  ScrollController scrollController = ScrollController();
  late IO.Socket socket;

  @override
  void onInit() {
    super.onInit();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        show.value = false;
        update();
      }
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void connect(int sourceId) {
    socket = IO.io("http://192.168.1.2:5000", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });

    socket.connect();
    socket.emit("login", sourceId);
    socket.onConnect((data) {
      print("konesksi berhasil");
      socket.on("message", (msg) {
        setMessage("destination", msg["message"]);

        scrollController.animateTo(scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 300), curve: Curves.easeOut);
      });
    });
  }

  void setMessage(String type, msg) {
    MessageModel messageModel = MessageModel(
        message: msg,
        type: type,
        time: DateTime.now().toString().substring(10, 16));
    messages.add(messageModel);
    update();
  }

  void sendMessages(String message, int sourceId, int targetId) {
    setMessage("source", message);
    socket.emit("message",
        {"message": message, "sourceId": sourceId, "targetId": targetId});
    update();
  }
}
