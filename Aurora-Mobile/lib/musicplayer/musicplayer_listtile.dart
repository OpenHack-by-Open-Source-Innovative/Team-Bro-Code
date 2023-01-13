import 'dart:async';

// import 'package:audioplayers/audioplayers.dart';
import 'package:aurora/musicplayer/isplaying_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MusicPlayerListTile extends StatefulWidget {
  final trackImagePath;
  final trackName;
  final trackArtist;
  Function listTileOnpressedFunction;
  var songPath;
  // AudioPlayer audioPlayer;

  // MusicPlayerListTile(this.trackImagePath, this.trackName, this.trackArtist, this.listTileOnpressedFunction, this.songPath, this.audioPlayer);
  MusicPlayerListTile(this.trackImagePath, this.trackName, this.trackArtist, this.listTileOnpressedFunction, this.songPath);

  @override
  _MusicPlayerListTileState createState() => _MusicPlayerListTileState();
}

class _MusicPlayerListTileState extends State<MusicPlayerListTile> {
  

  @override
  Widget build(BuildContext context) {
    // final isPlayingProvider = Provider.of<IsPlayingProvider>(context);
    return ListTile(
      leading: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Image.asset(widget.trackImagePath),
      ),
      title: Text(widget.trackName),
      subtitle: Text(widget.trackArtist),
      onTap: () {
        // widget.listTileOnpressedFunction(widget.trackName, widget.trackArtist);
        // widget.audioPlayer.stop(); // stop the song currently playing
        // widget.audioPlayer.play(widget.songPath, isLocal: true);   // start playing the next song
      },
    );
  }
}