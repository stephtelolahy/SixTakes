part of 'event.dart';

/// gather all cards on a row
class GameEventTakeRow extends GameEvent {
  final String player;
  final int row;
  final int? excluding;

  GameEventTakeRow({
    required this.player,
    required this.row,
    this.excluding,
  });

  @override
  List<Object?> get props => [player, row];

  @override
  dispatch(Game state) {
    final actor = state.players.firstWhere((e) => e.id == player);
    final rowObject = state.rows[row];
    final cardsToTake = rowObject.cards.where((e) => e.value != excluding);
    actor.gathered.addAll(cardsToTake);
    rowObject.cards.removeWhere((e) => e.value != excluding);
  }
}
