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
  final List<int> hand;
  final List<int> gathered;
  int? played;
  int bulls;

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
  List<int> cards;

  GameRow({required this.cards});
}
