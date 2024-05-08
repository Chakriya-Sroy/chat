
import 'package:cloud_firestore/cloud_firestore.dart';
class MessageModel {
  final String senderId;
  final String receiverId;
  final String content;
  final Timestamp sentTime;
  final MessageType messageType;
  const MessageModel(
      {required this.senderId,
      required this.receiverId,
      required this.content,
      required this.messageType,
      required this.sentTime});

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
        senderId: json["senderId"],
        receiverId: json["receiverId"],
        content: json["content"],
        sentTime: json["sentTime"],
        messageType: json["messageType"],
      );
  }
}

enum MessageType {
  text,
  image,
  audio;
  String toJson()=>name;
}
