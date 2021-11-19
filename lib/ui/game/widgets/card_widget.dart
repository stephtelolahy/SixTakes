import 'package:flutter/material.dart';

import '../game_model.dart';

class CardWidget extends StatelessWidget {
  final DisplayableCard data;

  const CardWidget({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
        key: Key(data.value.toString()),
        width: data.position.width,
        height: data.position.height,
        top: data.position.top,
        left: data.position.left,
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn,
        child: Opacity(
          opacity: data.hidden ? 0 : 1,
          child: Card(
            elevation: 1.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
            ),
            color: Colors.blue,
            child: Center(
              child: Column(
                children: [Text('${data.value}'), const Icon(Icons.smart_toy)],
              ),
            ),
          ),
        ));
  }
}
