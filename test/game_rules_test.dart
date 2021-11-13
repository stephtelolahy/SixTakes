import 'package:sixtakes/data/engine/game_rules.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final sut = GameRules();

  test('get winner', () {
    // Given
    // When
    // Assert
  });

  test('get bulls for card', () {
    // Given
    // When
    // Assert

    // 1 card with 7 cattle heads—number 55
    expect(sut.bullsForCard(55), equals(7));

    // 8 cards with 5 cattle heads—multiples of 11 (except 55): 11, 22, 33, 44, 66, 77, 88, 99
    expect(sut.bullsForCard(11), equals(5));
    expect(sut.bullsForCard(22), equals(5));
    expect(sut.bullsForCard(33), equals(5));
    expect(sut.bullsForCard(44), equals(5));
    expect(sut.bullsForCard(66), equals(5));
    expect(sut.bullsForCard(77), equals(5));
    expect(sut.bullsForCard(88), equals(5));
    expect(sut.bullsForCard(99), equals(5));

    // 10 cards with 3 cattle heads—multiples of ten: 10, 20, 30, 40, 50, 60, 70, 80, 90, 100
    expect(sut.bullsForCard(10), equals(3));
    expect(sut.bullsForCard(20), equals(3));
    expect(sut.bullsForCard(30), equals(3));
    expect(sut.bullsForCard(40), equals(3));
    expect(sut.bullsForCard(50), equals(3));
    expect(sut.bullsForCard(60), equals(3));
    expect(sut.bullsForCard(70), equals(3));
    expect(sut.bullsForCard(80), equals(3));
    expect(sut.bullsForCard(90), equals(3));
    expect(sut.bullsForCard(100), equals(3));

    // 9 cards with 2 cattle heads—multiples of five that are not multiples of ten (except 55): 5, 15, 25, 35, 45, 65, 75, 85, 95
    expect(sut.bullsForCard(5), equals(2));
    expect(sut.bullsForCard(15), equals(2));
    expect(sut.bullsForCard(25), equals(2));
    expect(sut.bullsForCard(35), equals(2));
    expect(sut.bullsForCard(45), equals(2));
    expect(sut.bullsForCard(65), equals(2));
    expect(sut.bullsForCard(75), equals(2));
    expect(sut.bullsForCard(85), equals(2));
    expect(sut.bullsForCard(95), equals(2));

    // 76 cards with 1 cattle head—the rest of the cards from 1 through 104
    expect(sut.bullsForCard(1), equals(1));
    expect(sut.bullsForCard(104), equals(1));
    expect(sut.bullsForCard(57), equals(1));
  });
}
