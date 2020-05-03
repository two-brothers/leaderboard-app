import 'dart:io';

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

  Future<void> addPlayer({@required String name, File avatar}) =>
      // we need to create a document first so we can name the avatar based on the document ID
      Firestore.instance.collection('players').add({'name': name})
      .then((doc) => editPlayer(id: doc.documentID, name: name, avatar: avatar));

  Future<void> editPlayer({@required String id, @required String name, File avatar}) => _uploadAvatar(id, avatar).then((update) {
        update.addAll({'name': name});
        return update;
      }).then((data) => Firestore.instance.document('players/$id').setData(data, merge: true));

  Future<Map<String, String>> _uploadAvatar(String id, File avatar) => avatar == null
      ? Future.value({})
      : FirebaseStorage.instance
          .ref()
          .child('avatar-$id')
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
