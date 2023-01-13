import 'dart:ui';

// import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:aurora/musicplayer/isplaying_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MusicPlayerMediaPlayerScreen extends StatefulWidget {
  static const routeName = '/media-player-screen';

  @override
  _MusicPlayerMediaPlayerScreenState createState() => _MusicPlayerMediaPlayerScreenState();
}

class _MusicPlayerMediaPlayerScreenState extends State<MusicPlayerMediaPlayerScreen> {

  var routeArgs; 
  // var isPlaying;
  // AudioPlayer audioPlayer;
  // Function setIsPlayingFunction;
  String trackName;
  String trackArtist;

  bool isLooping;

  Duration _currentTime;
  Duration _endingTime;

  @override
  void didChangeDependencies() {
    routeArgs = ModalRoute.of(context).settings.arguments as List;
    // audioPlayer = routeArgs[0];
    // trackName = routeArgs[1];
    // trackArtist = routeArgs[2];

    isLooping = false;

    // audioPlayer.onAudioPositionChanged.listen((value) {
    //   setState(() {
    //     _currentTime = value; // this part creates a setState() called after dispose() error we can safely ignore it
    //   });
    // });
    // audioPlayer.onDurationChanged.listen((value) {
    //   setState(() {
    //     _endingTime = value;
    //   });
    // });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // final isPlayingProvider = Provider.of<IsPlayingProvider>(context);
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: mediaQuery.padding.top),
            width: double.infinity,
            height: mediaQuery.size.height - mediaQuery.padding.top,
            child: Image.network(
              "https://wallpaper-house.com/data/out/8/wallpaper2you_252592.jpg",
              fit: BoxFit.cover,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: mediaQuery.padding.top),
            width: double.infinity,
            height: mediaQuery.size.height - mediaQuery.padding.top,
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [
                Colors.black.withOpacity(1),
                Colors.black.withOpacity(0.7),
                Colors.transparent,
                Colors.transparent,
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            )),
          ),
          Column(
            children: <Widget>[
              SizedBox(
                height: mediaQuery.padding.top,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.arrow_back_ios_new),
                ),
              ),
              SizedBox(
                height: mediaQuery.size.height * 0.57,
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  // "  "+trackName,
                  "  ",
                  maxLines: 1,
                  softWrap: false,
                  overflow: TextOverflow.fade,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // get rid of this later
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  // "   "+trackArtist,
                  "   ",
                  maxLines: 1,
                  softWrap: false,
                  overflow: TextOverflow.fade,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white, // get rid of this later
                  ),
                ),
              ),
              Row(
                children: [
                  Text("     "+_currentTime.toString().split(".")[0]),
                  Spacer(),
                  Text(_endingTime.toString().split(".")[0]+"     ")
                ],
              ),
              Slider(
                min: 0,
                max: _endingTime==null ? 0 :_endingTime.inSeconds.toDouble(),
                value: _currentTime==null ? 0 :_currentTime.inSeconds.toDouble(),
                onChanged: (double newValue) {
                  Duration newCurrentDuration = Duration(seconds: newValue.toInt());
                  // audioPlayer.seek(newCurrentDuration);
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Spacer(),
                  IconButton(
                    onPressed: () {
                      if (isLooping == false) {
                        setState(() {
                          isLooping = true;
                        });
                      } else if (isLooping) {
                        setState(() {
                          isLooping = false;
                        });
                      }
                    },
                    icon: Icon(
                      isLooping ? Icons.repeat_on_outlined : Icons.repeat,
                      size: 35,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.skip_previous,
                      size: 35,
                    ),
                  ),
                  Center(
                    child: InkWell(
                      child: Icon(
                        // isPlayingProvider.isPlaying ? Icons.pause_circle : Icons.play_circle,
                        Icons.pause_circle,
                        size: 75,
                      ),
                      onTap: () {
                        // if (isPlayingProvider.isPlaying == true) {
                        //   setState(() {
                        //     isPlayingProvider.isPlaying = false;
                        //   });
                        //   isPlayingProvider.setIsPlaying(false);
                        //   audioPlayer.pause();
                        // } else if (isPlayingProvider.isPlaying == false) {
                        //   setState(() {
                        //     isPlayingProvider.isPlaying = true;
                        //   });
                        //   isPlayingProvider.setIsPlaying(true);
                        //   audioPlayer.resume();
                        // }

                        AudioPlayer audioPlayer = new AudioPlayer();
                        audioPlayer.play("https://soundcloud.com/hardphol/masked-wolf-astronaut-in-the-ocean-hardphol-remix-radio-edit");
                      },
                    ),
                  ),
                  IconButton(
                    onPressed: () {

                    },
                    icon: Icon(
                      Icons.skip_next,
                      size: 35,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        // isPlayingProvider.isPlaying = false;
                      });
                      // audioPlayer.stop();
                    },
                    icon: Icon(
                      Icons.stop,
                      size: 35,
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
