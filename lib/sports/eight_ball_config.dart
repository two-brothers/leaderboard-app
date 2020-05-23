import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:leaderboard_app/bloc/bloc_provider.dart';
import 'package:leaderboard_app/bloc/player_bloc.dart';
import 'package:leaderboard_app/models/player_model.dart';

import 'eight_ball.dart';

class EightBallConfig extends StatefulWidget {
  @override
  _EightBallConfigState createState() => _EightBallConfigState();
}

class _EightBallConfigState extends State<EightBallConfig> {
  List<PlayerModel> players = [];

  @override
  Widget build(BuildContext context) {
    final PlayerBloc _bloc = BlocProvider.of<PlayerBloc>(context);

    return Scaffold(
        appBar: AppBar(title: Text("Eight Ball Configuration")),
        body: SingleChildScrollView(
            child: StreamBuilder<List<PlayerModel>>(
                stream: _bloc.players,
                builder: (context, snapshot) => Column(
                      children: <Widget>[
                        AutoCompleteTextField<PlayerModel>(
                          // the AutoCompleteTextField suggestions are set during initialization
                          // I do not know how to call the update function when the stream changes
                          // instead, use a new key on every rebuild to reload the whole widget
                          key: GlobalKey<AutoCompleteTextFieldState<PlayerModel>>(),
                          itemBuilder: (context, player) => ListTile(title: Text(player.name)),
                          itemFilter: (player, input) => player.name.toLowerCase().startsWith(input.toLowerCase()),
                          suggestions: snapshot.hasData
                              ? snapshot.data.where((player) => !players.contains(player)).toList()
                              : [],
                          itemSorter: (playerA, playerB) => playerA.name.compareTo(playerB.name),
                          itemSubmitted: (player) => setState(() => players.add(player)),
                        ),
                        ...players.map((player) => Text(player.name)),
                        RaisedButton(
                          child: Text("Start"),
                          onPressed: () => Navigator.push(
                              context, MaterialPageRoute(builder: (context) => EightBall(players: players))),
                        )
                      ],
                    ))));
  }
}
