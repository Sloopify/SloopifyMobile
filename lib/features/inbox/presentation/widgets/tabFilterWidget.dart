import 'package:flutter/material.dart';

class TabFilterWidget extends StatefulWidget {
  const TabFilterWidget({super.key});

  @override
  State<TabFilterWidget> createState() => _TabFilterWidgetState();
}

class _TabFilterWidgetState extends State<TabFilterWidget> {
  int selectedIndex = 0;
  final filters = ['All', 'Unread', 'Groups'];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(filters.length, (i) {
        final isSelected = i == selectedIndex;
        return Padding(
          padding: const EdgeInsets.only(right: 12),
          child: GestureDetector(
            onTap: () => setState(() => selectedIndex = i),
            child: Chip(
              label: Text(filters[i]),
              backgroundColor:
                  isSelected ? Colors.tealAccent[100] : Colors.grey[200],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        );
      }),
    );
  }
}
