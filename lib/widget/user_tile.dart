
import 'package:chat/pages/chat/chat_room.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserTile extends StatelessWidget {
  final String email;
  final String id;
  //final Function onTap;
  const UserTile({super.key,required this.email,required this.id});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 70,
      margin: const EdgeInsets.only(bottom: 10),
       child: ListTile(
      leading:Container(
            width: 50,
            height: 50,
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Image(image: NetworkImage("https://cdn.icon-icons.com/icons2/3708/PNG/512/man_person_people_avatar_icon_230017.png")),
          ),
        title: Text(email,style: TextStyle(fontWeight: FontWeight.bold),),
        trailing: GestureDetector(
          onTap:(){Get.to(ChatRoom(),arguments: {'receiverId':id});},
          child: Icon(Icons.arrow_forward_ios_sharp,color: Colors.blue,),
        ),
      ),
    );
  }
}
