import 'package:rxdart/rxdart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'bloc.dart';
import '../models/sports_model.dart';

class SportsBloc implements Bloc {
  final _sportsController = BehaviorSubject<List<SportsModel>>();
  List<SportsModel> _sports;

  Stream<List<SportsModel>> get stream => _sportsController.stream;

  SportsBloc() {
    Firestore.instance
        .collection('sports')
        .getDocuments()
        .then((snapshot) => snapshot.documents)
        .then((documents) => documents.map((document) => SportsModel.fromJson(document.data)))
        .then((records) => records.toList())
        .asStream()
        .listen((records) {
          _sports = records;
          _sportsController.add(_sports);
        });
  }

  @override
  void dispose() {
    _sportsController.close();
  }
}