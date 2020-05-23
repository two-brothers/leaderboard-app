import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Score {
  final DocumentReference playerRef;
  final int score;

  Score({@required this.playerRef, @required this.score});
}