import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class NewMatch extends StatefulWidget {
  @override
  _NewMatchState createState() => _NewMatchState();
}

class _NewMatchState extends State<NewMatch> {
  final _formKey = GlobalKey<FormState>();
  final format = DateFormat("d MMM yyyy");

  DateTime dt = DateTime.now();
  bool saving = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Record Match')),
        body: Builder(
          // use a builder so Scaffold.of will refer to this Scaffold
          builder: (BuildContext context) => Container(
              padding: EdgeInsets.all(16),
              child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      DateTimeField(
                        format: format,
                        initialValue: dt,
                        decoration: InputDecoration(hintText: 'Date of match'),
                        onShowPicker: (context, currentValue) => showDatePicker(
                            context: context,
                            firstDate: DateTime(1900),
                            initialDate: currentValue ?? DateTime.now(),
                            lastDate: DateTime(2100)),
                        onSaved: (value) => setState(() => dt = value),
                      ),
                      saving ? Expanded(child: Center(child: CircularProgressIndicator())) : SizedBox.shrink()
                    ],
                  ))),
        ));
  }
}
