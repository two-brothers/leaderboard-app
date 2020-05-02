import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../bloc/bloc_provider.dart';
import '../bloc/player_bloc.dart';
import '../models/player_model.dart';
import '../common/form_submission_button.dart';
import 'player_avatar.dart';

class EditPlayer extends StatefulWidget {
  final PlayerModel player;

  EditPlayer({@required this.player});

  @override
  _EditPlayerState createState() => _EditPlayerState(player);
}

class _EditPlayerState extends State<EditPlayer> {
  final _formKey = GlobalKey<FormState>();
  String _newName = '';
  File _newAvatarFile;

  _EditPlayerState(PlayerModel player) {
    this._newName = player.name;
  }

  @override
  Widget build(BuildContext context) {
    final PlayerBloc _bloc = BlocProvider.of<PlayerBloc>(context);

    return Scaffold(
        appBar: AppBar(title: Text('Edit Player')),
        body: Builder(
            // use a builder so Scaffold.of will refer to this Scaffold,
            // which is used in the FormSubmissionButton
            builder: (BuildContext context) => SingleChildScrollView(
                child: Container(
                    padding: EdgeInsets.all(16),
                    child: Form(
                        key: _formKey,
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                          Center(
                              child: Column(children: <Widget>[
                            PlayerAvatar(
                                player: PlayerModel(id: this.widget.player.id, name: _newName, avatarUrl: this.widget.player.avatarUrl),
                                overrideImage: _newAvatarFile,
                                radius: 50),
                            IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () async {
                                  File avatar = await FilePicker.getFile(type: FileType.image);
                                  setState(() => _newAvatarFile = avatar);
                                })
                          ])),
                          TextFormField(
                              initialValue: _newName,
                              decoration: InputDecoration(hintText: 'Player Name'),
                              validator: (value) => value.isEmpty ? 'Enter player name' : null,
                              onSaved: (value) => setState(() => _newName = value)),
                          FormSubmissionButton(
                            formKey: _formKey,
                            onSubmit: () => _bloc.editPlayer(id: this.widget.player.id, name: _newName, avatar: _newAvatarFile),
                            buttonText: 'SAVE',
                            onCompleteText: 'Updated player',
                          )
                        ]))))));
  }
}
