import 'package:flutter/material.dart';

/// Encapsulates the StreamBuilder pattern for a simpler interface:
/// If the snapshot has data:
///  - expose it on the [data] parameter of [builder]
/// Otherwise:
///  - display the [placeholder] widget
class StreamWidget<T> extends StatelessWidget {
  final Stream<T> stream;
  final Widget Function(BuildContext context, T data) builder;
  final Widget placeholder;

  StreamWidget({@required this.stream, @required this.builder, this.placeholder});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
        stream: stream,
        builder: (context, snapshot) => snapshot.hasData ? builder(context, snapshot.data) : (placeholder ?? SizedBox.shrink()));
  }
}
