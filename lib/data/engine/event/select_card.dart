part of 'event.dart';

/// select a card and put the card face down on the table
class GameEventSelectCard extends GameEvent {
  final String player;
  final int card;

  GameEventSelectCard({
    required this.player,
    required this.card,
  });

  @override
  List<Object?> get props => [player, card];

  @override
  dispatch(Game state) {
    final actor = state.players.firstWhere((e) => e.id == player);
    final cardObject = actor.hand.firstWhere((e) => e.value == card);
    actor.hand.remove(cardObject);
    actor.played = cardObject;
  }
}
