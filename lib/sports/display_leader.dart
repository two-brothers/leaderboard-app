import 'package:flutter/material.dart';

import '../models/player_model.dart';
import '../models/record_model.dart';
import '../players/player_avatar.dart';

class DisplayLeader extends StatelessWidget {
  final PlayerModel player;
  final Record record;
  final int winningStreak;

  DisplayLeader({@required this.player, @required this.record, this.winningStreak});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(children: <Widget>[
              PlayerAvatar(player: player, radius: 50),
              Column(children: <Widget>[
                Text(player.name, style: TextStyle(fontSize: 40)),
                if (record.additionalInfo() != '') Text(record.additionalInfo(), style: TextStyle(fontSize: 18, color: Colors.black54)),
                if (winningStreak != null && winningStreak > 1)
                  Text('x $winningStreak', style: TextStyle(fontSize: 18, color: Colors.black54))
              ])
            ], mainAxisAlignment: MainAxisAlignment.spaceAround)));
  }
}
