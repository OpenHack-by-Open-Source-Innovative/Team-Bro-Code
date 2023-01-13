import 'dart:io';

import 'package:aurora/main.dart';
import 'package:aurora/musicplayer/musicplayer_mediaplayer_screen.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';

import '../musicplayer/musicplayer_listtile.dart';
import 'package:flutter/material.dart';
import 'package:path_provider_ex/path_provider_ex.dart';
import 'package:flutter_file_manager/flutter_file_manager.dart';
// import 'package:audioplayers/audioplayers.dart';

class MusicPlayerHomeScreen extends StatefulWidget {
  static const routeName = "/music-player-home-screen";

  @override
  _MusicPlayerHomeScreenState createState() => _MusicPlayerHomeScreenState();
}

class _MusicPlayerHomeScreenState extends State<MusicPlayerHomeScreen> {
  int songIndex;
  var isPermissionGranted = false;
  String trackName = "";
  String trackArtist = "";
  var musicFiles;

  Future getStorageAccessPermission() async {      // showing a popup to get the storage access from the user
    while (!isPermissionGranted) {
      if (await Permission.storage.request().isGranted) {
        setState(() {
          isPermissionGranted = true;
        });
        break;
      }
    }
  }


  @override
  void initState() {
    getStorageAccessPermission();
    musicFiles = [];
    super.initState();
  }

  @override
  void didChangeDependencies() {
    getMusicFiles();
    super.didChangeDependencies();
  }

  void trackListTileOnpressedFunction(tName, tArtist) {
    setState(() {
      trackName = tName;
      trackArtist = tArtist;
    });
  }

  void getMusicFiles() async {   // works only for android 10
    // getting all the music files from the internal storage
    // List<StorageInfo> storageInfo = await PathProviderEx.getStorageInfo();
    // var root = storageInfo[0].rootDir; //for SD card use storageInfo[1], here i am getting the root directory
    // print(root);
    // var fileManager = FileManager(root: Directory(root));
    // var files = await fileManager.filesTree(
    //   excludedPaths: ["/storage/emulated/0/Android"], // look for mp3 files anywahere but not here
    //   extensions: ["mp3"] //to to filter the other files and get only mp3 files
    // );
    // setState(() {
    //   musicFiles = files;
    // });
    // setState(() {}); //update the UI otherwise error will come
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: mediaQuery.padding.top),
                width: double.infinity,
                height: (mediaQuery.size.height * 0.32),
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Image.asset("assets/images/musicIcon3.png"),
              ),
              Column(
                children: [
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
                    height: mediaQuery.size.height * 0.18,
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      "  " + trackName,
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
                      "    " + trackArtist,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white, // get rid of this later
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: IconButton(
                      icon: Icon(Icons.keyboard_arrow_down),
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                          MusicPlayerMediaPlayerScreen.routeName,
                          // arguments: [audioPlayer, trackName, trackArtist],
                        );
                      }
                    ),
                  ),
                ],
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (ctx, index) {
                // print("             "+musicFiles[1].path);
                songIndex = index;
                var stringSong = "${musicFiles[songIndex]}".split("/")[5];
                var songArtist = "";
                // return MusicPlayerListTile("assets/images/musicIcon1.png",stringSong,"",trackListTileOnpressedFunction,musicFiles[songIndex].path,audioPlayer);
              },
              itemCount: musicFiles.length,
            ),
          ),
        ],
      ),
    );
  }
}
