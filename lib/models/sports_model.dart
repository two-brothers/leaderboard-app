import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

class SportsModel extends Equatable {
  final String id;
  final String title;

  SportsModel({@required this.id, @required this.title});

  factory SportsModel.fromJson(String id, Map<String, dynamic> parsedJson) {
    return SportsModel(id: id, title: parsedJson['title']);
  }

  // Two objects with the same id will be assumed to be identical
  @override
  List<Object> get props => [id];
}
