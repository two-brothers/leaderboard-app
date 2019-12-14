import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

class SportsModel extends Equatable {
  final String id;
  final String title;

  SportsModel({@required this.id, @required this.title});

  factory SportsModel.fromJson(Map<String, dynamic> parsedJson) {
    return SportsModel(id: parsedJson['id'], title: parsedJson['title']);
  }

  // Two SportsModel objects with the same id will be assumed to be identical
  @override
  List<Object> get props => [id];
}
