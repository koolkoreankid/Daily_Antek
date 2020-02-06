import 'package:daily_amajo/screens/authenticate/signin_Screen.dart';
import 'package:flutter/material.dart';
import 'package:daily_amajo/screens/authenticate/register.dart';

class AuthenticateScreen extends StatefulWidget {
  static const routeName = "/authenticateScreen";
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<AuthenticateScreen> {

  bool showSignIn = true;

  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignInScreen(toggleView: toggleView);
    } else {
      return Register(toggleView: toggleView);
    }
  }
}