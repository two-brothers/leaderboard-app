import 'package:flutter/material.dart';

import 'bloc/bloc_provider.dart';
import 'bloc/sports_bloc.dart';
import 'game_list.dart';
import 'models/sports_model.dart';

class SportsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final SportsBloc bloc = BlocProvider.of<SportsBloc>(context);

    return StreamBuilder<List<SportsModel>>(
        stream: bloc.stream,
        builder: (context, snapshot) => Scaffold(
            appBar: AppBar(
              title: Text("Sports"),
            ),
            body: snapshot.hasData
                ? ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) => ListTile(
                          title: Text('${snapshot.data[index].title}'),
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => GameList(sport: snapshot.data[index])),
                          ),
                        ))
                : Center(child: CircularProgressIndicator())));
  }
}
