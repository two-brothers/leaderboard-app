import 'package:flutter/material.dart';

import 'bloc/bloc_provider.dart';
import 'bloc/player_bloc.dart';
import 'form_submission_button.dart';

class NewPlayer extends StatefulWidget {
  final String initialValue;

  NewPlayer({this.initialValue});

  @override
  _NewPlayerState createState() => _NewPlayerState();
}

class _NewPlayerState extends State<NewPlayer> {
  final _formKey = GlobalKey<FormState>();
  String _name;

  @override
  Widget build(BuildContext context) {
    final PlayerBloc _bloc = BlocProvider.of<PlayerBloc>(context);

    return Scaffold(
        appBar: AppBar(title: Text('Create New Player')),
        body: Builder(
          // use a builder so Scaffold.of will refer to this Scaffold
          builder: (BuildContext context) => SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.all(16),
                child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TextFormField(
                            initialValue: this.widget.initialValue,
                            decoration: InputDecoration(hintText: 'Player Name'),
                            validator: (value) => value.isEmpty ? 'Enter player name' : null,
                            onSaved: (value) => setState(() => _name = value)),
                        FormSubmissionButton(
                          formKey: _formKey,
                          onSubmit: () => _bloc.addPlayer(_name),
                          buttonText: 'CREATE',
                          onCompleteText: 'Added $_name',
                        )
                      ],
                    ))),
          ),
        ));
  }
}
