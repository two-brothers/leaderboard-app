import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';

import '../bloc/bloc_provider.dart';
import '../bloc/player_bloc.dart';
import '../models/player_model.dart';
import '../players/new_player.dart';

class PlayerSelectorFormField extends FormField<PlayerModel> {
  PlayerSelectorFormField(
      {FormFieldSetter<PlayerModel> onSaved,
      FormFieldValidator<PlayerModel> validator,
      PlayerModel initialValue,
      bool autovalidate = false,
      String hintText})
      : super(
            onSaved: onSaved,
            validator: validator,
            initialValue: initialValue,
            autovalidate: autovalidate,
            builder: (FormFieldState<PlayerModel> state) {
              final PlayerBloc _bloc = BlocProvider.of<PlayerBloc>(state.context);
              String name = initialValue == null ? '' : initialValue.name;

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
                                  decoration: InputDecoration(
                                      hintText: hintText,
                                      suffix: IconButton(
                                          icon: Icon(Icons.add),
                                          onPressed: () => Navigator.push(
                                                context,
                                                MaterialPageRoute(builder: (context) => NewPlayer(initialValue: name)),
                                              ))),
                                  itemBuilder: (context, player) => ListTile(title: Text(player.name)),
                                  itemFilter: (player, input) =>
                                      player.name.toLowerCase().startsWith(input.toLowerCase()),
                                  itemSorter: (playerA, playerB) => playerA.name.compareTo(playerB.name),
                                  itemSubmitted: (submitted) => state.didChange(submitted),
                                  suggestions: snapshot.hasData ? snapshot.data : [],
                                  textChanged: (String s) => name = s,
                                )),
                        ConditionalBuilder(
                            condition: state.value != null,
                            builder: (context) => TextFormField(
//                                textAlignVertical: TextAlignVertical.center,
                                initialValue: state.value.name,
                                readOnly: true,
                                decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.person),
                                    suffix:
                                        IconButton(icon: Icon(Icons.clear), onPressed: () => state.didChange(null))))),
                        ConditionalBuilder(
                            condition: state.hasError,
                            builder: (context) => Text(state.errorText, style: TextStyle(color: Colors.red)))
                      ]));
            });
}
