import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixtakes/data/model/card.dart';
import 'package:sixtakes/data/model/game.dart';
import 'package:sixtakes/misc/global_key_extensions.dart';
import 'package:sixtakes/misc/size_utils.dart';
import 'package:sixtakes/ui/game/widgets/card_widget.dart';
import 'package:sixtakes/ui/game/widgets/placeholder_widget.dart';
import 'package:sixtakes/ui/game/widgets/player_widget.dart';

import 'widgets/animated_card_widget.dart';
import 'game_model.dart';

class GameView extends StatelessWidget {
  GameView({Key? key}) : super(key: key);

  static const int ROWS_COUNT = 4;
  static const int CARDS_PER_ROW = 6;
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
        body: _buildGameBoard(context),
      ),
    );
  }

  Widget _buildGameBoard(BuildContext context) {
    return Consumer<GameModel>(builder: (context, model, child) {
      return Stack(
        children: <Widget>[
              SafeArea(
                child: Column(
                  children: [
                    model.loaded ? _buildOthers(context, model.others) : const SizedBox.shrink(),
                    _buildGameRows(context),
                    model.loaded ? _buildYou(context, model.you) : const SizedBox.shrink(),
                    model.loaded ? _buildHand(context, model.you.hand) : const SizedBox.shrink(),
                  ],
                ),
              )
            ] +
            model.cards
                .map((e) => AnimatedCardWidget(
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(ROWS_COUNT, (idx) => _buildGameRow(context, idx)).toList(),
      ),
    );
  }

  Widget _buildGameRow(BuildContext context, int rowIndex) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
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
    return PlayerWidget(
      key: _getOrCreateKey(player.id),
      width: CARD_WIDTH,
      height: CARD_HEIGHT,
      player: player,
    );
  }

  Widget _buildHand(BuildContext context, List<PlayingCard> cards) {
    final maxWidth = SizeUtils.maxItemWidthInARow(context, cards.length);
    final cardWidth = min(CARD_WIDTH, maxWidth);

    return SizedBox(
      height: CARD_HEIGHT,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: cards
            .map(
              (e) => InkWell(
                  onTap: () => context.read<GameModel>().play(e.value),
                  child: CardWidget(
                    value: e.value,
                    bulls: e.bulls,
                    width: cardWidth,
                    height: CARD_HEIGHT,
                  )),
            )
            .toList(),
      ),
    );
  }
}
