import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chat/controller/message.dart';
import 'package:chat/controller/user.dart';
import 'package:chat/widget/bubble_chat.dart';

class ChatRoom extends StatefulWidget {
  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  final UserController userController = Get.put(UserController());
  final receiverId = Get.arguments['receiverId'];
  final MessageController messageController = Get.put(MessageController());
  @override
  void initState() {
    super.initState();
    messageController.fetchMessage(receiverId);
  }

  @override
  Widget build(BuildContext context) {
    var user = userController.findUser(receiverId).first;
    return Scaffold(
      backgroundColor: Colors.blue.shade500,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                ChatHeader(user: user.email.split('@').first),
                ChatBody(),
                SizedBox(
                  height: 120,
                )
              ],
            ),
            ChatAction()
          ],
        ),
      ),
    );
 }

  Expanded ChatBody() {
    return Expanded(
                child: Container(
                    padding: EdgeInsets.only(left: 25, right: 25, top: 25),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(45),
                          topRight: Radius.circular(45)),
                      color: Colors.white,
                    ),
                    child: Obx(() => ListView.builder(
                        //physics: BouncingScrollPhysics(),
                        itemCount: messageController.messages.length,
                        itemBuilder: (context, index) {
                          final message = messageController.messages[index];
                          final isCurrentUser = message.senderId ==
                              messageController.currentUser;
                          return BubbleChat(
                              content: message.content,
                              isSender: isCurrentUser);
                        }))),
              );
  }

  Positioned ChatAction() {
    return Positioned(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 120,
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                color: Colors.white,
                child: TextField(
                  controller: messageController.content,
                  decoration: InputDecoration(
                    hintText: 'Type your message...',
                    suffixIcon: GestureDetector(
                      onTap: () {
                        messageController.addTextMessage(
                          receiverId: receiverId,
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.blue.shade500),
                        padding: EdgeInsets.all(14),
                        child: Icon(
                          Icons.send_rounded,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.blueGrey[50],
                    labelStyle: TextStyle(fontSize: 12),
                    contentPadding: EdgeInsets.all(20),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey.shade50),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey.shade50),
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}

Container ChatHeader({required String user}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 25),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Icon(
                Icons.arrow_back_ios,
                size: 25,
                color: Colors.white,
              ),
            ),
            Container(
            width: 50,
            height: 50,
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Image(image: NetworkImage("https://cdn.icon-icons.com/icons2/3708/PNG/512/man_person_people_avatar_icon_230017.png")),
          ),
            Text(
              user,
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ],
        ),
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.black12,
              ),
              child: Icon(
                Icons.call,
                size: 25,
                color: Colors.white,
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.black12,
              ),
              child: Icon(
                Icons.videocam,
                size: 25,
                color: Colors.white,
              ),
            ),
          ],
        )
      ],
    ),
  );
}
