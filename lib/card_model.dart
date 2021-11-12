import 'dart:math';

class CardModel {
  final String id;
  Rectangle<double> position;
  double opacity;

  CardModel({required this.id, required this.position, this.opacity = 0.0});
}
