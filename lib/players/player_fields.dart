import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../common/form_submission_button.dart';
import '../players/player_avatar.dart';
import '../bloc/bloc_provider.dart';
import '../bloc/player_bloc.dart';
import '../models/player_model.dart';

/// This class contains the common functionality between the NewPlayer and EditPlayer widgets
abstract class PlayerFields extends StatefulWidget {
  final PlayerModel original;

  PlayerFields({this.original});
}

abstract class PlayerFieldsState extends State<PlayerFields> {
  final _formKey = GlobalKey<FormState>();
  String _newName = '';
  File _newAvatarFile;

  PlayerFieldsState(this._newName);

  @override
  Widget build(BuildContext context) {
    final PlayerBloc _bloc = BlocProvider.of<PlayerBloc>(context);

    return Scaffold(
        appBar: AppBar(title: Text(title())),
        body: Builder(
            builder: (BuildContext context) => SingleChildScrollView(
                child: Container(
                    padding: EdgeInsets.all(16),
                    child: Form(
                        key: _formKey,
                        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
                          PlayerAvatar(
                              player: PlayerModel(id: this.widget.original.id, name: _newName, avatarUrl: this.widget.original.avatarUrl),
                              overrideImage: _newAvatarFile,
                              radius: 50),
                          IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () async {
                                File avatar = await FilePicker.getFile(type: FileType.image);
                                setState(() => _newAvatarFile = avatar);
                              }),
                          TextFormField(
                              initialValue: _newName,
                              decoration: InputDecoration(hintText: 'Player Name'),
                              validator: (value) => value.isEmpty ? 'Enter player name' : null,
                              onSaved: (value) => setState(() => _newName = value)),
                          FormSubmissionButton(
                              formKey: _formKey,
                              onSubmit: () => onSubmit(_bloc, _newName, _newAvatarFile),
                              buttonText: submitText(),
                              onCompleteText: onCompleteText())
                        ]))))));
  }

  String title();

  String submitText();

  String onCompleteText();

  Future onSubmit(PlayerBloc _bloc, String _name, File _avatar);
}
