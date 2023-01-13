import 'dart:io';

import 'package:aurora/models/authentication_service.dart';
import 'package:aurora/screens/authentication_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart'as path;
import 'package:path_provider/path_provider.dart' as systempath;
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = "/profile-page";

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  FileImage profilePhoto;


  void pickProfileImageAndStore() async {
    final pickedImage = await ImagePicker.pickImage(
      source: ImageSource.camera,
    );
    storingProfileImageInLocalStorage(pickedImage);
  }

  void pickProfileImageFromGalleryAndStore() async {                 
    final pickedImage = await ImagePicker.pickImage(
      source: ImageSource.gallery,
    );
    storingProfileImageInLocalStorage(pickedImage);
  }

  void storingProfileImageInLocalStorage(File profilePhoto) async {
    print(profilePhoto);
    print("storing");
    if (profilePhoto != null){
      final applicationDirectory = await systempath.getApplicationDocumentsDirectory();
      final imagefilename = path.basename(profilePhoto.path);
      final savedImage = await profilePhoto.copy("${applicationDirectory.path}/$imagefilename");
      print(applicationDirectory);
      print(imagefilename);
      print(savedImage);


      SharedPreferences profilePicPrefs = await SharedPreferences.getInstance();
      profilePicPrefs.setString('profile-picture', savedImage.path);

      gettingProfileImageFromLocalStorage();
    }
  }

  Future<void> gettingProfileImageFromLocalStorage() async {
    SharedPreferences profilePicPrefs = await SharedPreferences.getInstance();
    if(profilePicPrefs.getString("profile-picture") != null) {
      setState(() {
        profilePhoto = FileImage(File(profilePicPrefs.getString("profile-picture")));
      });
    }
  }

  @override
  void didChangeDependencies() {
    gettingProfileImageFromLocalStorage();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {


    final routeArgs = ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Column(
            children: [
              SizedBox(
                height: mediaQuery.padding.top,
              ),
              Container(
                height: mediaQuery.size.height * 0.4,
                child: Image.asset(
                  "assets/images/AuroraLogoImage.png",
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: mediaQuery.padding.top,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop(); // 1 more pop to pop the side drawer also
                  },
                  icon: Icon(
                    Icons.arrow_back_outlined,
                    color: Colors.white,
                  ),
                ),
              ),
              Text(
                "Profile",
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: mediaQuery.size.height * 0.08,
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 8,
                child: Container(
                  width: mediaQuery.size.width * 0.9,
                  height: mediaQuery.size.width * 0.55,
                  padding: EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 10,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey[200],
                        child: CircleAvatar(
                          radius: 45,
                          // backgroundColor: Colors.amber,
                          backgroundImage: profilePhoto == null ? AssetImage("assets/images/FacialRecognition.png") : profilePhoto,
                        ),
                      ),
                      Text(
                        routeArgs["username"],
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        routeArgs["email"],
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: mediaQuery.size.height * 0.02,
              ),
              Expanded(
                child: ListView(
                  children: <Widget>[
                    ListTile(
                      leading: CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.blue,
                        child: Icon(
                          Icons.image,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      title: Text(
                        "Change profile photo",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      onTap: () => showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text("Change Profile Picture"),
                          content: Text("Select the method you prefer to set a new profile picture"),
                          actions: <Widget>[
                            FlatButton(
                              child: Text("Take picture right now"),
                              onPressed: () {
                                pickProfileImageAndStore();
                                // setState(() {});
                                Navigator.of(context).pop();
                              }, 
                            ),
                            FlatButton(
                              child: Text("Pick an image from gallery"),
                              onPressed: () {
                                pickProfileImageFromGalleryAndStore();
                                // setState(() {});
                                Navigator.of(context).pop();
                              }, 
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ListTile(
                      leading: CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.blue,
                        child: Icon(
                          Icons.logout,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      title: Text(
                        "Log out",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      onTap: () async {
                        var userdata =
                            await AuthenticationService().getSharedPrefStored();
                        setState(() {
                          userdata[4] = "";
                          AuthenticationService().saveSharedPrefStored(userdata);
                          main();
                          Navigator.of(context).pop();
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
