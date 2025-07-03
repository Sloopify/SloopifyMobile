import 'dart:ui';

import 'package:flutter/cupertino.dart';

import '../../domain/all_positioned_element.dart'; // For Path, Canvas, Paint, Offset

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
        ..strokeJoin = StrokeJoin.round // Helps with sharp corners
        ..strokeWidth = drawingElement.strokeWidth
        ..style = PaintingStyle.stroke;

      final path = Path();

      // Move to the first point
      path.moveTo(drawingElement.points.first.dx, drawingElement.points.first.dy);

      // Iterate through points to create Bezier segments
      // This is a simplified example for quadratic Bezier.
      // You might need more sophisticated logic for control points.
      for (int i = 0; i < drawingElement.points.length - 1; i++) {
        final p0 = drawingElement.points[i];
        final p1 = drawingElement.points[i + 1];

        // Calculate a control point. A simple way is to use the midpoint
        // between p0 and p1 as the control point for a quadratic Bezier
        // that goes *through* p1. Or, more commonly, use the midpoint
        // between p0 and p1 as the *end point* of the previous curve,
        // and the midpoint between p1 and p2 as the *start point* of the next.
        // This is where path smoothing algorithms come in.

        // For a basic smooth line, you can use quadraticBezierTo by calculating
        // the midpoint as the control point for the segment ending at p1.
        // This is a common technique for drawing smooth lines from a series of points.
        if (i < drawingElement.points.length - 2) {
          final nextPoint = drawingElement.points[i + 2];
          final controlPoint = p1; // The current point is the control point
          final endPoint = Offset((p1.dx + nextPoint.dx) / 2, (p1.dy + nextPoint.dy) / 2);
          path.quadraticBezierTo(controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy);
        } else {
          // For the last segment, just draw a line to the last point
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