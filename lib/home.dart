import 'package:flutter/material.dart';
import 'players/players_list.dart';
import 'sports/sports_list.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Home")),
        body: ListView(children: <Widget>[
          ListTile(title: Text('Sports'), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SportsList()))),
          ListTile(title: Text('Players'), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => PlayersList())))
        ]));
  }
}
