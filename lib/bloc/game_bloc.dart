import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/sports_model.dart';
import '../models/game_model.dart';
import 'bloc.dart';

class GameBloc implements Bloc {
  final Map<SportsModel, Stream<List<GameModel>>> _gamesBySport;

  GameBloc() : _gamesBySport = {};

  Stream<List<GameModel>> getGamesIn(SportsModel sport) {
    if (_gamesBySport[sport] == null) {
      _gamesBySport[sport] = Firestore.instance
          .collection('games')
          .where('sportId', isEqualTo: sport.id)
          .snapshots()
          .map((snapshot) => snapshot.documents)
          .map((documents) => documents.map((document) => GameModel.fromJson(document.documentID, document.data)))
          .map((records) => records.toList());
    }
    return _gamesBySport[sport];
  }

  @override
  void dispose() {}
}
