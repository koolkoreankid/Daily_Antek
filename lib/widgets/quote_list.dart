import 'package:flutter/material.dart';

class QuoteList extends StatelessWidget {
  final quote;
  QuoteList({this.quote});

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
            child: Text("BBB"),
          ),
          title: Text("Antek Klosinski:"),
          subtitle: Padding(padding: EdgeInsets.only(top: 5, bottom: 5), child: Text(quote)),
        ),
      ),
    );
  }
}
