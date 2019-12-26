import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

import '../models/sports_model.dart';
import '../models/game_model.dart';
import 'bloc.dart';

class GameBloc implements Bloc {
  final Map<SportsModel, BehaviorSubject<List<GameModel>>> _gamesBySport;
  final Map<String, BehaviorSubject<GameModel>> _gamesById;

  GameBloc()
      : _gamesBySport = {},
        _gamesById = {};

  // Return a stream of games that match the specified sport.
  // The game references are expanded so the titles can be displayed
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

  // Return a stream of the specified game
  // This stream will usually be contained within the getGamesIn stream for the relevant sport
  // but we require a separate stream to track when the leaderboard changes
  Stream<GameModel> getGame(String id) {
    if (_gamesById[id] == null) {
      _gamesById[id] = BehaviorSubject<GameModel>();
      Firestore.instance
          .collection('games')
          .document(id)
          .snapshots()
          .map((document) => GameModel.fromJson(document.documentID, document.data))
          .listen((game) => _gamesById[id].add(game));
    }
    return _gamesById[id];
  }

  @override
  void dispose() {
    _gamesBySport.forEach((_, subject) => subject.close());
  }
}
