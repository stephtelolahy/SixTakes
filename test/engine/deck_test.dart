import 'package:sixtakes/data/engine/deck.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final sut = GameDeck();

  test('generate deck of cards', () {
    // Given
    // When
    final cards = sut.createDeck();

    // Assert
    expect(cards.length, equals(104));

    // 1 card with 7 cattle heads—number 55
    expect(cards.firstWhere((e) => e.value == 55).bulls, equals(7));

    // 8 cards with 5 cattle heads—multiples of 11 (except 55): 11, 22, 33, 44, 66, 77, 88, 99
    expect(cards.firstWhere((e) => e.value == 11).bulls, equals(5));
    expect(cards.firstWhere((e) => e.value == 22).bulls, equals(5));
    expect(cards.firstWhere((e) => e.value == 33).bulls, equals(5));
    expect(cards.firstWhere((e) => e.value == 44).bulls, equals(5));
    expect(cards.firstWhere((e) => e.value == 66).bulls, equals(5));
    expect(cards.firstWhere((e) => e.value == 77).bulls, equals(5));
    expect(cards.firstWhere((e) => e.value == 88).bulls, equals(5));
    expect(cards.firstWhere((e) => e.value == 99).bulls, equals(5));

    // 10 cards with 3 cattle heads—multiples of ten: 10, 20, 30, 40, 50, 60, 70, 80, 90, 100
    expect(cards.firstWhere((e) => e.value == 10).bulls, equals(3));
    expect(cards.firstWhere((e) => e.value == 20).bulls, equals(3));
    expect(cards.firstWhere((e) => e.value == 30).bulls, equals(3));
    expect(cards.firstWhere((e) => e.value == 40).bulls, equals(3));
    expect(cards.firstWhere((e) => e.value == 50).bulls, equals(3));
    expect(cards.firstWhere((e) => e.value == 60).bulls, equals(3));
    expect(cards.firstWhere((e) => e.value == 70).bulls, equals(3));
    expect(cards.firstWhere((e) => e.value == 80).bulls, equals(3));
    expect(cards.firstWhere((e) => e.value == 90).bulls, equals(3));
    expect(cards.firstWhere((e) => e.value == 100).bulls, equals(3));

    // 9 cards with 2 cattle heads—multiples of five that are not multiples of ten (except 55): 5, 15, 25, 35, 45, 65, 75, 85, 95
    expect(cards.firstWhere((e) => e.value == 5).bulls, equals(2));
    expect(cards.firstWhere((e) => e.value == 15).bulls, equals(2));
    expect(cards.firstWhere((e) => e.value == 25).bulls, equals(2));
    expect(cards.firstWhere((e) => e.value == 35).bulls, equals(2));
    expect(cards.firstWhere((e) => e.value == 45).bulls, equals(2));
    expect(cards.firstWhere((e) => e.value == 65).bulls, equals(2));
    expect(cards.firstWhere((e) => e.value == 75).bulls, equals(2));
    expect(cards.firstWhere((e) => e.value == 85).bulls, equals(2));
    expect(cards.firstWhere((e) => e.value == 95).bulls, equals(2));

    // 76 cards with 1 cattle head—the rest of the cards from 1 through 104
    expect(cards.firstWhere((e) => e.value == 1).bulls, equals(1));
    expect(cards.firstWhere((e) => e.value == 104).bulls, equals(1));
    expect(cards.firstWhere((e) => e.value == 57).bulls, equals(1));
  });
}
