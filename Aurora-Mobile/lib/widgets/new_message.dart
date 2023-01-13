import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class NewMessage extends StatefulWidget {
  Function postTextMsgToLocalhostServer;

  NewMessage(this.postTextMsgToLocalhostServer);

  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final textController = TextEditingController();
  String textMessage = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Card(
        // color: Colors.white60,
        elevation: 0,
        shape: StadiumBorder(
          // borderRadius: BorderRadius.circular(50);
          side: BorderSide(
            color: Theme.of(context).colorScheme.onSecondary,
            width: 1,
          )
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 18.0,),
          child: Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                controller: textController,
                decoration: InputDecoration(
                  hintText: 'Send a message...',
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  setState(() {
                    textMessage = value;
                  });
                },
              )),
              IconButton(
                onPressed: () {
                  if (textMessage.trim().isNotEmpty) {
                    widget.postTextMsgToLocalhostServer(textMessage);
                  }
                  textController.clear();
                },
                icon: Icon(Icons.send),
                color: Colors.blue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
