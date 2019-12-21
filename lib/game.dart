import 'package:flutter/material.dart';

import 'bloc/bloc_provider.dart';
import 'bloc/player_bloc.dart';
import 'models/game_model.dart';
import 'models/player_model.dart';

class Game extends StatelessWidget {
  final GameModel game;

  Game({@required this.game});

  @override
  Widget build(BuildContext context) {
    final PlayerBloc bloc = BlocProvider.of<PlayerBloc>(context);

    return Scaffold(
      appBar: AppBar(title: Text(game.title)),
      body: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              Text(game.summary, style: Theme.of(context).textTheme.title),
              Expanded(
                child: ListView.builder(
                    itemCount: game.leaderboard.length,
                    itemBuilder: (context, index) => StreamBuilder<PlayerModel>(
                        stream: bloc.getPlayerStreamByRef(game.leaderboard[index].playerRef),
                        builder: (context, snapshot) => ListTile(
                            title: Text(
                                '${index + 1}. ${snapshot.hasData ? game.leaderboard[index].display(snapshot.data) : '...'}')))),
              )
            ],
          )),
    );
  }
}
