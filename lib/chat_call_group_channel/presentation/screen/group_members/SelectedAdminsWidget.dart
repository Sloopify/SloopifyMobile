import 'package:flutter/material.dart';

class SelectedAdminsWidget extends StatelessWidget {
  final List<String> selectedAdmins = ["You", "Lorem"];

  SelectedAdminsWidget({super.key}); // Replace with real data

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: selectedAdmins.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          return Column(
            children: [
              Stack(
                children: [
                  const CircleAvatar(radius: 20), // Add avatar image
                  Positioned(
                    top: -4,
                    right: -4,
                    child: Icon(Icons.cancel, size: 16, color: Colors.red),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(selectedAdmins[index], style: const TextStyle(fontSize: 12)),
            ],
          );
        },
      ),
    );
  }
}
