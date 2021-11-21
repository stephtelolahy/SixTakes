import 'package:flutter/widgets.dart';

class PlaceholderWidget extends StatelessWidget {
  final double width;
  final double height;

  const PlaceholderWidget({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
    );
  }
}
