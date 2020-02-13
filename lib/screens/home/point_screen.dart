import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:daily_amajo/models/user.dart';
import 'package:daily_amajo/services/database.dart';
import 'package:daily_amajo/widgets/loading.dart';

class PointScreen extends StatefulWidget {
  static const routeName = "/pointScreen";
  @override
  _PointScreenState createState() => _PointScreenState();
}

class _PointScreenState extends State<PointScreen> {
  final _formKey = GlobalKey<FormState>();
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
                  FlatButton.icon(
                      onPressed: () async {
                        await DatabaseService(uid: user.uid).updateUserData(
                            userData.userName,
                            userData.level,
                            userData.points + 1,
                            userData.mood,
                            userData.quoteNum);
                      },
                      icon: Icon(Icons.add),
                      label: Text("increment")),
                  FlatButton.icon(
                      onPressed: () async {
                        await DatabaseService(uid: user.uid).updateUserData(
                            userData.userName,
                            userData.level,
                            userData.points - 1,
                            userData.mood,
                            userData.quoteNum);
                      },
                      icon: Icon(Icons.add),
                      label: Text("decrement")),
                  FlatButton.icon(
                      onPressed: () async {
                        if (userData.points - 5 < 0) {
                          Scaffold.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "You do not have any points",
                                textAlign: TextAlign.center,
                              ),
                              duration: const Duration(seconds: 1),
                            ),
                          );
                        } else {
                          await DatabaseService(uid: user.uid).updateUserData(
                              userData.userName,
                              userData.level,
                              userData.points - 5,
                              userData.mood,
                              userData.quoteNum + 1);
                        }
                      },
                      icon: Icon(Icons.add),
                      label: Text("unlock one antek quote")),
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
