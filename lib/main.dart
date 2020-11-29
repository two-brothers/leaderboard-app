import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:wakelock/wakelock.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Wakelock.enable();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.black));
    return MaterialApp(
      title: 'Leaderboard',
      routes: {
        "/": (_) => SafeArea(
              child: WebviewScaffold(
                url: "https://leaderboard-19f69.web.app/leaderboards",
                appCacheEnabled: false,
              ),
            ),
      },
    );
  }
}
