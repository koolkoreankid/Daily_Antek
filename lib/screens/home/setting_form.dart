import 'package:daily_amajo/services/database.dart';
import 'package:flutter/material.dart';
import 'package:daily_amajo/widgets/loading.dart';
import 'package:provider/provider.dart';

import 'package:daily_amajo/models/user.dart';

class SettingForm extends StatefulWidget {
  @override
  _SettingFormState createState() => _SettingFormState();
}

class _SettingFormState extends State<SettingForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> mood = ['0', '1', '2', '3', '4'];

  int _currentmood;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          // check if we have data coming in
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text("change Antek's mood "),
                  Text(userData.level.toString()),
                  SizedBox(
                    height: 10,
                  ),
                  Slider(
                    value: (_currentmood ?? 0).toDouble(),
                    min: 0.0,
                    max: 100.0,
                    divisions: 10,
                    onChanged: (val) =>
                        setState(() => _currentmood = val.round()),
                  ),
                  SizedBox(child: Text(_currentmood.toString())),
                  FlatButton.icon(
                      onPressed: () async {
                        await DatabaseService(uid: user.uid).updateUserData(
                            userData.userName,
                            userData.level,
                            userData.points + 1,
                            userData.mood);
                      },
                      icon: Icon(Icons.add),
                      label: Text("increment")),
                  FlatButton.icon(
                      onPressed: () async {
                        await DatabaseService(uid: user.uid).updateUserData(
                            userData.userName,
                            userData.level,
                            userData.points - 1,
                            userData.mood);
                      },
                      icon: Icon(Icons.add),
                      label: Text("decrement")),
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
