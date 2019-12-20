import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

import '../models/player_model.dart';
import 'bloc.dart';

class PlayerBloc implements Bloc {
  final Map<DocumentReference, BehaviorSubject<PlayerModel>> _players;

  PlayerBloc() : _players = {};

  Stream<PlayerModel> getPlayerStreamByRef(DocumentReference playerRef) {
    if (_players[playerRef] == null) {
      _players[playerRef] = BehaviorSubject<PlayerModel>();
      playerRef
          .snapshots()
          .map((document) => PlayerModel.fromJson(document.documentID, document.data))
          .listen((player) => _players[playerRef].add(player));
    }
    return _players[playerRef];
  }

  @override
  void dispose() {
    _players.forEach((_, subject) => subject.close());
  }
}
