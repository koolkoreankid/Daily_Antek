import 'package:daily_amajo/widgets/quote_list.dart';
import 'package:flutter/material.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:async';

class EncyclopediaScreen extends StatefulWidget {
  static const routeName = "/pointShop";
  @override
  _EncyclopediaScreenState createState() => _EncyclopediaScreenState();
}

class _EncyclopediaScreenState extends State<EncyclopediaScreen> {
  // List antek = [];
  // Future<String> loadAsset() async {
  //   return await rootBundle.loadString('assets/texts/AntekQuotes.txt');
  // }

  // Future<void> lit() async {
  //   await rootBundle.loadString('assets/texts/AntekQuotes.txt').then((val) {
  //     var string = val.replaceAll("\"", '');
  //     antek = string.split("\n").map((String text) => text).toList();
  //     print(antek.length);
  //   });
  // }

  Future<List> getQuotes() async {
    List antek;
    await rootBundle.loadString('assets/texts/AntekQuotes.txt').then((val) {
      var string = val.replaceAll("\"", '');
      antek = string.split("\n").map((String text) => text).toList();
    });
    return antek;
  }

  Widget projectWidget() {
    return FutureBuilder(
      builder: (context, projectSnap) {
        if (projectSnap.connectionState == ConnectionState.none &&
            projectSnap.hasData == null) {
          //print('project snapshot data is: ${projectSnap.data}');
          return Container();
        }
        return ListView.builder(
          itemCount: projectSnap.data.length,
          itemBuilder: (context, index) {
            return QuoteList(
              quote: projectSnap.data[index],
            );
          },
        );
      },
      future: getQuotes(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return projectWidget();
  }
}

