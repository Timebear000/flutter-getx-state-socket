import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getx_chat_app/model/model.dart';
import 'package:getx_chat_app/widget/own_message.dart';
import 'package:getx_chat_app/widget/reply.dart';

import '../controllers/chat_controller.dart';

class ChatView extends GetView<ChatController> {
  ChatModel? chatmodel;
  ChatModel? sourceChat;

  ChatView({
    this.chatmodel,
    this.sourceChat,
  });

  ChatController chatController = Get.put(ChatController());
  @override
  Widget build(BuildContext context) {
    chatController.connect(sourceChat!.id);
    return Scaffold(
      appBar: AppBar(
        title: Text('ChatView'),
        centerTitle: true,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: WillPopScope(
            onWillPop: () {
              if (controller.show.value) {
                controller.show.value = false;
              } else {
                Get.back();
              }
              return Future.value(false);
            },
            child: Column(
              children: [
                Expanded(
                  child: Obx(
                    () => ListView.builder(
                      shrinkWrap: true,
                      controller: controller.scrollController,
                      itemBuilder: (_, index) {
                        if (index == controller.messages.length) {
                          return Container(height: 50);
                        }
                        if (controller.messages[index].type == "source") {
                          return OwnMessage(
                            message: controller.messages[index].message!,
                            time: controller.messages[index].time!,
                          );
                        } else {
                          return Reply(
                            message: controller.messages[index].message!,
                            time: controller.messages[index].time!,
                          );
                        }
                      },
                      itemCount: controller.messages.length + 1,
                    ),
                  ),
                ),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                        height: 70,
                        child: SingleChildScrollView(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width - 60,
                                  child: Card(
                                    margin: EdgeInsets.only(
                                        left: 2, right: 2, bottom: 8),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    child: Obx(() => TextFormField(
                                          controller: controller.textcontroller,
                                          focusNode: controller.focusNode,
                                          textAlignVertical:
                                              TextAlignVertical.center,
                                          keyboardType: TextInputType.multiline,
                                          maxLines: 1,
                                          maxLength: 5,
                                          onChanged: (value) {
                                            if (value.length > 0) {
                                              controller.sendButton.value =
                                                  true;
                                              controller.update();
                                            } else {
                                              controller.sendButton.value =
                                                  false;
                                              controller.update();
                                            }
                                          },
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "Type a message",
                                              hintStyle:
                                                  TextStyle(color: Colors.grey),
                                              prefixIcon: IconButton(
                                                onPressed: null,
                                                icon: Icon(controller.show.value
                                                    ? Icons.keyboard
                                                    : Icons
                                                        .emoji_emotions_outlined),
                                              ),
                                              suffixIcon: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  IconButton(
                                                      onPressed: () {},
                                                      icon: Icon(
                                                          Icons.attach_file)),
                                                  IconButton(
                                                      onPressed: () {},
                                                      icon: Icon(
                                                          Icons.camera_alt))
                                                ],
                                              ),
                                              contentPadding:
                                                  EdgeInsets.all(5)),
                                        )),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    bottom: 8,
                                    right: 2,
                                    left: 2,
                                  ),
                                  child: CircleAvatar(
                                    radius: 25,
                                    backgroundColor: Color(0xFF128CFE),
                                    child: IconButton(
                                      onPressed: () {
                                        if (controller.sendButton.value) {
                                          controller.scrollController.animateTo(
                                              controller.scrollController
                                                  .position.maxScrollExtent,
                                              duration:
                                                  Duration(milliseconds: 300),
                                              curve: Curves.easeOut);
                                          controller.sendMessages(
                                              controller.textcontroller.text,
                                              sourceChat!.id,
                                              chatmodel!.id);
                                          controller.textcontroller.clear();
                                          controller.sendButton.value = false;
                                        }
                                      },
                                      icon: Obx(
                                        () => Icon(
                                          controller.sendButton.value
                                              ? Icons.send
                                              : Icons.mic,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ))))
              ],
            )),
      ),
    );
  }
}
