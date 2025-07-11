import 'package:flutter/material.dart';
import 'friend_choice_tile.dart'; // Import the extracted tile widget

class FriendChoices extends StatelessWidget {
  const FriendChoices({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            FriendChoiceTile(
              icon: Icons.chat_bubble_outline,
              text: 'Chat',
              onTap: () {
                Navigator.pop(context);
                // Chat action
              },
            ),
            const SizedBox(height: 8),
            FriendChoiceTile(
              icon: Icons.person_remove_outlined,
              text: 'Delete friendship',
              onTap: () {
                Navigator.pop(context);
                // Delete action
              },
            ),
            const SizedBox(height: 8),
            FriendChoiceTile(
              icon: Icons.block,
              text: 'Block',
              onTap: () {
                Navigator.pop(context);
                // Block action
              },
            ),
          ],
        ),
      ),
    );
  }
}
