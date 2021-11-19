part of 'event.dart';

/// gather all cards on a row
class GameEventTakeRow extends GameEvent {
  final String player;
  final int row;

  GameEventTakeRow({
    required this.player,
    required this.row,
  });

  @override
  List<Object?> get props => [player, row];

  @override
  dispatch(Game state) {
    final actor = state.players.firstWhere((e) => e.id == player);
    final rowObject = state.rows[row];
    actor.bulls += rowObject.cards.map((e) => e.bulls).reduce((a, b) => a + b);
    actor.gathered.addAll(rowObject.cards);
    rowObject.cards.clear();
  }
}
