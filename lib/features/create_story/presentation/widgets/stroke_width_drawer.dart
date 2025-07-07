import 'package:flutter/material.dart';

class StrokeWidthDrawer extends StatelessWidget {
  final Function(double value) onChanged;
  final double currentStrokeWidth;

  const StrokeWidthDrawer({
    super.key,
    required this.onChanged,
    required this.currentStrokeWidth,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.4,
      width: 50,
      child: Column(
        children: [
          const Icon(Icons.brush, color: Colors.white, size: 24),
          Expanded(
            child: RotatedBox(
              quarterTurns: 3,
              child: Slider(
                padding: EdgeInsets.zero,
                value: currentStrokeWidth,
                min: 3.0,
                max: 20,
                divisions: 9,
                activeColor: Colors.white,
                inactiveColor: Colors.white.withOpacity(0.3),
                onChanged: onChanged,
              ),
            ),
          ),
          const Icon(Icons.brush, color: Colors.white, size: 20),
        ],
      ),
    );
  }
}
