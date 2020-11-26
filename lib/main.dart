import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:wakelock/wakelock.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Wakelock.enable();
    return MaterialApp(
      title: 'Leaderboard',
      routes: {
        "/": (_) => SafeArea(
              child: WebviewScaffold(
                url: "https://leaderboard-19f69.web.app/leaderboards",
              ),
            ),
      },
    );
  }
}
