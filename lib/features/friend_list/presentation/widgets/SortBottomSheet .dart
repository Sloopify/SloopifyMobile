import 'package:flutter/material.dart';

class SortBottomSheet extends StatelessWidget {
  const SortBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final options = [
      {'icon': Icons.arrow_upward, 'text': 'Newest first'},
      {'icon': Icons.arrow_downward, 'text': 'Oldest first'},
      {'icon': Icons.sort_by_alpha, 'text': 'Sort from A to Z'},
      {'icon': Icons.sort_by_alpha_outlined, 'text': 'Sort from Z to A'},
    ];

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children:
            options
                .map(
                  (option) => ListTile(
                    leading: Icon(
                      option['icon'] as IconData,
                      color: Colors.black,
                    ),
                    title: Text(option['text'] as String),
                    onTap: () {
                      // Add your sorting logic here
                      Navigator.pop(context);
                    },
                  ),
                )
                .toList(),
      ),
    );
  }
}
