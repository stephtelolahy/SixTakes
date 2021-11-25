import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CardWidget extends StatelessWidget {
  final int value;
  final int bulls;
  final double width;
  final double height;
  final bool covered;

  const CardWidget({
    Key? key,
    required this.value,
    required this.bulls,
    required this.width,
    required this.height,
    this.covered = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Card(
        elevation: 1.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2.0),
        ),
        color: covered ? Colors.white : _backgroundColor(bulls),
        child: Center(
          child: Column(
            children: [
              const Icon(Icons.smart_toy_outlined),
              Text(covered ? '?' : '$value',
                  style: TextStyle(
                    fontSize: 20,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 1
                      ..color = Colors.black,
                  )),
            ],
          ),
        ),
      ),
    );
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
