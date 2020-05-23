import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EightBall extends StatelessWidget {
  final String id;

  EightBall({@required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Active game")), body: SingleChildScrollView(child: Text("eight ball")));
  }
}
