import 'package:daily_amajo/widgets/app_drawer.dart';
import 'package:daily_amajo/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:daily_amajo/models/user.dart';
import 'package:daily_amajo/services/database.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = "/profile";
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile  setting"),
      ),
      drawer: AppDrawer(),
      
      body: StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          // check if we have data coming in
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            return Column(children: <Widget>[
              Text(userData.userName),
              Text(userData.points.toString()),
              Text(userData.level.toString()),
            ],);
          } else {
            return Loading();
          }
        })
    );
  }
}
