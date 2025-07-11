import 'dart:ui';

import 'package:flutter/cupertino.dart';

import '../../domain/entities/all_positioned_element.dart'; // For Path, Canvas, Paint, Offset

class StoryPainter extends CustomPainter {
  final List<DrawingElement> drawingPaths;

  StoryPainter({required this.drawingPaths});

  @override
  void paint(Canvas canvas, Size size) {
    for (var drawingElement in drawingPaths) {
      if (drawingElement.points.isEmpty) continue;

      final paint = Paint()
        ..color = drawingElement.color
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..strokeWidth = drawingElement.strokeWidth
        ..style = PaintingStyle.stroke;

      final path = Path();

      path.moveTo(drawingElement.points.first.dx, drawingElement.points.first.dy);

      for (int i = 0; i < drawingElement.points.length - 1; i++) {
        final p0 = drawingElement.points[i];
        final p1 = drawingElement.points[i + 1];
        if (i < drawingElement.points.length - 2) {
          final nextPoint = drawingElement.points[i + 2];
          final controlPoint = p1;
          final endPoint = Offset((p1.dx + nextPoint.dx) / 2, (p1.dy + nextPoint.dy) / 2);
          path.quadraticBezierTo(controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy);
        } else {
          path.lineTo(p1.dx, p1.dy);
        }
      }
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant StoryPainter oldDelegate) {
    return oldDelegate.drawingPaths != drawingPaths;
  }
}