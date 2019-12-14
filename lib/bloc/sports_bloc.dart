import 'package:cloud_firestore/cloud_firestore.dart';

import 'bloc.dart';
import '../models/sports_model.dart';

class SportsBloc implements Bloc {
  final Stream<List<SportsModel>> _content$;

  SportsBloc() : _content$ = _initContent$;

  Stream<List<SportsModel>> get stream => _content$;

  static Stream<List<SportsModel>> get _initContent$ =>
      Firestore.instance
          .collection('sports')
          .snapshots()
          .map((snapshot) => snapshot.documents)
          .map((documents) => documents.map((document) => SportsModel.fromJson(document.data)))
          .map((records) => records.toList());

  @override
  void dispose() {}
}