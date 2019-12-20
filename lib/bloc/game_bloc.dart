import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

import '../models/sports_model.dart';
import '../models/game_model.dart';
import 'bloc.dart';

class GameBloc implements Bloc {
  final Map<SportsModel, BehaviorSubject<List<GameModel>>> _gamesBySport;

  GameBloc() : _gamesBySport = {};

  Stream<List<GameModel>> getGamesIn(SportsModel sport) {
    if (_gamesBySport[sport] == null) {
      _gamesBySport[sport] = BehaviorSubject<List<GameModel>>();
      Firestore.instance
          .collection('games')
          .where('sportId', isEqualTo: sport.id)
          .snapshots()
          .map((snapshot) => snapshot.documents)
          .map((documents) => documents.map((document) => GameModel.fromJson(document.documentID, document.data)))
          .map((records) => records.toList())
          .listen((games) => _gamesBySport[sport].add(games));
    }
    return _gamesBySport[sport];
  }

  @override
  void dispose() {
    _gamesBySport.forEach((_, subject) => subject.close());
  }
}
