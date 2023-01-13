import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:aurora/widgets/chat_upload_buttons_row.dart';
import 'package:aurora/widgets/previewbox_socialmedia_chat_upload_page.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SocialMediaChatUploadPage extends StatefulWidget {
  var appbar;

  SocialMediaChatUploadPage(this.appbar);
  
  static const routeName = '/social-media-chat-upload-page';

  @override
  _SocialMediaChatUploadPageState createState() => _SocialMediaChatUploadPageState();
}

class _SocialMediaChatUploadPageState extends State<SocialMediaChatUploadPage> {
  File _image; 
  var textBox = false;

  void pickImage() async {                              // thsi function is for the chatUploadrow thing
    setState(() {
      textBox = false;
    });
    final pickedImage = await ImagePicker.pickImage(
      source: ImageSource.camera,
    );
    setState(() {
      _image = pickedImage;
    });
  }
  
  void pickImageFromGallery() async {                              // thsi function is for the chatUploadrow thing
    setState(() {
      textBox = false;
    });
    final pickedImage = await ImagePicker.pickImage(
      source: ImageSource.gallery,
    );
    setState(() {
      _image = pickedImage;
    });
  }

  void uploadText() {
    setState(() {
      textBox = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: widget.appbar ?  AppBar(
        centerTitle: true,
        title: Text("Upload Chat", style: TextStyle(fontSize: 30, color: Theme.of(context).colorScheme.onSurface),),
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.onSurface,
        ),
        elevation: 0,
      ) : null,
      body: Container(
        height: mediaQuery.size.height - mediaQuery.padding.top - mediaQuery.padding.bottom,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height:widget.appbar ? 30 : 10,),
              ChatUploadButtonsRow(pickImage, pickImageFromGallery, uploadText),
              SizedBox(height: mediaQuery.size.height * 0.04,),
              PreviewBoxSocialMediaChatUploadPage(_image, textBox)
            ],
          ),
        ),
      ),
    );
  }
}