import 'package:daily_amajo/screens/home/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:daily_amajo/screens/home/community_screen.dart';
import 'package:daily_amajo/screens/home/home_screen.dart';
import 'package:daily_amajo/services/auth.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            backgroundColor: Colors.brown[400],
            title: Text("Drawer"),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.child_care),
            title: Text("Daily Antek"),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.child_care),
            title: Text("My Profile"),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(ProfileScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.colorize),
            title: Text("Community"),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(CommunityScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.backspace),
            title: Text("Log out"),
            onTap: () async {
              await _auth.signOut();

            },
          )
        ],
      ),
    );
  }
}
