import 'package:flutter/material.dart';

import 'bloc/bloc_provider.dart';
import 'bloc/player_bloc.dart';

class NewPlayer extends StatefulWidget {
  @override
  _NewPlayerState createState() => _NewPlayerState();
}

class _NewPlayerState extends State<NewPlayer> {
  final _formKey = GlobalKey<FormState>();

  String name = '';
  bool saving = false;

  @override
  Widget build(BuildContext context) {
    final PlayerBloc bloc = BlocProvider.of<PlayerBloc>(context);

    return Scaffold(
        appBar: AppBar(title: Text('Create New Player')),
        body: Builder( // use a builder so Scaffold.of will refer to this Scaffold
          builder: (BuildContext context) => Container(
              padding: EdgeInsets.all(16),
              child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextFormField(
                          decoration: InputDecoration(hintText: 'Player Name'),
                          validator: (value) => value.isEmpty ? 'Enter player name' : null,
                          onSaved: (value) => setState(() => name = value)),
                      Center(
                          child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: RaisedButton(
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    _formKey.currentState.save();
                                    setState(() => saving = true);
                                    bloc.addPlayer(name).then((_) {
                                      setState(() => saving = false);
                                      Scaffold.of(context).showSnackBar(SnackBar(content: Text('Added $name')));
                                      _formKey.currentState.reset();
                                    });
                                  }
                                },
                                child: Text('CREATE', style: Theme.of(context).textTheme.button),
                                color: Theme.of(context).primaryColor,
                              ))),
                      saving ? Expanded(child: Center(child: CircularProgressIndicator())) : SizedBox.shrink()
                    ],
                  ))),
        ));
  }
}
