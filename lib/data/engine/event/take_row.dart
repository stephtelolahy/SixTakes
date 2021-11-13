part of 'event.dart';

/// gather the 5 cards on a row
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
  dispatch(Game state) {}
}
