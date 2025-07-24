import 'package:flutter/material.dart';

class ReliableTextTransform extends StatefulWidget {
  @override
  _ReliableTextTransformState createState() => _ReliableTextTransformState();
}

class _ReliableTextTransformState extends State<ReliableTextTransform> {
  Matrix4 transform = Matrix4.identity();
  Offset? _startFocalPoint;
  Matrix4? _startTransform;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
            children: [
        Container(color: Colors.grey[200]),

        // Center the transformable widget
        Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: GestureDetector(
                onScaleStart: (details) {
                  _startFocalPoint = details.focalPoint;
                  _startTransform = Matrix4.copy(transform);
                },
                onScaleUpdate: (details) {
                  setState(() {
                    // Create new matrix based on initial state
                    transform = Matrix4.copy(_startTransform!)
                      ..translate(
                        (details.focalPoint - _startFocalPoint!).dx,
                        (details.focalPoint - _startFocalPoint!).dy,
                      )
                      ..scale(details.scale)
                      ..rotateZ(details.rotation);
                  });
                },
                onScaleEnd: (_) {
                  _startFocalPoint = null;
                  _startTransform = null;
                },
                child: Transform(
                  transform: transform,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue, width: 2)),
                      child: Text(
                        'Pinch & Rotate Me',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            ],
         ),
    );
 }
}
