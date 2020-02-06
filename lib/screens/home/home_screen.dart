import 'package:daily_amajo/models/antek.dart';
import 'package:daily_amajo/screens/home/encyclopedia_screen.dart';
import 'package:daily_amajo/screens/home/setting_form.dart';
import 'package:flutter/material.dart';
import 'package:daily_amajo/services/database.dart';
import 'package:provider/provider.dart';
import './antek_main.dart';
import './point_screen.dart';
import 'package:daily_amajo/widgets/app_drawer.dart';
import 'package:daily_amajo/widgets/bottom_navigation.dart';


class HomeScreen extends StatefulWidget {
  static const routeName = "/homeScreen";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Widget> widgets = [
    AntekMain(),
    PointScreen(),
    EncyclopediaScreen(),
  ];

  int _currentIndex = 0;

  void onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    void _showSettingPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
              child: SettingForm(),
            );
          });
    }

    return StreamProvider<List<Antek>>.value(
      // now, other trees get to access the value from Database
      value: DatabaseService().antek,
      child: Scaffold(
        backgroundColor: Colors.brown[100],
        appBar: AppBar(
          title: Text("Daily Antek!"),
          backgroundColor: Colors.brown[500],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
                onPressed: () => _showSettingPanel(),
                icon: Icon(Icons.settings),
                label: Text("settings"))
          ],
        ),
        body: IndexedStack(
          index: _currentIndex,
          children: widgets,
        ),
        bottomNavigationBar: BottomNavigation(onTap),
        drawer: AppDrawer(),
      ),
    );
  }
}
