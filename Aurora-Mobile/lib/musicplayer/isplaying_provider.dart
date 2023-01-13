// import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class IsPlayingProvider with ChangeNotifier {
  bool isPlaying = false;
  // AudioPlayer audioPlayer = new AudioPlayer(mode: PlayerMode.MEDIA_PLAYER);

  void setIsPlaying (bool isplaying) {
    this.isPlaying = isplaying;
    notifyListeners();
  }
}