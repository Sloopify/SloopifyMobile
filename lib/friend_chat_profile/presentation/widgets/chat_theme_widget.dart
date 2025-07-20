import 'package:flutter/material.dart';

class ChatThemeWidget extends StatelessWidget {
  final VoidCallback onTap;

  const ChatThemeWidget({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.color_lens_outlined),
      title: const Text('Chat background'),
      trailing: const Text('(Default)', style: TextStyle(color: Colors.grey)),
      onTap: onTap,
    );
  }
}
