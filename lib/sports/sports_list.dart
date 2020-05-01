import 'package:flutter/material.dart';

import '../bloc/bloc_provider.dart';
import '../bloc/sports_bloc.dart';
import '../sports/game_list.dart';
import '../models/sports_model.dart';
import '../common/stream_widget.dart';

class SportsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final SportsBloc _bloc = BlocProvider.of<SportsBloc>(context);

    return StreamWidget<List<SportsModel>>(
        stream: _bloc.stream,
        builder: (context, sports) => Scaffold(
            appBar: AppBar(title: Text("Sports")),
            body: ListView.builder(
                itemCount: sports.length,
                itemBuilder: (context, index) => ListTile(
                    title: Text('${sports[index].title}'),
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => GameList(sport: sports[index])))))),
        placeholder: Center(child: CircularProgressIndicator()));
  }
}
