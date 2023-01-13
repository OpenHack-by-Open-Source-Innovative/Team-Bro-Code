import 'dart:convert';

import 'package:aurora/screens/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

bool authenticationSuccessfull = false;

class AuthenticationService {



  //                                                   Youtube VIDEOOOOOOO

  //if the user tyoed sccount is diff then do something to avoid having the username nme of another acc and the email of another acc

  // if user entered username(in form) is != getSharedpref username (do shared pref in form in the onpressed part and see) then dont display and dont save the email.
 

  Future<void> login(Map<String, String> authData, BuildContext context) async {
    Navigator.of(context).pushNamed(LoadingScreen.routeName);
    final response = await http.post(Uri.parse("https://auroramobile.herokuapp.com/authenticateUser"), body: authData,).then((response) async {
      final decodedResponse = json.decode(response.body) as Map<String, dynamic>;
      print(decodedResponse);
      authenticationSuccessfull = decodedResponse['isSuccessfull'];
      Scaffold.of(context).hideCurrentSnackBar();
      if (!decodedResponse['isSuccessfull']) {
        Scaffold.of(context).showSnackBar(SnackBar(content: Text(decodedResponse['message'], style: TextStyle(fontWeight: FontWeight.bold),), backgroundColor: Colors.red,));
      } else {
        
        // updating the token which is stored in the device every time the user logs in
        var userDetails = await getSharedPrefStored();
        userDetails[0] = authData["name"];
        userDetails[4] = decodedResponse['authToken'];
        saveSharedPrefStored(userDetails);

      }
      Navigator.of(context).pop();

      main();
    });
  }

  Future<void> signup(Map<String, String> authData, BuildContext context) async {
    final response = await http.post(Uri.parse("https://auroramobile.herokuapp.com/addNewUser"), body: authData,);
    final decodedResponse = json.decode(response.body) as Map<String, dynamic>;
    print(decodedResponse);
    authenticationSuccessfull = decodedResponse['isSuccessfull'];
    Scaffold.of(context).hideCurrentSnackBar();
    if (!decodedResponse['isSuccessfull']) {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text(decodedResponse['message'], style: TextStyle(fontWeight: FontWeight.bold),), backgroundColor: Colors.red,));
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text(decodedResponse['message'], style: TextStyle(fontWeight: FontWeight.bold),),duration: Duration(seconds: 2),));

      // logining in the user automatically
      final autoLoginResponse = await http.post(Uri.parse("https://auroramobile.herokuapp.com/authenticateUser"), body: {
        'name' : authData['name'],
        'password' : authData['password'],
      },);
      final autoDecodedLoginResponse = json.decode(autoLoginResponse.body) as Map<String, dynamic>;
      print(autoDecodedLoginResponse);


      // storing data in the device
      saveSharedPrefStored([
        authData['name'],
        authData['firstname'],
        authData['lastname'],
        authData['email'],
        autoDecodedLoginResponse['authToken'],  // the token
      ]);

    }
    main();
  }


  Future<bool> checkTokenValidity() async {

    var userData = await getSharedPrefStored();
    var boolValue;

    final response = await http.get(Uri.parse("https://auroramobile.herokuapp.com/getUserInfo"), headers: {'Authorization' : "Bearer ${userData[4]}"}).then((response) {   // i used heroku so that any device can access make the requests from anywhere 
      try {  
        final decodedResponse = json.decode(response.body) as Map<String, dynamic>;
        print(decodedResponse);
        if (decodedResponse['isSuccessfull']) {
          boolValue = true;
        } else {
          boolValue = false;
        }

      } on Exception catch (e) {
        print(e);
        authenticationSuccessfull = false;
        boolValue = false;
      }

    });
    return boolValue;
  }


  Future<List<String>> getSharedPrefStored() async {
    // getting the sharedPreferences which are saved
    SharedPreferences pref = await SharedPreferences.getInstance();
    var userData = pref.getStringList("userData");
    print("Sharedpref    $userData");
    if (userData == null) {
      return ["","","","",""];
    }
    return userData;
  }

  void saveSharedPrefStored(List<String> userdata) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();   
    prefs.setStringList("userData", userdata);
  }

  // below code is for the normal localhost(Before putting heroku)

  // Future<void> login(Map<String, String> authData, BuildContext context) async {
  //   Navigator.of(context).pushNamed(LoadingScreen.routeName);
  //   final response = await http.post(Uri.parse("http://10.0.2.2:3000/authenticateUser"), body: authData,).then((response) async {
  //     final decodedResponse = json.decode(response.body) as Map<String, dynamic>;
  //     print(decodedResponse);
  //     authenticationSuccessfull = decodedResponse['isSuccessfull'];
  //     Scaffold.of(context).hideCurrentSnackBar();
  //     if (!decodedResponse['isSuccessfull']) {
  //       Scaffold.of(context).showSnackBar(SnackBar(content: Text(decodedResponse['message'], style: TextStyle(fontWeight: FontWeight.bold),), backgroundColor: Colors.red,));
  //     } else {
        
  //       // updating the token which is stored in the device every time the user logs in
  //       var userDetails = await getSharedPrefStored();
  //       userDetails[4] = decodedResponse['authToken'];
  //       saveSharedPrefStored(userDetails);

  //     }
  //     Navigator.of(context).pop();

  //     main();
  //   });
  // }

  // Future<void> signup(Map<String, String> authData, BuildContext context) async {
  //   final response = await http.post(Uri.parse("http://10.0.2.2:3000/addNewUser"), body: authData,);
  //   final decodedResponse = json.decode(response.body) as Map<String, dynamic>;
  //   print(decodedResponse);
  //   authenticationSuccessfull = decodedResponse['isSuccessfull'];
  //   Scaffold.of(context).hideCurrentSnackBar();
  //   if (!decodedResponse['isSuccessfull']) {
  //     Scaffold.of(context).showSnackBar(SnackBar(content: Text(decodedResponse['message'], style: TextStyle(fontWeight: FontWeight.bold),), backgroundColor: Colors.red,));
  //   } else {
  //     Scaffold.of(context).showSnackBar(SnackBar(content: Text(decodedResponse['message'], style: TextStyle(fontWeight: FontWeight.bold),),duration: Duration(seconds: 2),));

  //     // logining in the user automatically
  //     final autoLoginResponse = await http.post(Uri.parse("http://10.0.2.2:3000/authenticateUser"), body: {
  //       'name' : authData['name'],
  //       'password' : authData['password'],
  //     },);
  //     final autoDecodedLoginResponse = json.decode(autoLoginResponse.body) as Map<String, dynamic>;
  //     print(autoDecodedLoginResponse);


  //     // storing data in the device
  //     saveSharedPrefStored([
  //       authData['name'],
  //       authData['firstname'],
  //       authData['lastname'],
  //       authData['email'],
  //       autoDecodedLoginResponse['authToken'],  // the token
  //     ]);

  //   }
  //   main();
  // }


  // Future<bool> checkTokenValidity() async {
  //   var userData = await getSharedPrefStored();

  //   try {
  //     final response = await http.get(Uri.parse("http://10.0.2.2:3000/getUserInfo"), headers: {'Authorization' : "Bearer ${userData[4]}"});  // i used heroku so that any device can access make the requests from anywhere 
  //     final decodedResponse = json.decode(response.body) as Map<String, dynamic>;
  //     print(decodedResponse);
  //     if (decodedResponse['isSuccessfull']) {
  //       return true;
  //     } else {
  //       return false;
  //     }

  //   } on Exception catch (e) {
  //      print(e);
  //      authenticationSuccessfull = false;
  //      return false;
  //   }
  // }
 
}