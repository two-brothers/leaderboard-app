import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class Record {
  final DateTime dt;
  final DocumentReference playerRef;

  Record({@required this.dt, @required this.playerRef});

  String additionalInfo();
}

class ScoredRecord extends Record {
  final int score;

  ScoredRecord({@required this.score, @required DateTime dt, @required DocumentReference playerRef}) : super(dt: dt, playerRef: playerRef);

  factory ScoredRecord.fromMap(Map parsedJson) {
    return ScoredRecord(dt: (parsedJson['date'] as Timestamp).toDate(), playerRef: parsedJson['player'], score: parsedJson['score']);
  }

  @override
  additionalInfo() {
    return '$score shots';
  }
}

class RankedRecord extends Record {
  RankedRecord({@required dt, @required playerRef}) : super(dt: dt, playerRef: playerRef);

  factory RankedRecord.fromMap(Map parsedJson) {
    return RankedRecord(dt: (parsedJson['date'] as Timestamp).toDate(), playerRef: parsedJson['player']);
  }

  @override
  additionalInfo() {
    return '';
  }
}
