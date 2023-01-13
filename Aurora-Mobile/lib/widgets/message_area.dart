import 'package:aurora/widgets/chat_bubble.dart';
import 'package:flutter/material.dart';

class MessageArea extends StatefulWidget {
  List<Map<String, dynamic>> messageList;

  MessageArea(this.messageList);  // got from ChatBotScreen

  @override
  _MessageAreaState createState() => _MessageAreaState();
}

class _MessageAreaState extends State<MessageArea> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.messageList.length,
      itemBuilder: (ctx, index) => ChatBubble(widget.messageList[index]),
    );
  }
}