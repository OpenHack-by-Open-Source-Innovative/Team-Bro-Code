import 'package:flutter/material.dart';

  // this is used in the social media chat upload screen

class ChatUploadButtonsRow extends StatefulWidget {    
  Function pickImage;
  Function pickedImageFromGallary;
  Function uploadText;
  ChatUploadButtonsRow(this.pickImage, this.pickedImageFromGallary, this.uploadText);   
  @override
  _ChatUploadButtonsRowState createState() => _ChatUploadButtonsRowState();
}

class _ChatUploadButtonsRowState extends State<ChatUploadButtonsRow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
          width: 90,
          height: 130,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey.shade400,
          ),
          child: new Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              highlightColor: Colors.transparent,
              onTap: widget.pickedImageFromGallary,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 0,
                  vertical: 20
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Icon(Icons.add_circle_outline, color: Colors.black,),
                    Text("Upload", style: TextStyle(color: Colors.black),),
                    Text("from device", style: TextStyle(color: Colors.black),),
                  ],
                ),
              ),
            ),
          ),
        ),
        Container(
          width: 90,
          height: 130,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.yellow.shade300,
          ),
          child: new Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              highlightColor: Colors.transparent,
              onTap: widget.uploadText,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 0,
                  vertical: 19,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text("Aa", style: TextStyle(fontSize: 20, color: Colors.black),),
                    Text("Upload", style: TextStyle(color: Colors.black),),
                    Text("Text", style: TextStyle(color: Colors.black),)
                  ],
                ),
              ),
            ),
          ),
        ),
        Container(
          width: 90,
          height: 130,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
                colors: [
                  Colors.greenAccent,
                  Colors.lightBlue.shade300,
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
          ),
          child: new Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              highlightColor: Colors.transparent,
              onTap: widget.pickImage,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 0,
                  vertical: 20
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Icon(Icons.camera, color: Colors.black,),
                    Text("Open my", style: TextStyle(color: Colors.black),),
                    Text("Camera", style: TextStyle(color: Colors.black),)
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
