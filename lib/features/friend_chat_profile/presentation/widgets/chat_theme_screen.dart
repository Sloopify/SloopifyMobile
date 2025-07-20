import 'package:flutter/material.dart';
import 'package:sloopify_mobile/features/friend_chat_profile/presentation/widgets/chat_background_screen.dart';

class ChatThemeScreen extends StatelessWidget {
  const ChatThemeScreen({super.key});
  static const routeName = "chat_theme_screen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat theme'),
        actions: [
          Tooltip(
            message: 'Reset default setting',
            child: IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                // TODO: Reset theme logic
              },
            ),
          ),
        ],
      ),
      body: ListTile(
        leading: const Icon(Icons.color_lens_outlined),
        title: const Text('Chat background'),
        trailing: const Text('(Default)', style: TextStyle(color: Colors.grey)),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ChatBackgroundScreen()),
          );
        },
      ),
    );
  }
}
