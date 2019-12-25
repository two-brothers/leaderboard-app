import 'package:flutter/material.dart';

import 'bloc/bloc_provider.dart';
import 'bloc/game_bloc.dart';
import 'game.dart';
import 'models/game_model.dart';
import 'models/sports_model.dart';

class GameList extends StatelessWidget {
  final SportsModel sport;

  GameList({@required this.sport});

  @override
  Widget build(BuildContext context) {
    final GameBloc _bloc = BlocProvider.of<GameBloc>(context);

    return StreamBuilder<List<GameModel>>(
        stream: _bloc.getGamesIn(sport),
        builder: (context, snapshot) => Scaffold(
            appBar: AppBar(
              title: Text(sport.title),
            ),
            body: snapshot.hasData
                ? ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) => ListTile(
                          title: Text('${snapshot.data[index].title}'),
                          onTap: () => Navigator.push(
                              context, MaterialPageRoute(builder: (context) => Game(game: snapshot.data[index]))),
                        ))
                : Center(child: CircularProgressIndicator())));
  }
}
