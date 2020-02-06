import 'package:flutter/material.dart';


class BottomNavigation extends StatefulWidget {
  final Function onTap;
  BottomNavigation(this.onTap);

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _currentIndex = 0;

  onTap(int index) {
    setState(() {
      this._currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.brown[200],
          onTap: (int index) {
            widget.onTap(index);
            onTap(index);
          },
          currentIndex: _currentIndex,

      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text('Home'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          title: Text('points'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_view_day),
          title: Text('encyclopedia'),
        ),
      ],
    );
  }
}

