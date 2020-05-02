import 'dart:io';

import 'package:flutter/material.dart';

import '../players/player_fields.dart';
import '../bloc/player_bloc.dart';

class EditPlayer extends PlayerFields {
  EditPlayer({@required player}) : super(original: player);

  @override
  _EditPlayerState createState() => _EditPlayerState(original.name);
}

class _EditPlayerState extends PlayerFieldsState {
  _EditPlayerState(String name) : super(name);

  @override
  String title() => 'Edit Player';

  @override
  String submitText() => 'SAVE';

  @override
  String onCompleteText() => 'Updated player';

  @override
  Future onSubmit(PlayerBloc _bloc, String _name, File _avatar) =>
      _bloc.editPlayer(id: this.widget.original.id, name: _name, avatar: _avatar);
}
