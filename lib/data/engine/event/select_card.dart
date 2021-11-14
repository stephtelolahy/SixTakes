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
    final you = state.players.firstWhere((e) => e.id == player);
    you.hand.remove(card);
    you.played = card;
  }
}
