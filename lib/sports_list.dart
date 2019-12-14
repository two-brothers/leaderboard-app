import 'package:flutter/material.dart';

class SportsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<String> items = ['basketball', 'pool'];

    return Scaffold(
        appBar: AppBar(
          title: Text("Sports"),
        ),
        body: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) => ListTile(
                  title: Text('${items[index]}'),
                )));
  }
}
