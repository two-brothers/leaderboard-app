import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/game_model.dart';
import '../models/player_model.dart';
import 'bloc.dart';

class MatchBloc implements Bloc {
  Future<DocumentReference> addPersonalScore(
          {@required DateTime dt, @required GameModel game, @required PlayerModel player, @required int score}) =>
      Firestore.instance.collection('matches').add({
        'date': dt,
        'game': Firestore.instance.collection('games').document(game.id),
        'result': {'player': Firestore.instance.collection('players').document(player.id), 'score': score}
      });

  @override
  void dispose() {}
}
