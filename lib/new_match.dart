import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

import 'models/game_model.dart';
import 'models/player_model.dart';
import 'player_selector_formfield.dart';

class NewMatch extends StatefulWidget {
  final GameModel game;
  final _format = DateFormat("d MMM yyyy");
  final _formKey = GlobalKey<FormState>();

  NewMatch({@required this.game});

  @override
  _NewMatchState createState() => _NewMatchState();
}

class _NewMatchState extends State<NewMatch> {
  DateTime _dt = DateTime.now();
  PlayerModel _player;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Record Match')),
        body: Container(
            padding: EdgeInsets.all(16),
            child: Form(
                key: this.widget._formKey,
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(this.widget.game.title, style: Theme.of(context).textTheme.title),
                  ),
                  DateTimeField(
                    format: this.widget._format,
                    initialValue: _dt,
                    decoration: InputDecoration(hintText: 'Date of match'),
                    validator: (value) => value == null ? 'Enter date of match' : null,
                    onShowPicker: (context, currentValue) => showDatePicker(
                        context: context,
                        firstDate: DateTime(1900),
                        initialDate: currentValue ?? DateTime.now(),
                        lastDate: DateTime(2100)),
                    onSaved: (value) => setState(() => _dt = value),
                  ),
                  PlayerSelectorFormField(
                      decoration: InputDecoration(hintText: 'Player name'),
                      validator: (value) => value == null ? 'Choose player' : null,
                      onSaved: (value) => setState(() => _player = value))
                ]))));
  }
}
