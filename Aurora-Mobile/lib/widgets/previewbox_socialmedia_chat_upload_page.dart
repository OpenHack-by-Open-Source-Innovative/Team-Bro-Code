import 'dart:io';
import 'package:aurora/screens/loading_screen.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class PreviewBoxSocialMediaChatUploadPage extends StatefulWidget {
  File image;
  var textBox;
  PreviewBoxSocialMediaChatUploadPage(this.image, this.textBox);

  @override
  _PreviewBoxSocialMediaChatUploadPageState createState() => _PreviewBoxSocialMediaChatUploadPageState();
}

class _PreviewBoxSocialMediaChatUploadPageState extends State<PreviewBoxSocialMediaChatUploadPage> {
  final textController = TextEditingController();
  bool summarizeText = false;
  bool limitExceeded = false;




  Future<void> postToLocalHostSummarizer(String longText) async {
    final response = await http.post(Uri.parse("http://10.0.2.2:80/summarize?text=$longText&limit=500"));
    final decodedResponse = json.decode(response.body) as Map<String, dynamic>;
    textController.clear();
    textController.text = decodedResponse["text"];
    print(decodedResponse["text"]);
  }



  Future<void> postImageToLocalHost(File image, BuildContext context) async {
    Navigator.of(context).pushNamed(LoadingScreen.routeName);
    String url = "http://10.0.2.2:5000/extract_text_from_img";
    var request = http.MultipartRequest('POST', Uri.parse(url));
    var picture = await http.MultipartFile.fromPath("file", image.path).then((picture) async {
      request.files.add(picture);
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      var decodedResponse = jsonDecode(response.body) as Map<String, dynamic>;
      print(decodedResponse["extracted"]);
      Navigator.of(context).pop();
    });
  }



  bool limitExceededChecker(BuildContext context) {
    Scaffold.of(context).hideCurrentSnackBar();
    if (textController.text.split(" ").length>500) {
      setState(() {
        limitExceeded = true;
      });
      WidgetsBinding.instance.addPostFrameCallback((_){
        Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text("Maximum number of words allowed is 500"),
          backgroundColor: Colors.red,
        ),
      );
      });

    } else {
      setState(() {
        limitExceeded = false;
      });
    }
    return limitExceeded;
  }



  @override
  Widget build(BuildContext context) {
    final mediaQuerySize = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        DottedBorder(
          dashPattern: widget.image == null ? [15,8] : [5, 0],
          color: Colors.blue.shade900,
          borderType: BorderType.RRect,
          strokeWidth: 3,
          radius: Radius.circular(20),
          child: Container(
              width: mediaQuerySize.width * 0.8,
              height: mediaQuerySize.width*0.85,
              child: widget.textBox 
              ? TextField(
                controller: textController,
                maxLines: 20,
                decoration: InputDecoration(
                  hintText: " Add your text message",
                  border: InputBorder.none,
                ),
                onChanged: (value) => limitExceededChecker(context),
              )
              : widget.image != null ? Image(
                image: FileImage(widget.image),
                fit: BoxFit.contain,
              ) : Container(),
          ),
        ),
        if(limitExceeded) Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Checkbox(
              value: summarizeText, 
              activeColor: Colors.red,
              checkColor: Colors.white,
              shape: CircleBorder(),
              onChanged: (value){
                setState(() {
                  summarizeText = value;
                });
                if(summarizeText) {
                  postToLocalHostSummarizer(textController.text);
                }
              },
            ),

            Text("Summarize Text?"),
            SizedBox(width: 25,)
          ],
        ),

        SizedBox(height: mediaQuerySize.height * 0.02,),

        RaisedButton(
          color: Colors.blue.shade900,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          onPressed: () {
            if (widget.textBox) {
              textController.clear();
              setState(() {
                summarizeText = false;
              });
            }else {
              // upload the ImageFile to api
              postImageToLocalHost(widget.image, context);
            }
          },
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Text(
              "Find Me",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
        )
      ],
    );
  }
}