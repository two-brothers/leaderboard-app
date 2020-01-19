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
        leading: Text('$rank.'),
        title: Row(children: <Widget>[PlayerAvatar(player: player), Text(player.name)]),
        trailing: Text(record.additionalInfo()));
  }
}
