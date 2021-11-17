class ChatModel {
  late String name;
  late String icon;
  late String time;
  late String currentMessage;
  late String? status;
  bool select = false;
  late bool isGroup;
  late int id;

  ChatModel({
    required this.name,
    required this.time,
    required this.icon,
    required this.currentMessage,
    this.status,
    this.select = false,
    required this.isGroup,
    required this.id,
  });
}

class MessageModel {
  late String? type;
  late String? message;
  late String? time;

  MessageModel({this.type, this.message, this.time});
}
