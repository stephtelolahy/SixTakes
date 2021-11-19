import 'package:sixtakes/data/model/card.dart';

class Game {
  final List<Player> players;
  final List<GameRow> rows;
  bool select;
  List<String>? winner;

  Game({
    required this.players,
    required this.rows,
    required this.select,
    this.winner,
  });
}

class Player {
  final String id;
  final String name;
  final String photoURL;
  final List<PlayingCard> hand;
  final List<PlayingCard> gathered;
  int bulls;
  PlayingCard? played;

  Player({
    required this.id,
    required this.name,
    required this.photoURL,
    required this.hand,
    required this.gathered,
    required this.bulls,
    this.played,
  });
}

class GameRow {
  List<PlayingCard> cards;

  GameRow({required this.cards});
}
