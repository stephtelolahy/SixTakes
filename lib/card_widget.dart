import 'package:flutter/material.dart';
import 'package:sixtakes/card_model.dart';

class CardWidget extends StatelessWidget {
  final CardModel model;

  const CardWidget({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
        key: Key(model.id),
        width: model.position.width,
        height: model.position.height,
        top: model.position.top,
        left: model.position.left,
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn,
        child: Opacity(
          opacity: model.hidden ? 0 : 1,
          child: Card(
            elevation: 1.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
            ),
            color: Colors.blue,
            child: Center(child: Text('${model.value}')),
          ),
        ));
  }
}
