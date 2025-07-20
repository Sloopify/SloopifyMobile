import 'package:flutter/material.dart';
import 'package:sloopify_mobile/features/chat_call_group_channel/data/models/friend_chat_message_model.dart';

class PinnedMessageBar extends StatelessWidget {
  final MessageModel message;
  final VoidCallback onUnpin;
  final VoidCallback onGoTo;

  const PinnedMessageBar({
    super.key,
    required this.message,
    required this.onUnpin,
    required this.onGoTo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200], // You can customize this
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          const Icon(Icons.push_pin),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Pinned Message",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 2),
                Text(
                  message.text,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'go') onGoTo();
              if (value == 'unpin') onUnpin();
            },
            itemBuilder:
                (_) => const [
                  PopupMenuItem(value: 'go', child: Text("Go to message")),
                  PopupMenuItem(value: 'unpin', child: Text("Unpin")),
                ],
          ),
        ],
      ),
    );
  }
}
