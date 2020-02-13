import 'package:daily_amajo/widgets/app_drawer.dart';
import 'package:daily_amajo/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:daily_amajo/models/user.dart';
import 'package:daily_amajo/services/database.dart';
import 'package:provider/provider.dart';
import 'package:daily_amajo/widgets/constants.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = "/profile";

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String changedUserName = '';
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = new TextEditingController();

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
                return Column(
                  children: <Widget>[
                    Text(userData.userName),
                    Text(userData.points.toString()),
                    Text(userData.level.toString()),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            controller: _controller,
                            decoration: textInputDecoration.copyWith(
                                hintText: "user name"),
                            validator: (val) =>
                                val.isEmpty ? "Enter new user name" : null,
                            onChanged: (val) {
                              setState(() => changedUserName = val);
                            },
                          ),
                          RaisedButton(
                            color: Colors.blue,
                            child: Text("Register"),
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                _controller.clear();
                                await DatabaseService(uid: user.uid)
                                    .updateUserData(
                                        changedUserName,
                                        userData.level,
                                        userData.points,
                                        userData.mood,
                                        userData.quoteNum);
                              }
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                );
              } else {
                return Loading();
              }
            }));
  }
}
