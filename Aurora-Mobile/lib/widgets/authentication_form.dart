import 'dart:io';

import 'package:aurora/models/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

enum AuthMode { Signup, Login }

class AuthenticationForm extends StatefulWidget {
  @override
  _AuthenticationFormState createState() => _AuthenticationFormState();
}

class _AuthenticationFormState extends State<AuthenticationForm> {
  final GlobalKey<FormState> formKey = GlobalKey();
  AuthMode authMode = AuthMode.Login;
  var isLoading = false;
  final passwordController = TextEditingController();

  Map<String, String> authData = {
    'name': '',
    'firstname': '',
    'lastname': '',
    'email': '',
    'password': '',
  };

  @override
  Widget build(BuildContext context) {
    final mediaQuerySize = MediaQuery.of(context).size;

    void switchAuthMode() {
      if (authMode == AuthMode.Login) {
        setState(() {
          authMode = AuthMode.Signup;
        });
      } else {
        setState(() {
          authMode = AuthMode.Login;
        });
      }
    }

    void submit(BuildContext context) async {
      if (!formKey.currentState.validate()) {
        return;
      }
      formKey.currentState.save();
      if (authMode == AuthMode.Login) {
        // Log user in
        AuthenticationService().login({
            "name": authData['name'],
            "password": authData['password'],
        }, context);
      } else {
        // Sign user up
        AuthenticationService().signup(authData, context);
      }
    }

    return Center(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        elevation: 8.0,
        child: Container(
          height: authMode == AuthMode.Signup
              ? mediaQuerySize.height * 0.8
              : mediaQuerySize.height * 0.46,
          constraints: BoxConstraints(
              minHeight: authMode == AuthMode.Signup
                  ? mediaQuerySize.height * 0.8
                  : mediaQuerySize.height * 0.46),
          width: mediaQuerySize.width * 0.75,
          padding: EdgeInsets.symmetric(
            vertical: 40,
            horizontal: 16,
          ),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Text(
                    authMode == AuthMode.Login ? "LOGIN" : "SIGNUP",
                    style: TextStyle(
                        fontSize: mediaQuerySize.height * 0.04,
                        fontWeight: FontWeight.bold),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Username'),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Invalid UserName!';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      authData['name'] = value;
                    },
                  ),
                  authMode == AuthMode.Signup
                      ? TextFormField(
                          decoration: InputDecoration(labelText: 'First name'),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Invalid firstname!';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            authData['firstname'] = value;
                          },
                        )
                      : Container(),
                  authMode == AuthMode.Signup
                      ? TextFormField(
                          decoration: InputDecoration(labelText: 'Last name'),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Invalid lastname!';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            authData['lastname'] = value;
                          },
                        )
                      : Container(),

                  authMode == AuthMode.Signup
                  ? TextFormField(
                    decoration: InputDecoration(labelText: 'E-Mail'),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value.isEmpty || !value.contains('@')) {
                        return 'Invalid email!';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      authData['email'] = value;
                    },
                  ) : Container(),

                  TextFormField(
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    controller: passwordController,
                    validator: (value) {
                      if (value.isEmpty || value.length < 5) {
                        return 'Password is too short!';
                      }
                    },
                    onSaved: (value) {
                      authData['password'] = value;
                    },
                  ),

                  if (authMode == AuthMode.Signup)
                    TextFormField(
                      enabled: authMode == AuthMode.Signup,
                      decoration:
                          InputDecoration(labelText: 'Confirm Password'),
                      obscureText: true,
                      validator: authMode == AuthMode.Signup
                          ? (value) {
                              if (value != passwordController.text) {
                                return 'Passwords do not match!';
                              }
                            }
                          : null,
                    ),
                  SizedBox(
                    height: 20,
                  ),

                  if (isLoading)
                    CircularProgressIndicator()
                  else
                    RaisedButton(
                      child: Text(
                          authMode == AuthMode.Login ? 'LOGIN' : 'SIGN UP'),
                      onPressed: () {
                        submit(context); // passing context for the snackbar
                        print(authData); 
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
                      color: Theme.of(context).primaryColor,
                      textColor:
                          Theme.of(context).primaryTextTheme.button.color,
                    ),
                  FlatButton(
                    child: Text(
                        '${authMode == AuthMode.Login ? 'SIGNUP' : 'LOGIN'} INSTEAD'),
                    onPressed: switchAuthMode,
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    textColor: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
