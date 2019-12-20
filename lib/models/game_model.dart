import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

import 'record_model.dart';

class GameModel extends Equatable {
  final String id;
  final String title;
  final String sportId;
  final GameType gameType;
  final String summary;
  final List<Record> leaderboard;

  GameModel(
      {@required this.id,
      @required this.title,
      @required this.sportId,
      @required this.gameType,
      @required this.summary,
      @required this.leaderboard});

  factory GameModel.fromJson(String id, Map<String, dynamic> parsedJson) {
    GameType gameType = GameType.values[parsedJson['gameType']];
    List<Record> leaderboard = (parsedJson['leaderboard'] as List).map((record) {
      switch (gameType) {
        case GameType.RANKING:
          return null;
        case GameType.HIGH_SCORE: // intentional fall-through
        case GameType.LOW_SCORE:
          return ScoredRecord.fromMap(record);
        default:
          return null;
      }
    }).toList();

    return GameModel(
        id: id,
        title: parsedJson['title'],
        sportId: parsedJson['sportId'],
        gameType: GameType.values[parsedJson['gameType']],
        summary: parsedJson['summary'],
        leaderboard: leaderboard);
  }

  // Two objects with the same id will be assumed to be identical
  @override
  List<Object> get props => [id];
}

enum GameType {
  RANKING, // position is defined relative to other players
  HIGH_SCORE,
  LOW_SCORE
}
