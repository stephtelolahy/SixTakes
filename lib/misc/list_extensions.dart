import 'dart:math';

extension Convenience<T> on List<T> {
  T randomElement() {
    final random = Random();
    var i = random.nextInt(length);
    return this[i];
  }
}
