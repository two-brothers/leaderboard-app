import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import 'bloc.dart';

class SportsBloc implements Bloc {
  final _sportsController = BehaviorSubject<Sports>();
  Sports _sports;

  Stream<Sports> get stream => _sportsController.stream;

  SportsBloc() {
    _sports = Sports(names: ['basketball', 'pool']);
    _sportsController.add(_sports);
  }

  @override
  void dispose() {
    _sportsController.close();
  }
}

class Sports {
  final List<String> names;

  Sports({@required this.names});
}