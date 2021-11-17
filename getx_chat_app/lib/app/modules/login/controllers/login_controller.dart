import 'package:get/get.dart';
import 'package:getx_chat_app/model/model.dart';

class LoginController extends GetxController {
  List<ChatModel> chatmodels = [];
  ChatModel? sourceChat;
  @override
  void onInit() {
    super.onInit();
    addDataUser();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void addDataUser() {
    chatmodels.add(new ChatModel(
      currentMessage: 'Hi ',
      icon: 'person.svg',
      id: 1,
      isGroup: false,
      name: 'Bayu',
      time: '5:00',
    ));

    chatmodels.add(new ChatModel(
      currentMessage: 'hello ',
      icon: 'person.svg',
      id: 2,
      isGroup: false,
      name: 'Nugroho',
      time: '4:00',
    ));
    update();
  }
}
