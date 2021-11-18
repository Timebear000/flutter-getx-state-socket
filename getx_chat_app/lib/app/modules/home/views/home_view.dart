import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:getx_chat_app/app/modules/chat/views/chat_view.dart';
import 'package:getx_chat_app/model/model.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  late List<ChatModel>? chatmodels;
  late ChatModel? sourceChat;
  HomeView({this.chatmodels, this.sourceChat});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          leadingWidth: 70,
          titleSpacing: 0,
          leading: InkWell(
            onTap: () {},
            child: Row(
              children: [
                Icon(Icons.arrow_back, size: 24),
                CircleAvatar(
                  child: SvgPicture.asset(
                    "assets/person.svg",
                    color: Colors.white,
                    height: 36,
                    width: 36,
                  ),
                  radius: 20,
                  backgroundColor: Colors.blueGrey,
                ),
              ],
            ),
          ),
          title: InkWell(
            child: Container(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  sourceChat!.name,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "last seen today 14:00",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            )),
          ),
        ),
      ),
      body: ListView.builder(
        itemBuilder: (_, index) => InkWell(
          onTap: () {
            Get.to(ChatView(
                chatmodel: chatmodels![index], sourceChat: sourceChat));
          },
          child: Column(
            children: [
              ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  child: SvgPicture.asset(
                    "assets/person.svg",
                    color: Colors.white,
                    height: 36,
                    width: 36,
                  ),
                  backgroundColor: Colors.blueGrey,
                ),
                title: Text(
                  chatmodels![index].name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Row(
                  children: [
                    Icon(Icons.done_all),
                    Text(chatmodels![index].currentMessage),
                  ],
                ),
                trailing: Text(chatmodels![index].time),
              ),
              Padding(
                padding: EdgeInsets.only(left: 80, right: 20),
                child: Divider(
                  thickness: 1,
                ),
              )
            ],
          ),
        ),
        itemCount: chatmodels!.length,
      ),
    );
  }
}
