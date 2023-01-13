import 'package:aurora/models/authentication_service.dart';
import 'package:aurora/screens/audio_detection_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class WelcomeText extends StatefulWidget {
  @override
  _WelcomeTextState createState() => _WelcomeTextState();
}

class _WelcomeTextState extends State<WelcomeText> {
  var username = "";

  @override
  Future<void> didChangeDependencies() async {
    username = (await AuthenticationService().getSharedPrefStored())[0];
    super.didChangeDependencies();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Row(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Welcome",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(height: 3,),
              Text(
                "Hello $username :)",
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 3,),
              Text(
                DateFormat.yMMMMd("en_US").format(DateTime.now()),
                style: TextStyle(fontSize: 15),
              ),
            ],
          ),
          Spacer(),
          FlatButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AudioDetectionScreen.routeName);
            },
            child: Image.asset(
              'assets/images/voice.png',
              width: 60,
            ),
            shape: CircleBorder(),
          ),
        ],
      ),
    );
  }
}
