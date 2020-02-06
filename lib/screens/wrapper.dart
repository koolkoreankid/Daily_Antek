import 'package:daily_amajo/screens/authenticate/authenticate_screen.dart';
import 'package:daily_amajo/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:daily_amajo/models/user.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // since we are listening, we define the data
    final user = Provider.of<User>(context);
    //either home or authenticate
    if (user == null) {
      return AuthenticateScreen();
    } else{
      return HomeScreen();
    }
  }
}