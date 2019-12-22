import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

class PlayerModel extends Equatable {
  final String id;
  final String name;

  PlayerModel({@required this.id, @required this.name});

  factory PlayerModel.fromJson(String id, Map<String, dynamic> parsedJson) {
    return PlayerModel(id: id, name: parsedJson['name']);
  }

  // Two objects with the same id will be assumed to be identical
  @override
  List<Object> get props => [id];
}
