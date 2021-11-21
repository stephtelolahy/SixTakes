import 'package:flutter/material.dart';
import 'package:sixtakes/data/engine/rules.dart';
import 'package:sixtakes/data/model/game.dart';

class PlayerWidget extends StatelessWidget {
  final double width;
  final double height;
  final Player player;

  const PlayerWidget({
    Key? key,
    required this.width,
    required this.height,
    required this.player,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final malus = player.bulls;
    return SizedBox(
      width: width,
      height: height,
      child: Column(
        children: [
          Text(player.name),
          malus > 0 ? Text('-$malus') : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
