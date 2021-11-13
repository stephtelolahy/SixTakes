class Game {
  int phase;
  final List<GameRow> board;
  final List<Player> players;
  String? winner;

  Game({
    required this.phase,
    required this.board,
    required this.players,
    this.winner,
  });
}

class GameRow {
  final List<int> cards;

  GameRow({required this.cards});
}

class Player {
  final String id;
  final String name;
  final String photoURL;
  final List<int> hand;
  int bulls;
  int? played;

  Player({
    required this.id,
    required this.name,
    required this.photoURL,
    required this.hand,
    required this.bulls,
    this.played,
  });
}
