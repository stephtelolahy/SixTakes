import 'package:flutter/material.dart';
import 'package:sixtakes/ui/game/widgets/card_widget.dart';
import 'animated_card_data.dart';

class AnimatedCardWidget extends StatelessWidget {
  final AnimatedCardData data;
  final Rect renderBox;

  const AnimatedCardWidget({
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
        curve: Curves.easeIn,
        opacity: data.hidden ? 0 : 1,
        child: CardWidget(
          value: data.value,
          bulls: data.bulls,
          width: renderBox.width,
          height: renderBox.height,
          covered: data.covered,
        ),
      ),
    );
  }
}
