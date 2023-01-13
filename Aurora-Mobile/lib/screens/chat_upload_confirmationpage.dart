import 'package:aurora/screens/socialmedia_chat_upload_page.dart';
import 'package:flutter/material.dart';

class ChatUploadConfirmationPage extends StatelessWidget {
  static const routeName = '/chat-upload-confirmation-page';

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: mediaQuery.size.height * 0.08,),
            Center(child: Image.asset("assets/images/conformationPage/chatUploadPage.png", height: mediaQuery.size.width * 0.8,),),
            SizedBox(height: mediaQuery.size.height * 0.08,),
            Center(child: Text("Upload a story", style: TextStyle(fontSize: mediaQuery.size.height*0.04, fontWeight: FontWeight.bold, color: mediaQuery.platformBrightness == Brightness.dark ? Colors.white : Colors.blue.shade900,),),),
            Center(child: Text("Find the best matches", style: TextStyle(fontSize: mediaQuery.size.height*0.04, fontWeight: FontWeight.bold, color: mediaQuery.platformBrightness == Brightness.dark ? Colors.white : Colors.blue.shade900,),),),
            SizedBox(height: mediaQuery.size.height * 0.08,),
            RaisedButton(
              color: Colors.pink.shade300,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                child: Text(
                  "Get Started",
                  style: TextStyle(
                    fontSize: mediaQuery.size.height*0.04,
                    color: Colors.white,
                  ),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(SocialMediaChatUploadPage.routeName);
              },
            )
          ],
        ),
      ),
    );
  }
}