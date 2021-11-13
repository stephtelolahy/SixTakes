import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widgets/card_widget.dart';
import 'game_model.dart';

class GameView extends StatelessWidget {
  const GameView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GameModel>(
      create: (context) => GameModel()..init(),
      builder: (context, _) => Scaffold(
        appBar: AppBar(title: const Text('Card game')),
        floatingActionButton: FloatingActionButton(
          onPressed: () => context.read<GameModel>().update(),
          child: const Icon(Icons.animation),
        ),
        body: const GameBoard(),
      ),
    );
  }
}

class GameBoard extends StatelessWidget {
  const GameBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<GameModel>(builder: (context, model, child) {
      return Container(
        constraints: const BoxConstraints.expand(),
        child: Stack(
          children: model.cards.map((e) => CardWidget(data: e)).toList(),
        ),
      );
    });
  }
}
