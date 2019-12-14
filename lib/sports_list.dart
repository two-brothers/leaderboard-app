import 'package:flutter/material.dart';

import 'bloc/bloc_provider.dart';
import 'bloc/sports_bloc.dart';

class SportsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final SportsBloc bloc = BlocProvider.of<SportsBloc>(context);

    return StreamBuilder<Sports>(
        stream: bloc.stream,
        builder: (context, snapshot) => Scaffold(
            appBar: AppBar(
              title: Text("Sports"),
            ),
            body: snapshot.hasData
                ? ListView.builder(
                    itemCount: snapshot.data.names.length,
                    itemBuilder: (context, index) => ListTile(
                          title: Text('${snapshot.data.names[index]}'),
                        ))
                : Center(child: CircularProgressIndicator())));
  }
}
