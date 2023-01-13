import 'dart:io';

import 'package:aurora/main.dart';
import 'package:aurora/models/authentication_service.dart';
import 'package:aurora/screens/loading_screen.dart';
import 'package:aurora/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SideDrawer extends StatefulWidget {

  @override
  _SideDrawerState createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  var userdata;

  FileImage profilePhoto;

  Widget menuListTiles(BuildContext ctx,IconData icon, String name, Function onPressed) {
    return ListTile(
      leading: Icon(
        icon,
        size: 30,
      ),
      title: Text(
        name,
        style: TextStyle(
          fontSize: 20
        ),
      ),
      onTap: onPressed,
    );
  }

  @override
  Future<void> didChangeDependencies() async {
    userdata = await AuthenticationService().getSharedPrefStored();

    SharedPreferences profilePicPrefs = await SharedPreferences.getInstance();
    if(profilePicPrefs.getString("profile-picture") != null) {
      setState(() {
        profilePhoto = FileImage(File(profilePicPrefs.getString("profile-picture")));
      });
    }
    
    super.didChangeDependencies();
    setState(() {});     // to update the ui
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(30),
        bottomRight: Radius.circular(30),
      ),
      child: Drawer(  
        child: Column(
          children: <Widget>[
            SizedBox(height: 50,),
            Container(
              child: ListTile(
                leading: CircleAvatar(
                  // backgroundColor: Colors.amber,
                  backgroundImage: profilePhoto == null ? AssetImage("assets/images/FacialRecognition.png") : profilePhoto,
                  radius: 50,
                ),
                title: Text(
                  userdata==null ? "username":userdata[0],
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
                subtitle: Text(userdata==null ? "email":userdata[3]),
              ),
            ),
            Center(child: Container(width: 200,height: 1,color: Theme.of(context).colorScheme.onSurface,margin: EdgeInsets.only(top: 20),),),
            Expanded(
              child: ListView(
                children: <Widget>[
                  menuListTiles(context, Icons.home_filled, "Home",(){
                    Navigator.of(context).pushReplacementNamed("/");
                  },),
                  menuListTiles(context, Icons.person, "Profile",(){
                    Navigator.of(context).pushNamed(ProfileScreen.routeName, arguments: {"username" : userdata[0], "email" : userdata[3]});
                  },),
                  menuListTiles(context, Icons.favorite, "Favorites",(){},),
                  menuListTiles(context, Icons.location_on, "Nearby Me",(){},),
                  menuListTiles(context, Icons.notifications_active, "Notifications",(){},),
                  Center(child: Container(width: 200,height: 1,color: Theme.of(context).colorScheme.onSurface,margin: EdgeInsets.all(20),),),
                  menuListTiles(context, Icons.settings, "Setting",(){},),
                  menuListTiles(context, Icons.attach_money, "Promotions",(){},),
                  menuListTiles(context, Icons.headset_mic, "Help",(){},),
                  menuListTiles(context, Icons.logout, "Log out",() async {
                    var userdata = await AuthenticationService().getSharedPrefStored();
                    setState(() {
                      userdata[4] = "";
                      AuthenticationService().saveSharedPrefStored(userdata);
                      main();
                    });
                  },),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
