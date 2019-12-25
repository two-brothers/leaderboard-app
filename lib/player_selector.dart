import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';

import 'bloc/bloc_provider.dart';
import 'bloc/player_bloc.dart';
import 'models/player_model.dart';

class PlayerSelector extends StatefulWidget {
  @override
  _PlayerSelectorState createState() => _PlayerSelectorState();
}

class _PlayerSelectorState extends State<PlayerSelector> {
  PlayerModel _player;

  @override
  Widget build(BuildContext context) {
    final PlayerBloc _bloc = BlocProvider.of<PlayerBloc>(context);

    return StreamBuilder<List<PlayerModel>>(
        stream: _bloc.players,
        builder: (context, snapshot) => _player == null
            ? AutoCompleteTextField<PlayerModel>(
                // the AutoCompleteTextField suggestions are set during initialization
                // I do not know how to call the update function when the stream changes
                // instead, use a new key on every rebuild to reload the whole widget
                key: GlobalKey<AutoCompleteTextFieldState<PlayerModel>>(),
                decoration: InputDecoration(hintText: 'Player name'),
                itemBuilder: (context, player) => ListTile(title: Text(player.name)),
                itemFilter: (player, input) => player.name.toLowerCase().startsWith(input.toLowerCase()),
                itemSorter: (playerA, playerB) => playerA.name.compareTo(playerB.name),
                itemSubmitted: (submitted) => setState(() => _player = submitted),
                suggestions: snapshot.hasData ? snapshot.data : [],
              )
            : Padding(
                padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                child: Row(children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
                    child: Icon(Icons.person),
                  ),
                  Text(_player.name),
                  Expanded(
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(icon: Icon(Icons.edit), onPressed: () => setState(() => _player = null))))
                ])));
  }
}
