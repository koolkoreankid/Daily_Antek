import 'package:daily_amajo/widgets/app_drawer.dart';
import 'package:daily_amajo/widgets/loading.dart';
import 'package:daily_amajo/widgets/ranking.dart';
import 'package:flutter/material.dart';
import 'package:daily_amajo/models/antek.dart';
import 'package:daily_amajo/services/database.dart';

class CommunityScreen extends StatefulWidget {
  static const routeName = "/communityScreen";
  @override
  _CommunityScreenState createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  // return ListView.builder(
  //   itemCount: antek.length,
  //   itemBuilder: (context, index) {
  //     print(user.uid);
  //     print(jot);

  //     return AntekTile(antek: antek[index]);
  //   },
  // );

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Antek>>(
      stream: DatabaseService().antek,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Antek> antek = snapshot.data;
          return Scaffold(
              appBar: AppBar(
                title: Text("Community Screen"),
              ),
              drawer: AppDrawer(),
              body: ListView.builder(
                itemCount: antek.length,
                itemBuilder: (context, index) {
                  return Ranking(anteks: antek[index]);
                },
              ));
        } else {
          return Loading();
        }
      },
    );
  }
}
