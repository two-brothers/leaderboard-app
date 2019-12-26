import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';

import 'bloc/bloc_provider.dart';
import 'bloc/player_bloc.dart';
import 'models/player_model.dart';

class PlayerSelectorFormField extends FormField<PlayerModel> {
  PlayerSelectorFormField(
      {FormFieldSetter<PlayerModel> onSaved,
      FormFieldValidator<PlayerModel> validator,
      PlayerModel initialValue,
      bool autovalidate = false,
      InputDecoration decoration})
      : super(
            onSaved: onSaved,
            validator: validator,
            initialValue: initialValue,
            autovalidate: autovalidate,
            builder: (FormFieldState<PlayerModel> state) {
              final PlayerBloc _bloc = BlocProvider.of<PlayerBloc>(state.context);

              return StreamBuilder<List<PlayerModel>>(
                  stream: _bloc.players,
                  builder: (context, snapshot) => Column(children: <Widget>[
                        ConditionalBuilder(
                            condition: state.value == null,
                            builder: (context) => AutoCompleteTextField<PlayerModel>(
                                // the AutoCompleteTextField suggestions are set during initialization
                                // I do not know how to call the update function when the stream changes
                                // instead, use a new key on every rebuild to reload the whole widget
                                key: GlobalKey<AutoCompleteTextFieldState<PlayerModel>>(),
                                decoration: decoration,
                                itemBuilder: (context, player) => ListTile(title: Text(player.name)),
                                itemFilter: (player, input) =>
                                    player.name.toLowerCase().startsWith(input.toLowerCase()),
                                itemSorter: (playerA, playerB) => playerA.name.compareTo(playerB.name),
                                itemSubmitted: (submitted) => state.didChange(submitted),
                                suggestions: snapshot.hasData ? snapshot.data : [])),
                        ConditionalBuilder(
                            condition: state.value != null,
                            builder: (context) => Padding(
                                padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                                child: Row(children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
                                    child: Icon(Icons.person),
                                  ),
                                  Text(state.value.name),
                                  Expanded(
                                      child: Align(
                                          alignment: Alignment.centerRight,
                                          child: IconButton(
                                              icon: Icon(Icons.edit), onPressed: () => state.didChange(null))))
                                ]))),
                        ConditionalBuilder(
                            condition: state.hasError,
                            builder: (context) => Text(state.errorText, style: TextStyle(color: Colors.red)))
                      ]));
            });
}
