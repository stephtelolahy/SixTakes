class Game {
  bool select;
  final List<GameRow> rows;
  final List<Player> players;
  List<String>? winner;

  Game({
    required this.select,
    required this.rows,
    required this.players,
    this.winner,
  });
}

class GameRow {
  List<int> cards;

  GameRow({required this.cards});
}

class Player {
  final String id;
  final String name;
  final String photoURL;
  final List<int> hand;
  final List<int> gathered;
  int bulls;
  int? played;

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
