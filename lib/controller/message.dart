
import 'package:chat/model/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class MessageController extends GetxController{
  
  final String currentUser=FirebaseAuth.instance.currentUser!.uid;
  TextEditingController content =TextEditingController();
  RxList<MessageModel>messages=RxList();
  RxString errorMessage=RxString('');

  Future<void>addTextMessage({required String receiverId})async{
    final message =MessageModel(
      senderId: currentUser,
      receiverId: receiverId,
      content: content.text, 
      messageType: MessageType.text, 
      sentTime: Timestamp.now());
      await _addMessageToFireStore(receiverId: receiverId,message: message).then((_) {
        messages.add(message);
        content.clear();
      })
      .catchError((error) {
        errorMessage.value='Error adding message to Firestore: $error';
      });
  }

  Future<void>_addMessageToFireStore({required String receiverId,required MessageModel message}) async{
    List<String>ids=[receiverId,currentUser];
    ids.sort();
    String chatRoomId=ids.join('_');
    await FirebaseFirestore.instance.collection("chat_room")
                                    .doc(chatRoomId)
                                    .collection("message")
                                    .add(
                                      {
                                      'senderId': message.senderId,
                                      'receiverId': message.receiverId,
                                      'content': message.content,
                                      'messageType': message.messageType.toJson(),
                                      'sentTime': message.sentTime,
                                      }
                                    );
  }
  Future<void>fetchMessage(String receiverId)async{
    List<String>ids=[currentUser,receiverId];
    ids.sort();
    String chatroom=ids.join('_');
    try{
       QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection('chat_room')
                                        .doc(chatroom)
                                        .collection("message")
                                        .orderBy('sentTime', descending: false)
                                        .get();
       messages.clear();
       snapshot.docs.forEach((doc){
        Map<String,dynamic>message=doc.data();
        messages.add(MessageModel(
          senderId: message["senderId"], 
          receiverId: message["receiverId"], 
          content: message["content"],
          messageType: message["messageType"] == 'text' ? MessageType.text : MessageType.image, 
          sentTime: message["sentTime"]
          ));
       });
    }catch (e){
      errorMessage.value=e.toString();
    }
  }
}