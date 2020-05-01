import 'package:flutter/material.dart';

import '../bloc/bloc_provider.dart';
import '../bloc/player_bloc.dart';
import '../models/player_model.dart';
import '../common/stream_widget.dart';

class PlayersList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final PlayerBloc _bloc = BlocProvider.of<PlayerBloc>(context);

    return StreamWidget<List<PlayerModel>>(
        stream: _bloc.players,
        builder: (context, players) => Scaffold(
            appBar: AppBar(title: Text("Players")),
            body: ListView.builder(
                itemCount: players.length,
                itemBuilder: (context, index) => ListTile(title: Text('${players[index].name}'), onTap: () => null))),
        placeholder: Center(child: CircularProgressIndicator()));
  }
}
