import 'dart:io';

import '../models/player_model.dart';
import '../players/player_fields.dart';
import '../bloc/player_bloc.dart';

class NewPlayer extends PlayerFields {
  NewPlayer({name}) : super(original: PlayerModel(name: name, id: 'X', avatarUrl: null));

  @override
  _NewPlayerState createState() => _NewPlayerState(original.name);
}

class _NewPlayerState extends PlayerFieldsState {
  _NewPlayerState(String name) : super(name);

  @override
  String title() => 'Create New Player';

  @override
  String submitText() => 'CREATE';

  @override
  String onCompleteText() => 'Added player';

  @override
  Future onSubmit(PlayerBloc _bloc, String _name, File _avatar) =>
      _bloc.addPlayer(name: _name, avatar: _avatar);
}