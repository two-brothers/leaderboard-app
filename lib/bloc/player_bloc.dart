import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../models/player_model.dart';
import 'bloc.dart';

class PlayerBloc implements Bloc {
  final Map<DocumentReference, BehaviorSubject<PlayerModel>> _players;
  BehaviorSubject<List<PlayerModel>> _playersController;

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

  Future<DocumentReference> addPlayer({@required String name, File avatar}) => _uploadAvatar(avatar).then((data) {
        data.addAll({'name': name});
        return data;
      }).then((data) => Firestore.instance.collection('players').add(data));

  Future<void> editPlayer({@required String id, @required String name, File avatar}) => _uploadAvatar(avatar).then((update) {
        update.addAll({'name': name});
        return update;
      }).then((data) => Firestore.instance.document('players/$id').setData(data, merge: true));

  Future<Map<String, String>> _uploadAvatar(File avatar) => avatar == null
      ? Future.value({})
      : FirebaseStorage.instance
          .ref()
          .child('${Random().nextInt(10e6.toInt())}${Random().nextInt(10e6.toInt())}')
          .putFile(avatar)
          .onComplete
          .then((snap) => snap.ref.getDownloadURL())
          .then((url) => {'avatarUrl': url});

  Stream<List<PlayerModel>> get players {
    if (_playersController == null) {
      _playersController = BehaviorSubject<List<PlayerModel>>();
      Firestore.instance
          .collection('players')
          .snapshots()
          .map((snapshot) => snapshot.documents)
          .map((documents) => documents.map((document) => PlayerModel.fromJson(document.documentID, document.data)))
          .map((records) => records.toList())
          .listen((players) => _playersController.add(players));
    }
    return _playersController.stream;
  }

  @override
  void dispose() {
    _players.forEach((_, subject) => subject.close());
    if (_playersController != null) {
      _playersController.close();
    }
  }
}
