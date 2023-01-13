import 'package:aurora/musicplayer/musicplayer_homescreen.dart';
import 'package:aurora/screens/chat_upload_confirmationpage.dart';
import 'package:aurora/screens/chatbot_screen.dart';
import 'package:aurora/screens/facial_recognition_confirmationpage.dart';
import 'package:flutter/material.dart';

class FeaturesGrid extends StatelessWidget {

  void chatUploadPageFunction(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(ChatUploadConfirmationPage.routeName);
  }
  void facialRecognitionPageFuncion(ctx) {
    Navigator.of(ctx).pushNamed(FacialRecognitionConfirmationPage.routeName);
  }
  void musicPlayerPageFunction(ctx) {
    Navigator.of(ctx).pushNamed(MusicPlayerHomeScreen.routeName);
  }
  void chatbotPageFunction(ctx) {
    Navigator.of(ctx).pushNamed(ChatbotScreen.routeName);
  }

  Widget customGridTile(BuildContext ctx, String imagePath, Function onTap, String side) { // 4th arg is to give the margin for the left or right side
    return Container(
      margin: side=='left' ? EdgeInsets.only(left: 15, top: 5, bottom: 5, right: 5): EdgeInsets.only(left: 5, top: 5, bottom: 5, right: 15) ,
      decoration: BoxDecoration(
        color: MediaQuery.of(ctx).platformBrightness == Brightness.dark ? Colors.grey[900] : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey.withOpacity(0.25),
            spreadRadius: 2,
            blurRadius: 2,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent, // if you Commentout this line, the container color will get lighter
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Image.asset(
              imagePath, fit: BoxFit.fitHeight,
            ),
          ),
          onTap: onTap,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 1.3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      children: <Widget>[
        customGridTile(context, 'assets/images/SocialMedia.png', (){},'left'),
        customGridTile(context, 'assets/images/FacialRecognition.png', ()=> facialRecognitionPageFuncion(context),''),
        customGridTile(context, 'assets/images/ChatBot.png', ()=>chatbotPageFunction(context),'left'),
        customGridTile(context, 'assets/images/Status.png', ()=>chatUploadPageFunction(context),''),
        customGridTile(context, 'assets/images/PlayList.png', ()=>musicPlayerPageFunction(context), 'left'),
        customGridTile(context, 'assets/images/Maps.png', (){}, ''),
      ],
    );
  }
}
