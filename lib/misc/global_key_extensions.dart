import 'package:flutter/material.dart';

extension Positionning on GlobalKey {
  Rect renderBox() {
    final context = currentContext;
    if (context == null) {
      throw Exception("Missing GlobalKey context");
    }
    final box = context.findRenderObject() as RenderBox;
    final offset = box.localToGlobal(Offset.zero);
    return Rect.fromLTWH(offset.dx, offset.dy, box.size.width, box.size.height);
  }
}
