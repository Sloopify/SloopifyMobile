import 'package:flutter/material.dart';

class SortBottomSheet extends StatelessWidget {
  const SortBottomSheet({super.key, required this.onSelect});

  final void Function(String option) onSelect;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildOption(context, Icons.arrow_upward, "Newest first"),
          _buildOption(context, Icons.arrow_downward, "Oldest first"),
          _buildOption(context, Icons.sort_by_alpha, "Sort from A to Z"),
          _buildOption(
            context,
            Icons.sort_by_alpha_rounded,
            "Sort from Z to A",
          ),
        ],
      ),
    );
  }

  Widget _buildOption(BuildContext context, IconData icon, String text) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        onSelect(text); // pass selected value
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Icon(icon, color: Colors.black54),
            const SizedBox(width: 16),
            Text(text, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
