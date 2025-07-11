import 'package:flutter/material.dart';

class FilterChipWidget extends StatelessWidget {
  final String label;
  final Color color;

  const FilterChipWidget({required this.label, required this.color, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Text(label, style: const TextStyle(fontSize: 12)),
    );
  }
}
