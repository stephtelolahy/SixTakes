import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'game_model.dart';

class GameView extends StatelessWidget {
  const GameView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GameModel>(
      create: (context) {
        final model = GameModel();
        return model;
      },
      builder: (context, _) => Scaffold(
        appBar: AppBar(title: const Text('Card game')),
        floatingActionButton: IconButton(
          onPressed: () => context.read<GameModel>().update(),
          icon: const Icon(
            Icons.animation,
          ),
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
        color: Colors.amber,
        constraints: const BoxConstraints.expand(),
        width: 200,
        height: 350,
        child: Stack(
          children: <Widget>[
            AnimatedPositioned(
              width: model.selected ? 200.0 : 50.0,
              height: model.selected ? 50.0 : 200.0,
              top: model.selected ? 50.0 : 150.0,
              left: model.selected ? 50.0 : 150.0,
              duration: const Duration(seconds: 2),
              curve: Curves.fastOutSlowIn,
              child: Container(
                color: Colors.blue,
                child: const Center(child: Text('Card')),
              ),
            ),
          ],
        ),
      );
    });
  }
}
