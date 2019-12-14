import 'package:flutter/material.dart';

import 'bloc/bloc_provider.dart';
import 'bloc/sports_bloc.dart';
import 'sports_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<SportsBloc>(
      bloc: SportsBloc(),
      child: MaterialApp(
        title: 'Leaderboard',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SportsList(),
      ),
    );
  }
}