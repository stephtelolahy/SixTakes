import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widgets/card_widget.dart';
import 'game_model.dart';

class GameView extends StatelessWidget {
  const GameView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GameModel>(
      create: (context) => GameModel(),
      builder: (context, _) => Scaffold(
        backgroundColor: Colors.green[700],
        floatingActionButton: FloatingActionButton(
          onPressed: () => context.read<GameModel>().update(),
          child: const Icon(Icons.animation),
        ),
        body: GameBoard(),
      ),
    );
  }
}

class GameBoard extends StatelessWidget {
  GameBoard({Key? key}) : super(key: key);

  static const double CARD_WIDTH = 40;
  static const double CARD_HEIGHT = 50;

  final Map<String, GlobalKey> _globalKeys = {
    'player0': GlobalKey(),
    'player1': GlobalKey(),
    'player2': GlobalKey(),
    'player3': GlobalKey()
  };

  @override
  Widget build(BuildContext context) {
    return Consumer<GameModel>(builder: (context, model, child) {
      return Stack(
        children: <Widget>[
              SafeArea(
                child: Column(
                  children: [
                    _buildOthers(context),
                    //_buildPlayground(context, discard: _gameController.discard),
                    //_buildYou(context, _gameController.you, state),
                    //_buildHand(context, _gameController.you.hand),
                  ],
                ),
              )
            ] +
            model.cards
                .map((e) => CardWidget(data: e, renderBox: _globalKeys[e.renderKey]!.renderBox()))
                .toList(),
      );
    });
  }

  Widget _buildOthers(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
          4,
          (idx) => CardPlaceholder(
                key: _globalKeys['player$idx'],
                name: 'player$idx',
                width: CARD_WIDTH,
                height: CARD_HEIGHT,
              )).toList(),
    );
  }
}

class CardPlaceholder extends StatelessWidget {
  final String name;
  final double width;
  final double height;

  const CardPlaceholder({
    Key? key,
    required this.name,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white38,
      width: width,
      height: height,
      child: Text(
        name,
        textAlign: TextAlign.center,
      ),
    );
  }
}

extension Positionning on GlobalKey {
  Rect renderBox() {
    final context = currentContext;
    if (context == null) {
      throw Exception("Missing GlobalKey context");
    }
    final box = context.findRenderObject() as RenderBox;
    final offset = box.localToGlobal(Offset.zero);
    return Rect.fromLTWH(offset.dx, offset.dy, box.size.width, box.size.height);
  }
}
