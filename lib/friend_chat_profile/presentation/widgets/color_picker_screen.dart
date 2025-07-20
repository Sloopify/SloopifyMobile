import 'package:flutter/material.dart';

class ColorPickerScreen extends StatelessWidget {
  const ColorPickerScreen({super.key});
  static const routeName = "color_picker_screen";
  @override
  Widget build(BuildContext context) {
    final colors = [
      Colors.red,
      Colors.amber,
      Colors.brown,
      Colors.lime,
      Colors.green,
      Colors.teal,
      Colors.cyan,
      Colors.blue,
      Colors.indigo,
      Colors.purple,
      Colors.grey,
      Colors.deepOrange,
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Select color')),
      body: GridView.count(
        crossAxisCount: 3,
        padding: const EdgeInsets.all(16),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children:
            colors.map((color) {
              return GestureDetector(
                onTap: () {
                  // TODO: Save selected color
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              );
            }).toList(),
      ),
    );
  }
}
