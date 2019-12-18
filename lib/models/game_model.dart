import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

class GameModel extends Equatable {
  final String id;
  final String title;
  final String sportId;
  final GameType gameType;
  final String summary;

  GameModel(
      {@required this.id,
      @required this.title,
      @required this.sportId,
      @required this.gameType,
      @required this.summary});

  factory GameModel.fromJson(Map<String, dynamic> parsedJson) {
    return GameModel(
        id: parsedJson['id'],
        title: parsedJson['title'],
        sportId: parsedJson['sportId'],
        gameType: parsedJson['gameType'],
        summary: parsedJson['summary']);
  }

  // Two SportsModel objects with the same id will be assumed to be identical
  @override
  List<Object> get props => [id];
}

enum GameType {
  RANKING, // position is defined relative to other players
  HIGH_SCORE,
  LOW_SCORE
}
