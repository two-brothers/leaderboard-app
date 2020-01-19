import 'package:flutter/material.dart';

import 'models/player_model.dart';

class PlayerAvatar extends CircleAvatar {
  final PlayerModel player;

  PlayerAvatar({@required this.player, double radius})
      : super(
            backgroundImage: player.avatarUrl == null ? null : NetworkImage(player.avatarUrl),
            child: player.avatarUrl == null ? Text(player.name.substring(0, 1)) : null,
            radius: radius);
}
