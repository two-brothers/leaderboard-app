import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:leaderboard_app/sports/eight_ball_config.dart';

import '../bloc/bloc_provider.dart';
import '../bloc/game_bloc.dart';
import '../bloc/player_bloc.dart';
import '../sports/display_leader.dart';
import '../sports/display_record.dart';
import '../models/game_model.dart';
import '../models/player_model.dart';
import '../models/record_model.dart';
import '../common/stream_widget.dart';
import 'new_match.dart';

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
            body: ConditionalBuilder(
              condition: game.leaderboard.length > 0,
              builder: (context) => Container(
                  padding: EdgeInsets.all(16),
                  child: Column(children: <Widget>[
                    if (game.id == "QF05QGMyiIMxUsiYQROJ")
                      RaisedButton(
                        child: Text("Start Game"),
                        onPressed: () =>
                            Navigator.push(context, MaterialPageRoute(builder: (context) => EightBallConfig())),
                      ),
                    StreamWidget<PlayerModel>(
                        stream: _playerBloc.getPlayerStreamByRef(game.leaderboard[0].playerRef),
                        builder: (context, player) => DisplayLeader(
                            player: player, record: game.leaderboard[0], winningStreak: game.winningStreak)),
                    Expanded(
                        child: ListView.builder(
                            itemCount: game.leaderboard.length - 1,
                            itemBuilder: (context, listIdx) {
                              final int recordIdx = listIdx +
                                  1; // this list starts from the second record (the leader is displayed above)
                              final Record record = game.leaderboard[recordIdx];
                              return StreamWidget<PlayerModel>(
                                  stream: _playerBloc.getPlayerStreamByRef(record.playerRef),
                                  builder: (context, player) => DisplayRecord(
                                      rank: recordIdx + 1, player: player, record: game.leaderboard[recordIdx]),
                                  placeholder: ListTile(title: Text('...')));
                            }))
                  ])),
            ),
            floatingActionButton: FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () =>
                    Navigator.push(context, MaterialPageRoute(builder: (context) => NewMatch(game: game))))),
        placeholder: Center(child: CircularProgressIndicator()));
  }
}
