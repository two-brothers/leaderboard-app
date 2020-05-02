import 'package:flutter/material.dart';

import '../players/player_avatar.dart';
import '../bloc/bloc_provider.dart';
import '../bloc/player_bloc.dart';
import '../models/player_model.dart';
import '../common/stream_widget.dart';
import 'edit_player.dart';
import 'new_player.dart';

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
                itemBuilder: (context, index) => ListTile(
                    leading: PlayerAvatar(player: players[index]),
                    title: Text(players[index].name),
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => EditPlayer(player: players[index]))))),
            floatingActionButton: FloatingActionButton(
                child: Icon(Icons.add), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => NewPlayer())))));
  }
}
