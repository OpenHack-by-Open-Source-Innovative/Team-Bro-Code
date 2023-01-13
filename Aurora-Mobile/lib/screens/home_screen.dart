import 'package:aurora/providers/themeProvider.dart';
import '../widgets/welcome_text.dart';

import '../widgets/featurs_grid.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Column(
        children: <Widget>[
          WelcomeText(),
          MediaQuery.of(context).size.height<700 ? Container(): Spacer(flex: 1,),
          Expanded(
            flex: 40,
            child: FeaturesGrid()
          ),
        ],
      ),
    );
  }
}
