class AnimatedCardData {
  final int value;
  final int bulls;
  final bool covered;
  final bool hidden;
  final String renderKey;

  const AnimatedCardData({
    required this.value,
    required this.bulls,
    this.covered = false,
    this.hidden = false,
    required this.renderKey,
  });
}
