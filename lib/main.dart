import 'package:flutter/material.dart';

import 'ui/game/game_view.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = '6takes!';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: GameView(),
    );
  }
}
