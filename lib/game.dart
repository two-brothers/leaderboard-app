import 'package:flutter/material.dart';

import 'bloc/bloc_provider.dart';
import 'bloc/game_bloc.dart';
import 'bloc/player_bloc.dart';
import 'display_record.dart';
import 'models/game_model.dart';
import 'models/player_model.dart';
import 'new_match.dart';
import 'stream_widget.dart';

class Game extends StatelessWidget {
  final GameModel game;

  Game({@required this.game});

  @override
  Widget build(BuildContext context) {
    final PlayerBloc _playerBloc = BlocProvider.of<PlayerBloc>(context);
    final GameBloc _gameBloc = BlocProvider.of<GameBloc>(context);

    return StreamWidget<GameModel>(
        stream: _gameBloc.getGame(game.id),
        builder: (context, game) => Scaffold(
            appBar: AppBar(title: Text(game.title)),
            body: Container(
                padding: EdgeInsets.all(16),
                child: Column(children: <Widget>[
                  Expanded(
                      child: ListView.builder(
                          itemCount: game.leaderboard.length,
                          itemBuilder: (context, index) => StreamWidget<PlayerModel>(
                              stream: _playerBloc.getPlayerStreamByRef(game.leaderboard[index].playerRef),
                              builder: (context, player) => DisplayRecord(rank: index + 1, player: player, record: game.leaderboard[index]),
                              placeholder: ListTile(title: Text('...')))))
                ])),
            floatingActionButton: FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => NewMatch(game: game))))),
        placeholder: Center(child: CircularProgressIndicator()));
  }
}
