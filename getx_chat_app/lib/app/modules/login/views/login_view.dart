import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getx_chat_app/app/modules/home/views/home_view.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LoginView'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: controller.chatmodels.length,
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            controller.sourceChat = controller.chatmodels.removeAt(index);

            Get.to(HomeView(
                chatmodels: controller.chatmodels,
                sourceChat: controller.sourceChat!));
          },
          child: Card(
            child: Container(
              height: 100,
              margin: EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  "my name is ${controller.chatmodels[index].name}",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
