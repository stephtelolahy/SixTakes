part of 'event.dart';

/// put the selected card at the end of one of the four rows on the table
class GameEventPutRow extends GameEvent {
  final String player;
  final int row;

  GameEventPutRow({
    required this.player,
    required this.row,
  });

  @override
  List<Object?> get props => [player, row];

  @override
  dispatch(Game state) {
    final actor = state.players.firstWhere((e) => e.id == player);
    final cardObject = actor.played;
    if (cardObject == null) {
      throw Exception('Missing played card');
    }

    final rowObject = state.rows[row];
    actor.played = null;
    rowObject.cards.add(cardObject);
  }
}
