import 'dart:math';
import 'package:flutter/material.dart';
import '../theme/prosto_theme.dart';

class WearRing extends StatelessWidget {
  const WearRing({
    super.key,
    required this.progress,
    this.size = 56,
    this.strokeWidth = 6,
    this.center,
    this.color,
  });

  final double progress;
  final double size;
  final double strokeWidth;
  final Widget? center;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: CustomPaint(
        painter: _WearRingPainter(
          progress: progress.clamp(0.0, 1.0).toDouble(),
          strokeWidth: strokeWidth,
          color: color ?? ProsToColors.champagne,
        ),
        child: Center(child: center),
      ),
    );
  }
}

class _WearRingPainter extends CustomPainter {
  _WearRingPainter({
    required this.progress,
    required this.strokeWidth,
    required this.color,
  });

  final double progress;
  final double strokeWidth;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    final basePaint = Paint()
      ..color = ProsToColors.stroke
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final progressPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth;

    canvas.drawCircle(center, radius, basePaint);
    final sweep = 2 * pi * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      sweep,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _WearRingPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.color != color;
  }
}
