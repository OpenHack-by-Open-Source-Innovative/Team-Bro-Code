import 'package:aurora/widgets/message_area.dart';
import 'package:aurora/widgets/new_message.dart';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class ChatbotScreen extends StatefulWidget {
  static const routeName = "chatbot-screen";

  bool appBar;
  ChatbotScreen(this.appBar);

  @override
  _ChatbotScreenState createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  List<Map<String, dynamic>> messageList = [];

  Future<void> sendMessageToLocalhostServer(String textMesssage) async {
    setState(() {
      messageList.add({
        "isFromChatbot": false,
        "textMessage": textMesssage,
      });
    });

    final response = await http
        .post(Uri.parse("http://10.0.2.2:80/response?msg=$textMesssage"));
    final decodedResponse = json.decode(response.body) as Map<String, dynamic>;
    print(decodedResponse["text"]);

    setState(() {
      messageList.add({
        "isFromChatbot": true,
        "textMessage": decodedResponse["text"],
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.appBar ? AppBar(
        centerTitle: true,
        title: Text("Chatbot", style: TextStyle(color: Colors.blue[800],),),
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ) : null,
      body: Column(
        children: <Widget>[
          Expanded(child: MessageArea(messageList)),
          NewMessage(sendMessageToLocalhostServer),
        ],
      ),
    );
  }
}
