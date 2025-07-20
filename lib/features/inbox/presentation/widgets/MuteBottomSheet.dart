// lib/features/inbox/presentation/widgets/mute_bottom_sheet.dart

import 'package:flutter/material.dart';

class MuteBottomSheet extends StatelessWidget {
  const MuteBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final options = ["24 hours", "7 days", "30 days", "until I unmute"];
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Choose how long the chat will stay muted.",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text("You can unmute the chat at any time."),
          const SizedBox(height: 20),
          ...options.map(
            (o) => RadioListTile(
              title: Text(o),
              value: o,
              groupValue: null,
              onChanged: (_) {},
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              ElevatedButton(onPressed: () {}, child: const Text("Mute")),
            ],
          ),
        ],
      ),
    );
  }
}
