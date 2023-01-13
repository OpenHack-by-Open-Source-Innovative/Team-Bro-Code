// import 'package:audioplayers/audioplayers.dart';
import 'package:aurora/models/authentication_service.dart';
import 'package:aurora/musicplayer/isplaying_provider.dart';
import 'package:aurora/musicplayer/musicplayer_homescreen.dart';
import 'package:aurora/musicplayer/musicplayer_mediaplayer_screen.dart';
import 'package:aurora/screens/audio_detection_screen.dart';
import 'package:aurora/screens/authentication_screen.dart';
import 'package:aurora/screens/chat_upload_confirmationpage.dart';
import 'package:aurora/screens/chatbot_screen.dart';
import 'package:aurora/screens/facial_depression_detection_screen.dart';
import 'package:aurora/screens/facial_recognition_confirmationpage.dart';
import 'package:aurora/screens/loading_screen.dart';
import 'package:aurora/screens/profile_screen.dart';
import 'package:aurora/screens/socialmedia_chat_upload_page.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import './screens/bottom_navbar_screen.dart';

import './providers/themeProvider.dart';

import './screens/home_screen.dart';
import 'package:flutter/material.dart';

// AudioPlayer audioPlayer = new AudioPlayer(mode: PlayerMode.MEDIA_PLAYER); // used in MusicPlayerHomeScreen in the musicplayer folder

bool tokenIsValid = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  tokenIsValid = await AuthenticationService().checkTokenValidity();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => IsPlayingProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        themeMode: ThemeMode.system,
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        home: authenticationSuccessfull ? BottomNavBarScreen() : (tokenIsValid ? BottomNavBarScreen() : AuthenticationScreen()),
        routes: {
          ChatUploadConfirmationPage.routeName : (ctx) => ChatUploadConfirmationPage(),
          FacialRecognitionConfirmationPage.routeName : (ctx) => FacialRecognitionConfirmationPage(),
          SocialMediaChatUploadPage.routeName : (ctx) => SocialMediaChatUploadPage(true),
          MusicPlayerHomeScreen.routeName : (ctx) => MusicPlayerHomeScreen(), 
          MusicPlayerMediaPlayerScreen.routeName : (ctx) => MusicPlayerMediaPlayerScreen(),
          AudioDetectionScreen.routeName : (ctx) => AudioDetectionScreen(),
          LoadingScreen.routeName : (ctx) => LoadingScreen(),
          ProfileScreen.routeName : (ctx) => ProfileScreen(),
          ChatbotScreen.routeName : (ctx) => ChatbotScreen(true),
          FacialDepressionDetectionScreen.routeName : (ctx) => FacialDepressionDetectionScreen(),
        },
      ),
    );
  }
}