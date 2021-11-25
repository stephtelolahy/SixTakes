import 'package:flutter/widgets.dart';

class SizeUtils {
  static const ITEM_SPACING = 2.0;

  static double maxItemWidthInARow(BuildContext context, int itemsCount) {
    final screenW = MediaQuery.of(context).size.width;
    return (screenW - itemsCount * ITEM_SPACING) / itemsCount;
  }
}
