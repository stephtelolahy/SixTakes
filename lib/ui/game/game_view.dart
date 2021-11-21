import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixtakes/data/model/game.dart';
import 'package:sixtakes/misc/global_key_extensions.dart';
import 'package:sixtakes/ui/game/widgets/placeholder_widget.dart';
import 'package:sixtakes/ui/game/widgets/player_widget.dart';

import 'widgets/card_widget.dart';
import 'game_model.dart';

class GameView extends StatelessWidget {
  const GameView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GameModel>(
      create: (context) {
        final model = GameModel();
        WidgetsBinding.instance?.addPostFrameCallback((_) {
          model.initialize();
        });
        return model;
      },
      builder: (context, _) => Scaffold(
        backgroundColor: Colors.green[700],
        floatingActionButton: FloatingActionButton(
          onPressed: () => _showHandSelector(context),
          child: const Icon(Icons.animation),
        ),
        body: GameBoard(),
      ),
    );
  }

  void _showHandSelector(BuildContext context) {
    final cards = context.read<GameModel>().you.hand.map((e) => '${e.value}');
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => SimpleDialog(
        title: const Text('Select a card'),
        children: cards
            .map((e) => ListTile(
                  leading: const Icon(Icons.copy),
                  title: Text(e),
                  onTap: () => Navigator.pop(context, e),
                ))
            .toList(),
      ),
    ).then((returnVal) {
      if (returnVal != null) {
        context.read<GameModel>().play(int.parse(returnVal));
      }
    });
  }
}

class GameBoard extends StatelessWidget {
  GameBoard({Key? key}) : super(key: key);

  static const int ROWS_COUNT = 4;
  static const int CARDS_PER_ROW = 6;

  // TODO: compute card size from device screen size
  static const double CARD_WIDTH = 60;
  static const double CARD_HEIGHT = 75;

  final Map<String, GlobalKey> _keys = {};

  GlobalKey _getOrCreateKey(String name) {
    final value = _keys[name];
    if (value != null) {
      return value;
    } else {
      final newValue = GlobalKey();
      _keys[name] = newValue;
      return newValue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GameModel>(builder: (context, model, child) {
      return Stack(
        children: <Widget>[
              SafeArea(
                child: Column(
                  children: [
                    model.loaded ? _buildOthers(context, model.others) : const SizedBox.shrink(),
                    _buildGameRows(context),
                    model.loaded ? _buildYou(context, model.you) : const SizedBox.shrink(),
                    //_buildHand(context, _gameController.you.hand),
                  ],
                ),
              )
            ] +
            model.cards
                .map((e) => CardWidget(
                      key: Key('card${e.value}'),
                      data: e,
                      renderBox: _getOrCreateKey(e.renderKey).renderBox(),
                    ))
                .toList(),
      );
    });
  }

  Widget _buildOthers(BuildContext context, List<Player> players) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: players
          .map(
            (e) => PlayerWidget(
              key: _getOrCreateKey(e.id),
              width: CARD_WIDTH,
              height: CARD_HEIGHT,
              player: e,
            ),
          )
          .toList(),
    );
  }

  Widget _buildGameRows(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(ROWS_COUNT, (idx) => _buildGameRow(context, idx)).toList(),
      ),
    );
  }

  Widget _buildGameRow(BuildContext context, int rowIndex) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        CARDS_PER_ROW,
        (colIndex) => PlaceholderWidget(
          key: _getOrCreateKey('row$rowIndex$colIndex'),
          width: CARD_WIDTH,
          height: CARD_HEIGHT,
        ),
      ).toList(),
    );
  }

  Widget _buildYou(BuildContext context, Player player) {
    return Center(
      child: PlayerWidget(
        key: _getOrCreateKey(player.id),
        width: CARD_WIDTH,
        height: CARD_HEIGHT,
        player: player,
      ),
    );
  }
}
