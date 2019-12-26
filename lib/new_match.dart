import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

import 'models/player_model.dart';
import 'player_selector_formfield.dart';

class NewMatch extends StatefulWidget {
  @override
  _NewMatchState createState() => _NewMatchState();
}

class _NewMatchState extends State<NewMatch> {
  final _formKey = GlobalKey<FormState>();
  final _format = DateFormat("d MMM yyyy");

  DateTime _dt = DateTime.now();
  PlayerModel _player;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Record Match')),
        body: Container(
            padding: EdgeInsets.all(16),
            child: Form(
                key: _formKey,
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                  DateTimeField(
                    format: _format,
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
