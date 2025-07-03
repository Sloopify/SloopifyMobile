import 'package:flutter/material.dart';
import 'package:sloopify_mobile/features/create_story/domain/all_positioned_element.dart';

class DrawingPainter extends CustomPainter {
  final List<DrawingElement> lines;
  final DrawingElement? currentLine;
  DrawingPainter({
    required this.lines,
    this.currentLine,
  });
  @override
  void paint(Canvas canvas, Size size) {
    // Draw completed lines
    for (final line in lines) {
      _drawLine(canvas, line);
    }
    // Draw current line being drawn
    if (currentLine != null) {
      _drawLine(canvas, currentLine!);
    }
  }
  void _drawLine(Canvas canvas, DrawingElement line) {
    if (line.points.length < 2) return;
    final paint = Paint()
      ..color = line.color
      ..strokeWidth = line.strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    final path = Path();
    path.moveTo(line.points.first.dx, line.points.first.dy);
    for (int i = 1; i < line.points.length; i++) {
      path.lineTo(line.points[i].dx, line.points[i].dy);
    }
    canvas.drawPath(path, paint);
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}