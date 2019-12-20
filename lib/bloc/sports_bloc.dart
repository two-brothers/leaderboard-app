import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

import 'bloc.dart';
import '../models/sports_model.dart';

class SportsBloc implements Bloc {
  final _sportsController = BehaviorSubject<List<SportsModel>>();

  Stream<List<SportsModel>> get stream => _sportsController.stream;

  SportsBloc() {
    Firestore.instance
        .collection('sports')
        .snapshots()
        .map((snapshot) => snapshot.documents)
        .map((documents) => documents.map((document) => SportsModel.fromJson(document.documentID, document.data)))
        .map((records) => records.toList())
        .listen((sports) => _sportsController.add(sports));
  }

  @override
  void dispose() {
    _sportsController.close();
  }
}
