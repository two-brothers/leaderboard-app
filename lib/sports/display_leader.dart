import 'package:flutter/material.dart';

import '../models/player_model.dart';
import '../models/record_model.dart';
import '../players/player_avatar.dart';

class DisplayLeader extends StatelessWidget {
  final PlayerModel player;
  final Record record;

  DisplayLeader({@required this.player, @required this.record});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(children: <Widget>[
              PlayerAvatar(player: player, radius: 50),
              Column(children: <Widget>[
                Text(player.name, style: TextStyle(fontSize: 40)),
                Text(record.additionalInfo(), style: TextStyle(fontSize: 18, color: Colors.black54))
              ])
            ], mainAxisAlignment: MainAxisAlignment.spaceAround)));
  }
}
