import 'package:daily_amajo/screens/authenticate/authenticate_screen.dart';
import 'package:daily_amajo/screens/home/profile_screen.dart';
import 'package:daily_amajo/screens/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:daily_amajo/services/auth.dart';
import 'package:daily_amajo/models/user.dart';
import 'package:daily_amajo/screens/home/community_screen.dart';
import 'package:daily_amajo/screens/home/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // <User> is the type of model that will be passed
    return StreamProvider<User>.value(
      // this user value will be passed on when updated
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
        routes: {
          HomeScreen.routeName: (ctx) => HomeScreen(),
          CommunityScreen.routeName: (ctx) => CommunityScreen(),
          AuthenticateScreen.routeName: (ctx) => AuthenticateScreen(),
          ProfileScreen.routeName: (ctx) => ProfileScreen()
        },
      ),
    );
  }
}
