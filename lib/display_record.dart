import 'package:flutter/material.dart';

import 'models/player_model.dart';
import 'models/record_model.dart';
import 'player_avatar.dart';

class DisplayRecord extends StatelessWidget {
  final int rank;
  final PlayerModel player;
  final Record record;

  DisplayRecord({@required this.rank, @required this.player, @required this.record});

  @override
  Widget build(BuildContext context) {
    return rank == 1 ? leaderRecord() : challengerRecord();
  }

  Widget leaderRecord() {
    return Card(
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(children: <Widget>[
              PlayerAvatar(player: player, radius: 50),
              Column(children: [
                Text(player.name, style: TextStyle(fontSize: 40)),
                Text(record.additionalInfo(), style: TextStyle(fontSize: 18, color: Colors.black54))
              ])
            ], mainAxisAlignment: MainAxisAlignment.spaceAround)));
  }

  Widget challengerRecord() {
    return ListTile(
        leading: Text('$rank.'),
        title: Row(children: <Widget>[PlayerAvatar(player: player), Text(player.name)]),
        trailing: Text(record.additionalInfo()));
  }
}
