import 'package:flutter/material.dart';

class BubbleChat extends StatelessWidget {
  final String content;
  late bool isSender = true;
  BubbleChat({super.key, required this.content, required this.isSender});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(20),
        margin: isSender
            ? EdgeInsets.only(left: MediaQuery.of(context).size.width / 2,bottom: 2)
            : EdgeInsets.only(right: MediaQuery.of(context).size.width / 2,bottom: 2),
        decoration: isSender
            ? BoxDecoration(
                color: Color.fromARGB(255, 153, 187, 255),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
              )
            : BoxDecoration(
                color: Color.fromARGB(255, 67, 116, 216),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
        child: isSender
            ? Text(content)
            : Text(
                content,
                style: TextStyle(color: Colors.white),
              ));
  }
}
