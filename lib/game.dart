import 'package:flutter/material.dart';

import 'bloc/bloc_provider.dart';
import 'bloc/game_bloc.dart';
import 'bloc/player_bloc.dart';
import 'display_record.dart';
import 'models/game_model.dart';
import 'models/player_model.dart';
import 'new_match.dart';

class Game extends StatelessWidget {
  final GameModel game;

  Game({@required this.game});

  @override
  Widget build(BuildContext context) {
    final PlayerBloc _playerBloc = BlocProvider.of<PlayerBloc>(context);
    final GameBloc _gameBloc = BlocProvider.of<GameBloc>(context);

    return StreamBuilder<GameModel>(
        stream: _gameBloc.getGame(game.id),
        builder: (context, gameSnapshot) => gameSnapshot.hasData
            ? Scaffold(
                appBar: AppBar(title: Text(gameSnapshot.data.title)),
                body: Container(
                    padding: EdgeInsets.all(16),
                    child: Column(children: <Widget>[
                      Expanded(
                          child: ListView.builder(
                              itemCount: gameSnapshot.data.leaderboard.length,
                              itemBuilder: (context, index) => StreamBuilder<PlayerModel>(
                                  stream: _playerBloc.getPlayerStreamByRef(gameSnapshot.data.leaderboard[index].playerRef),
                                  builder: (context, playerSnapshot) => playerSnapshot.hasData
                                      ? DisplayRecord(
                                          rank: index + 1, player: playerSnapshot.data, record: gameSnapshot.data.leaderboard[index])
                                      : ListTile(title: Text('...')))))
                    ])),
                floatingActionButton: FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => NewMatch(game: gameSnapshot.data)))))
            : Center(child: CircularProgressIndicator()));
  }
}
