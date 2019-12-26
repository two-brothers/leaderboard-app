import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';

import 'bloc/bloc_provider.dart';
import 'bloc/player_bloc.dart';

class NewPlayer extends StatefulWidget {
  @override
  _NewPlayerState createState() => _NewPlayerState();
}

class _NewPlayerState extends State<NewPlayer> {
  final _formKey = GlobalKey<FormState>();

  String _name = '';
  bool _saving = false;

  @override
  Widget build(BuildContext context) {
    final PlayerBloc _bloc = BlocProvider.of<PlayerBloc>(context);

    return Scaffold(
        appBar: AppBar(title: Text('Create New Player')),
        body: Builder(
          // use a builder so Scaffold.of will refer to this Scaffold
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
                          onSaved: (value) => setState(() => _name = value)),
                      Center(
                          child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: RaisedButton(
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    _formKey.currentState.save();
                                    setState(() => _saving = true);
                                    _bloc.addPlayer(_name).then((_) {
                                      setState(() => _saving = false);
                                      Scaffold.of(context).showSnackBar(SnackBar(content: Text('Added $_name')));
                                      _formKey.currentState.reset();
                                    });
                                  }
                                },
                                child: Text('CREATE', style: Theme.of(context).textTheme.button),
                                color: Theme.of(context).primaryColor,
                              ))),
                      ConditionalBuilder(
                        condition: _saving,
                        builder: (context) => Expanded(child: Center(child: CircularProgressIndicator())),
                      )
                    ],
                  ))),
        ));
  }
}
