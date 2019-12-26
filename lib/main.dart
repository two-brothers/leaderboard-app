import 'package:flutter/material.dart';

import 'bloc/bloc_provider.dart';
import 'bloc/game_bloc.dart';
import 'bloc/match_bloc.dart';
import 'bloc/player_bloc.dart';
import 'bloc/sports_bloc.dart';
import 'sports_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _provideBlocs(MaterialApp(
      title: 'Leaderboard',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: TextTheme(
            button: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white),
          )),
      home: SportsList(),
    ));
  }

  Widget _provideBlocs(Widget child) {
    return BlocProvider<SportsBloc>(
        bloc: SportsBloc(),
        child: BlocProvider<GameBloc>(
            bloc: GameBloc(),
            child: BlocProvider<PlayerBloc>(
                bloc: PlayerBloc(), child: BlocProvider<MatchBloc>(bloc: MatchBloc(), child: child))));
  }
}
