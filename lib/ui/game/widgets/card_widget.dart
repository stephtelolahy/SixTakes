import 'package:flutter/material.dart';

import '../game_model.dart';

class CardWidget extends StatelessWidget {
  final DisplayableCard data;
  final Rect renderBox;

  const CardWidget({
    Key? key,
    required this.data,
    required this.renderBox,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
        width: renderBox.width,
        height: renderBox.height,
        top: renderBox.top,
        left: renderBox.left,
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn,
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 500),
          opacity: data.hidden ? 0 : 1,
          child: Card(
            elevation: 1.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(2.0),
            ),
            color: data.covered ? Colors.white : _backgroundColor(data.bulls),
            child: Center(
              child: Column(
                children: [
                  Text(data.covered ? '?' : '${data.value}'),
                  const Icon(Icons.smart_toy),
                ],
              ),
            ),
          ),
        ));
  }

  static Color _backgroundColor(int bulls) {
    switch (bulls) {
      case 1:
        return Colors.white;

      case 2:
        return Colors.lightBlue;

      case 3:
        return Colors.orange;

      case 5:
        return Colors.red;

      case 7:
        return Colors.purple;

      default:
        throw Exception('Invalid bulls');
    }
  }
}
