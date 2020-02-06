import 'package:flutter/material.dart';
import 'package:daily_amajo/models/antek.dart';

class Ranking extends StatelessWidget {

  final Antek anteks;
  Ranking({this.anteks});

  @override
  Widget build(BuildContext context) {
    return Padding(
              padding: EdgeInsets.only(top: 8),
              child: Card(
                margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.brown[100],
                  ),
                  title: Text(anteks.userName),
                  subtitle: Text("Level: " + anteks.level.toString() + ", points: " + anteks.points.toString()) ,
                ),
              ),
            );
  }
}