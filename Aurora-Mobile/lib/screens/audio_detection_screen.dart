import 'package:flutter/material.dart';

class AudioDetectionScreen extends StatefulWidget {
  static const routeName = "/audio-detection-screen";

  @override
  _AudioDetectionScreenState createState() => _AudioDetectionScreenState();
}

class _AudioDetectionScreenState extends State<AudioDetectionScreen> {
  bool isAudioResultLoading = false;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: mediaQuery.padding.top,
          ),
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.elliptical(
                    mediaQuery.size.width,
                    200.0,
                  ),
                ),
                child: Image.asset(
                  "assets/images/AuroraLogoImage.png",
                  fit: BoxFit.cover,
                  height: mediaQuery.size.height * 0.4 - mediaQuery.padding.top,
                  width: double.infinity,
                ),
              ),
              Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(Icons.arrow_back, color: Colors.white,),
                    ),
                  ),
                  SizedBox(
                    height: mediaQuery.size.height * 0.1,
                  ),
                  Center(
                    child: Text(
                      "Audio Detection",
                      style: TextStyle(
                        fontSize: mediaQuery.size.height * 0.04,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            children: [
              SizedBox(
                height: mediaQuery.size.height * 0.1,
              ),
              Container(
                height: mediaQuery.size.width * 0.08,
                child: isAudioResultLoading ? Image.asset("assets/images/Loading.gif") : Image.asset("assets/images/blank.png"),
              ),
              SizedBox(height: mediaQuery.size.height * 0.01),
              Text(
                isAudioResultLoading ? "  Listening..." : "      ",
                style:
                    TextStyle(fontSize: mediaQuery.size.height * 0.035),
              ),
              SizedBox(
                height: mediaQuery.size.height * 0.13,
              ),
            ],
          ),
          FlatButton(
            onPressed: () {
              setState(() {
                isAudioResultLoading = true;
              });
            },
            padding: const EdgeInsets.all(10),
            child: Icon(
              Icons.mic,
              color: Colors.white,
              size: mediaQuery.size.height * 0.12,
            ),
            color: Colors.blue[700],
            shape: CircleBorder(),
          ),
        ],
      ),
    );
  }
}
