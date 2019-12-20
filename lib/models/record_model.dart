import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Record {
  final DateTime dt;
  final DocumentReference playerRef;

  Record({@required this.dt, @required this.playerRef});
}

class ScoredRecord extends Record {
  final int score;

  ScoredRecord({@required this.score, @required DateTime dt, @required DocumentReference playerRef})
      : super(dt: dt, playerRef: playerRef);

  factory ScoredRecord.fromMap(Map parsedJson) {
    return ScoredRecord(
        dt: (parsedJson['date'] as Timestamp).toDate(), playerRef: parsedJson['player'], score: parsedJson['score']);
  }
}
