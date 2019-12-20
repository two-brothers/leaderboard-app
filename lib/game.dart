import 'package:flutter/material.dart';

import 'models/game_model.dart';

class Game extends StatelessWidget {
  final GameModel game;

  Game({@required this.game});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(game.title)),
      body: Container(padding: EdgeInsets.all(16), child: Text(game.summary, style: Theme.of(context).textTheme.title)),
    );
  }
}
