import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  Map<String, dynamic> messageMap;
  ChatBubble(this.messageMap);  // got from chatbotscreen

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: !messageMap["isFromChatbot"] ? MainAxisAlignment.end : MainAxisAlignment.start, 
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: !messageMap["isFromChatbot"] ? Colors.indigo[800] : Colors.yellow, 
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), 
              topRight: Radius.circular(30), 
              bottomLeft: messageMap["isFromChatbot"] ? Radius.circular(0) : Radius.circular(30), 
              bottomRight: !messageMap["isFromChatbot"] ? Radius.circular(0) : Radius.circular(30), 
            ),
          ),
          width: (messageMap["textMessage"].length).toDouble() + 175,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          margin: EdgeInsets.symmetric(
            vertical: 4,
            horizontal: 8,
          ),

          child: Column(      
          crossAxisAlignment: !messageMap["isFromChatbot"] ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                messageMap["textMessage"],
                style: TextStyle(
                  color: !messageMap["isFromChatbot"] ? Colors.white : Colors.black, 
                  fontSize: 16,
                ),
                // textAlign: isMe ? TextAlign.end : TextAlign.start,  
              ),
            ],
          ),
        ),
      ],
    );
  }
}