import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cmp_crew/Screens/Register.dart';
import 'package:cmp_crew/Screens/SignIn.dart';

class Authentication extends StatefulWidget {
  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  bool signIn = true;
  void toggleView()
  {
    setState(() {
      signIn = !signIn;
    });
  }
  @override
  Widget build(BuildContext context) {
    return signIn ? SignIn(toggleView: toggleView) : Register(toggleView: toggleView);
  }
}
