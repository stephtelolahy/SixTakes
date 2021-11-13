import 'dart:ui';

class CardModel {
  final String id;
  final int value;
  final int bulls;
  bool covered;
  bool hidden;
  Rect position;

  CardModel({
    required this.id,
    required this.value,
    required this.bulls,
    this.covered = false,
    this.hidden = false,
    required this.position,
  });
}
