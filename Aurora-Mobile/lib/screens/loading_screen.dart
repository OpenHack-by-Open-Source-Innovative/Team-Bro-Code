import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  static const routeName = "/loading-screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(),
            SizedBox(height: 10,),
            Text("Please wait...", style: TextStyle(fontSize: 25),),
          ],
        ),
      ),
    );
  }
}