import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:leaderboard_app/models/player_model.dart';

class EightBall extends StatelessWidget {
  final List<PlayerModel> players;

  EightBall({@required this.players});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text("Eight Ball")),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: players
              .map((player) => Column(
                    children: <Widget>[Text(player.name), Text("0")],
                  ))
              .toList(),
        ),
      );
}
