import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'dart:math' as math;

class InfiniteProgressBarWidget extends CustomPainter {
  final Color color;
  final double waveRadius;
  Paint wavePaint;

  InfiniteProgressBarWidget({@required this.color, @required this.waveRadius}) {
    wavePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
  }

  @override
  void paint(Canvas canvas, Size size) {
    double centerX = size.width / 2.0;
    double centerY = size.height / 2.0;
    double maxRadius = _hypot(centerX, centerY);

    var currentRadius = waveRadius;
    while (currentRadius < maxRadius) {
      canvas.drawCircle(Offset(centerX, centerY), currentRadius, wavePaint);
      currentRadius += 5.0;
    }
  }

  @override
  bool shouldRepaint(InfiniteProgressBarWidget oldDelegate) {
    return oldDelegate.waveRadius != waveRadius;
  }

  double _hypot(double x, double y) {
    return math.sqrt(x * x + y * y);
  }
}