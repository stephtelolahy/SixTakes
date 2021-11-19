part of 'event.dart';

/// put the selected card at the end of one of the four rows on the table
class GameEventPutRow extends GameEvent {
  final String player;
  final int card;
  final int row;

  GameEventPutRow({
    required this.player,
    required this.card,
    required this.row,
  });

  @override
  List<Object?> get props => [player, card, row];

  @override
  dispatch(Game state) {
    final actor = state.players.firstWhere((e) => e.id == 'p1');
    final rowObject = state.rows[row];
    actor.played = null;
    rowObject.cards.add(card);
  }
}
