import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';

import '../models/player_model.dart';

class PlayerAvatar extends StatelessWidget {
  final PlayerModel player;
  final double radius;
  final File overrideImage;

  PlayerAvatar({@required this.player, this.radius, this.overrideImage});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
        backgroundImage: this.overrideImage != null
            ? FileImage(this.overrideImage)
            : (player.avatarUrl == null ? null : NetworkImage(player.avatarUrl)),
        backgroundColor: pseudorandomColor(player.id),
        child: this.overrideImage == null && player.avatarUrl == null
            ? Text(player.name?.substring(0, 1) ?? '', style: TextStyle(backgroundColor: pseudorandomColor(player.id)))
            : null,
        radius: radius);
  }

  Color pseudorandomColor(String input) {
    // note: this method will have color collisions
    final Random rng = Random(input.codeUnits.reduce((a, b) => a + b));
    return Color.fromARGB(0xff, rng.nextInt(0xff), rng.nextInt(0xff), rng.nextInt(0xff));
  }
}
