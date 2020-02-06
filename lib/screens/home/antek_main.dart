import 'package:flutter/material.dart';
// import 'package:daily_amajo/models/antek.dart';
import 'package:provider/provider.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:daily_amajo/widgets/loading.dart';
import 'package:daily_amajo/models/user.dart';
import 'package:daily_amajo/services/database.dart';

class AntekMain extends StatefulWidget {
  @override
  _AntekListState createState() => _AntekListState();
}

class _AntekListState extends State<AntekMain> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    // final antek = Provider.of<List<Antek>>(context) ?? [];
    // return ListView.builder(
    //   itemCount: antek.length,
    //   itemBuilder: (context, index) {
    //     print(user.uid);
    //     print(jot);

    //     return AntekTile(antek: antek[index]);
    //   },
    // );
    //userData.level.

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          // check if we have data coming in
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            var _imageUrl = userData.imageStatus();
            return Column(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Text("+" + userData.level.toString() + " Antek",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold)),
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            FlatButton(
                              child: Text("Upgrade"),
                              color: Colors.blue[200],
                              onPressed: () {},
                            ),
                            SizedBox(height: 30),
                            FlatButton(
                              child: Text("Quotes"),
                              color: Colors.blue[200],
                              onPressed: () {},
                            ),
                            SizedBox(height: 30),
                            FlatButton(
                              child: Text("update"),
                              color: Colors.blue[200],
                              onPressed: () {
                                setState(() {
                                  _imageUrl = userData.imageStatus();
                                  print(_imageUrl);
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 7,
                        child: Image.asset(_imageUrl),
                      ),
                      Expanded(
                        flex: 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            FlatButton(
                              child: Text("press me"),
                              color: Colors.blue[200],
                              onPressed: () {},
                            ),
                            SizedBox(height: 30),
                            FlatButton(
                              child: Text("press me"),
                              color: Colors.blue[200],
                              onPressed: () {},
                            ),
                            SizedBox(height: 30),
                            FlatButton(
                              child: Text("press me"),
                              color: Colors.blue[200],
                              onPressed: () {},
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 3, // 20%
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Text(userData.points.toString()),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      RawMaterialButton(
                        onPressed: () async {
                          if (userData.checkZero() == true) {
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
                            if (userData.upgrade() == false) {
                              showDialog(
                                  context: context,
                                  builder: (_) => AssetGiffyDialog(
                                        image: Image.asset(
                                            "assets/images/antek_trig.gif"),
                                        title: Text("You failed haha"),
                                        description: Text("Do it again"),
                                        entryAnimation: EntryAnimation.DEFAULT,
                                        buttonRadius: 10,
                                        buttonCancelColor: Colors.pink,
                                        onlyCancelButton: true,
                                      ));
                              await DatabaseService(uid: user.uid)
                                  .updateUserData(userData.userName, userData.level = 1,
                                      userData.points - 1, userData.mood);
                            } else {
                              await DatabaseService(uid: user.uid)
                                  .updateUserData(userData.userName, userData.level + 1,
                                      userData.points - 1, userData.mood);
                            }
                          }

                          setState(() {
                            _imageUrl = userData.imageStatus();
                          });
                        },
                        child: Text("upgrade"),
                        shape: new CircleBorder(),
                        elevation: 2.0,
                        fillColor: Colors.blue,
                        padding: const EdgeInsets.all(25.0),
                      ),
                    ],
                  ),
                )
              ],
            );
          } else {
            return Loading();
          }
        });
  }
}
