import 'package:flutter/material.dart';

import 'bloc/bloc_provider.dart';
import 'bloc/game_bloc.dart';
import 'game.dart';
import 'models/game_model.dart';
import 'models/sports_model.dart';
import 'stream_widget.dart';

class GameList extends StatelessWidget {
  final SportsModel sport;

  GameList({@required this.sport});

  @override
  Widget build(BuildContext context) {
    final GameBloc _bloc = BlocProvider.of<GameBloc>(context);

    return Scaffold(
        appBar: AppBar(title: Text(sport.title)),
        body: StreamWidget<List<GameModel>>(
            stream: _bloc.getGamesIn(sport),
            builder: (context, games) => ListView.builder(
                itemCount: games.length,
                itemBuilder: (context, index) => ListTile(
                    title: Text(games[index].title),
                    subtitle: Text(games[index].summary),
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Game(game: games[index]))))),
            placeholder: Center(child: CircularProgressIndicator())));
  }
}
