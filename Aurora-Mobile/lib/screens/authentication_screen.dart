import 'package:aurora/widgets/authentication_form.dart';
import 'package:flutter/material.dart';

class AuthenticationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.5,
                child: Image.asset(
                  "assets/images/AuroraLogoImage.png",
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                child: SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints( maxHeight: MediaQuery.of(context).size.height),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          "Aurora",
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height * 0.06,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        AuthenticationForm(),
                        SizedBox(height: 20,),
                      ],
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
