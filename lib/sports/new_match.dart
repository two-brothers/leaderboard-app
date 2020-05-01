import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

import '../bloc/bloc_provider.dart';
import '../bloc/match_bloc.dart';
import '../common/form_submission_button.dart';
import '../models/game_model.dart';
import '../models/player_model.dart';
import '../players/player_selector_formfield.dart';

class NewMatch extends StatefulWidget {
  final GameModel game;
  final _format = DateFormat("d MMM yyyy");
  final _formKey = GlobalKey<FormState>();

  NewMatch({@required this.game});

  @override
  _NewMatchState createState() {
    switch (game.gameType) {
      case GameType.HIGH_SCORE: // intentional fall-through
      case GameType.LOW_SCORE:
        return _NewPersonalScoreState();
      case GameType.RANKING:
        return _RankScoreState();
      default:
        return null;
    }
  }
}

abstract class _NewMatchState extends State<NewMatch> {
  DateTime _dt = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Record Match')),
        body: Builder(
            builder: (BuildContext context) => SingleChildScrollView(
                child: Container(
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
                              readOnly: true),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: formElements(context),
                          ),
                          FormSubmissionButton(
                              formKey: this.widget._formKey,
                              onSubmit: () => save(context),
                              buttonText: 'RECORD',
                              onCompleteText: 'Saved Record')
                        ]))))));
  }

  List<Widget> formElements(BuildContext context);

  Future save(BuildContext context);
}

class _NewPersonalScoreState extends _NewMatchState {
  PlayerModel _player;
  int _score;

  @override
  List<Widget> formElements(BuildContext context) => [
        PlayerSelectorFormField(
            hintText: 'Player',
            validator: (value) => value == null ? 'Choose player' : null,
            onSaved: (value) => setState(() => _player = value)),
        TextFormField(
            decoration: InputDecoration(hintText: 'Score'),
            inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.number,
            validator: (value) => value == '' || int.parse(value) == 0 ? 'Score must be a positive integer' : null,
            onSaved: (value) => setState(() => _score = int.parse(value)))
      ];

  @override
  Future save(BuildContext context) {
    final MatchBloc _bloc = BlocProvider.of<MatchBloc>(context);
    return _bloc.addPersonalScore(dt: _dt, game: this.widget.game, player: _player, score: _score);
  }
}

class _RankScoreState extends _NewMatchState {
  PlayerModel _winner;
  PlayerModel _loser;

  @override
  List<Widget> formElements(BuildContext context) => [
        PlayerSelectorFormField(
            hintText: 'Winner',
            validator: (value) => value == null ? 'Choose winner' : null,
            onSaved: (value) => setState(() => _winner = value)),
        PlayerSelectorFormField(
            hintText: 'Loser',
            validator: (value) => value == null ? 'Choose loser' : null,
            onSaved: (value) => setState(() => _loser = value))
      ];

  @override
  Future save(BuildContext context) {
    final MatchBloc _bloc = BlocProvider.of<MatchBloc>(context);
    return _bloc.addRankedMatch(dt: _dt, game: this.widget.game, winner: _winner, loser: _loser);
  }
}
