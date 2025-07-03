import 'package:flutter/material.dart';
class CropOverlay extends StatefulWidget {
  final Rect cropRect;
  final Function(Rect) onCropChanged;
  const CropOverlay({
    Key? key,
    required this.cropRect,
    required this.onCropChanged,
  }) : super(key: key);
  @override
  State<CropOverlay> createState() => _CropOverlayState();
}
class _CropOverlayState extends State<CropOverlay> {
  late Rect _cropRect;
  @override
  void initState() {
    super.initState();
    _cropRect = widget.cropRect;
  }
  void _updateCropRect(Rect newRect) {
    setState(() {
      _cropRect = newRect;
    });
    widget.onCropChanged(newRect);
  }
  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: CustomPaint(
        painter: CropPainter(cropRect: _cropRect),
        child: Stack(
          children: [
            // Corner handles
            _buildCornerHandle(Alignment.topLeft),
            _buildCornerHandle(Alignment.topRight),
            _buildCornerHandle(Alignment.bottomLeft),
            _buildCornerHandle(Alignment.bottomRight),
            // Edge handles
            _buildEdgeHandle(Alignment.topCenter),
            _buildEdgeHandle(Alignment.bottomCenter),
            _buildEdgeHandle(Alignment.centerLeft),
            _buildEdgeHandle(Alignment.centerRight),
          ],
        ),
      ),
    );
  }
  Widget _buildCornerHandle(Alignment alignment) {
    return Positioned(
      left: _getHandleLeft(alignment),
      top: _getHandleTop(alignment),
      child: GestureDetector(
        onPanUpdate: (details) => _handleCornerDrag(alignment, details),
        child: Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.blue, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
  Widget _buildEdgeHandle(Alignment alignment) {
    return Positioned(
      left: _getHandleLeft(alignment),
      top: _getHandleTop(alignment),
      child: GestureDetector(
        onPanUpdate: (details) => _handleEdgeDrag(alignment, details),
        child: Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.blue, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
  double _getHandleLeft(Alignment alignment) {
    final size = MediaQuery.of(context).size;
    switch (alignment) {
      case Alignment.topLeft:
      case Alignment.centerLeft:
      case Alignment.bottomLeft:
        return _cropRect.left * size.width - 10;
      case Alignment.topCenter:
      case Alignment.bottomCenter:
        return (_cropRect.left + _cropRect.width / 2) * size.width - 10;
      case Alignment.topRight:
      case Alignment.centerRight:
      case Alignment.bottomRight:
        return (_cropRect.left + _cropRect.width) * size.width - 10;
      default:
        return 0;
    }
  }
  double _getHandleTop(Alignment alignment) {
    final size = MediaQuery.of(context).size;
    switch (alignment) {
      case Alignment.topLeft:
      case Alignment.topCenter:
      case Alignment.topRight:
        return _cropRect.top * size.height - 10;
      case Alignment.centerLeft:
      case Alignment.centerRight:
        return (_cropRect.top + _cropRect.height / 2) * size.height - 10;
      case Alignment.bottomLeft:
      case Alignment.bottomCenter:
      case Alignment.bottomRight:
        return (_cropRect.top + _cropRect.height) * size.height - 10;
      default:
        return 0;
    }
  }
  void _handleCornerDrag(Alignment alignment, DragUpdateDetails details) {
    final size = MediaQuery.of(context).size;
    final delta = Offset(
      details.delta.dx / size.width,
      details.delta.dy / size.height,
    );
    Rect newRect = _cropRect;
    switch (alignment) {
      case Alignment.topLeft:
        newRect = Rect.fromLTRB(
          (_cropRect.left + delta.dx).clamp(0.0, _cropRect.right - 0.1),
          (_cropRect.top + delta.dy).clamp(0.0, _cropRect.bottom - 0.1),
          _cropRect.right,
          _cropRect.bottom,
        );
        break;
      case Alignment.topRight:
        newRect = Rect.fromLTRB(
          _cropRect.left,
          (_cropRect.top + delta.dy).clamp(0.0, _cropRect.bottom - 0.1),
          (_cropRect.right + delta.dx).clamp(_cropRect.left + 0.1, 1.0),
          _cropRect.bottom,
        );
        break;
      case Alignment.bottomLeft:
        newRect = Rect.fromLTRB(
          (_cropRect.left + delta.dx).clamp(0.0, _cropRect.right - 0.1),
          _cropRect.top,
          _cropRect.right,
          (_cropRect.bottom + delta.dy).clamp(_cropRect.top + 0.1, 1.0),
        );
        break;
      case Alignment.bottomRight:
        newRect = Rect.fromLTRB(
          _cropRect.left,
          _cropRect.top,
          (_cropRect.right + delta.dx).clamp(_cropRect.left + 0.1, 1.0),
          (_cropRect.bottom + delta.dy).clamp(_cropRect.top + 0.1, 1.0),
        );
        break;
    }
    _updateCropRect(newRect);
  }
  void _handleEdgeDrag(Alignment alignment, DragUpdateDetails details) {
    final size = MediaQuery.of(context).size;
    final delta = Offset(
      details.delta.dx / size.width,
      details.delta.dy / size.height,
    );
    Rect newRect = _cropRect;
    switch (alignment) {
      case Alignment.topCenter:
        newRect = Rect.fromLTRB(
          _cropRect.left,
          (_cropRect.top + delta.dy).clamp(0.0, _cropRect.bottom - 0.1),
          _cropRect.right,
          _cropRect.bottom,
        );
        break;
      case Alignment.bottomCenter:
        newRect = Rect.fromLTRB(
          _cropRect.left,
          _cropRect.top,
          _cropRect.right,
          (_cropRect.bottom + delta.dy).clamp(_cropRect.top + 0.1, 1.0),
        );
        break;
      case Alignment.centerLeft:
        newRect = Rect.fromLTRB(
          (_cropRect.left + delta.dx).clamp(0.0, _cropRect.right - 0.1),
          _cropRect.top,
          _cropRect.right,
          _cropRect.bottom,
        );
        break;
      case Alignment.centerRight:
        newRect = Rect.fromLTRB(
          _cropRect.left,
          _cropRect.top,
          (_cropRect.right + delta.dx).clamp(_cropRect.left + 0.1, 1.0),
          _cropRect.bottom,
        );
        break;
    }
    _updateCropRect(newRect);
  }
}
class CropPainter extends CustomPainter {
  final Rect cropRect;
  CropPainter({required this.cropRect});
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black.withOpacity(0.5)
      ..style = PaintingStyle.fill;
    // Draw overlay outside crop area
    final cropRectPixels = Rect.fromLTWH(
      cropRect.left * size.width,
      cropRect.top * size.height,
      cropRect.width * size.width,
      cropRect.height * size.height,
    );
    // Top overlay
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, cropRectPixels.top),
      paint,
    );
    // Bottom overlay
    canvas.drawRect(
      Rect.fromLTWH(0, cropRectPixels.bottom, size.width, size.height -
          cropRectPixels.bottom),
      paint,
    );
    // Left overlay
    canvas.drawRect(
      Rect.fromLTWH(0, cropRectPixels.top, cropRectPixels.left,
          cropRectPixels.height),
      paint,
    );
    // Right overlay
    canvas.drawRect(
      Rect.fromLTWH(cropRectPixels.right, cropRectPixels.top, size.width -
          cropRectPixels.right, cropRectPixels.height),
      paint,
    );
    // Draw crop border
    final borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawRect(cropRectPixels, borderPaint);
    // Draw grid lines
    final gridPaint = Paint()
      ..color = Colors.white.withOpacity(0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    // Vertical grid lines
    for (int i = 1; i < 3; i++) {
      final x = cropRectPixels.left + (cropRectPixels.width / 3) * i;
      canvas.drawLine(
        Offset(x, cropRectPixels.top),
        Offset(x, cropRectPixels.bottom),
        gridPaint,
      );
    }
    // Horizontal grid lines
    for (int i = 1; i < 3; i++) {
      final y = cropRectPixels.top + (cropRectPixels.height / 3) * i;
      canvas.drawLine(
        Offset(cropRectPixels.left, y),
        Offset(cropRectPixels.right, y),
        gridPaint,
      );
    }
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}