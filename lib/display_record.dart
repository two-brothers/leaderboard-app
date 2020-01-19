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
    return ListTile(
        leading: Text('$rank.', style: TextStyle(color: Colors.black45)),
        title: Row(children: <Widget>[
          PlayerAvatar(player: player),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: Text(player.name))
        ]),
        trailing: Text(record.additionalInfo(), style: TextStyle(color: Colors.black54)));
  }
}
