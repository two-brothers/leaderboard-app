import 'package:flutter/material.dart';

/// This button can be used to handle common submission steps:
/// * validate the form state
/// * save the form state
/// * perform the relevant action
/// * replace the button with a progress indicator while waiting for the action to complete
/// * launch a snackbar indicating success or failure on completion
/// * reset the form on successful submission
class FormSubmissionButton extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final Future Function() onSubmit;
  final String onCompleteText;
  final String buttonText;

  FormSubmissionButton({@required this.formKey, @required this.onSubmit, @required this.onCompleteText, @required this.buttonText});

  @override
  _FormSubmissionButtonState createState() => _FormSubmissionButtonState();
}

class _FormSubmissionButtonState extends State<FormSubmissionButton> {
  bool _saving = false;

  @override
  Widget build(BuildContext context) => Center(
      child: Container(
          margin: EdgeInsets.symmetric(vertical: 32),
          child: _saving
              ? CircularProgressIndicator()
              : RaisedButton(
                  onPressed: () {
                    if (this.widget.formKey.currentState.validate()) {
                      this.widget.formKey.currentState.save();
                      setState(() => _saving = true);
                      this
                          .widget
                          .onSubmit()
                          .whenComplete(() => setState(() => _saving = false))
                          .whenComplete(() => this.widget.formKey.currentState.reset())
                          .then((_) => Scaffold.of(context)
                              .showSnackBar(SnackBar(content: Text(this.widget.onCompleteText), backgroundColor: Colors.green)))
                          .catchError((error) =>
                              Scaffold.of(context).showSnackBar(SnackBar(content: Text(error.toString()), backgroundColor: Colors.red)));
                    }
                  },
                  child: Text(this.widget.buttonText, style: Theme.of(context).textTheme.button),
                  color: Theme.of(context).primaryColor,
                )));
}
