import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';

class InnerShadow extends SingleChildRenderObjectWidget {
  const InnerShadow({
    Key? key,
    this.shadows = const <Shadow>[],
    Widget? child,
  }) : super(key: key, child: child);

  final List<Shadow> shadows;

  @override
  RenderObject createRenderObject(BuildContext context) {
    final renderObject = _RenderInnerShadow();
    updateRenderObject(context, renderObject);
    return renderObject;
  }

  @override
  void updateRenderObject(
      BuildContext context, _RenderInnerShadow renderObject) {
    renderObject.shadows = shadows;
  }
}

class _RenderInnerShadow extends RenderProxyBox {
  late List<Shadow> shadows;

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child == null) return;
    final bounds = offset & size;

    // ارسم الطفل أولاً
    context.paintChild(child!, offset);

    // ارسم ظل داخلي على الحواف فقط
    for (final shadow in shadows) {
      final Paint shadowPaint = Paint()
        ..color = shadow.color
        ..maskFilter = MaskFilter.blur(BlurStyle.inner, shadow.blurRadius);

      final Path outer = Path()
        ..addRRect(RRect.fromRectAndRadius(bounds.inflate(shadow.blurRadius),
            Radius.circular(30))); // outer أكبر
      final Path inner = Path()
        ..addRRect(RRect.fromRectAndRadius(
            bounds, Radius.circular(30))) // inner حواف العنصر الفعلية
        ..close();

      final Path borderPath = Path.combine(
          PathOperation.difference, outer, inner);

      context.canvas.save();
      context.canvas.translate(
       shadow.offset.dx, shadow.offset.dy);
      context.canvas.drawPath(borderPath, shadowPaint);
      context.canvas.restore();
    }
  }
}