import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/sports_model.dart';
import '../models/game_model.dart';
import 'bloc.dart';

class GameBloc implements Bloc {
  final Map<SportsModel, Stream<List<GameModel>>> _gamesBySport;

  GameBloc() : _gamesBySport = {};

  Stream<List<GameModel>> getGamesIn(SportsModel sport) {
    return _gamesBySport[sport] ??
        Firestore.instance
            .collection('games')
            .where('sport', isEqualTo: '/sports/${sport.id}')
            .snapshots()
            .map((snapshot) => snapshot.documents)
            .map((documents) => documents.map((document) => GameModel.fromJson(document.data)))
            .map((records) => records.toList());
  }

  @override
  void dispose() {}
}
