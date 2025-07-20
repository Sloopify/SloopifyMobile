// lib/features/inbox/presentation/widgets/message_list.dart

import 'package:flutter/material.dart';
import 'package:sloopify_mobile/features/inbox/presentation/widgets/MessageTile.dart';

class MessageList extends StatelessWidget {
  const MessageList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 8, // Replace with actual messages
      itemBuilder: (context, index) {
        return MessageTile(
          name: "Lorem Ipsum",
          message: "Can you help me?",
          time: "20:00",
          unreadCount: index == 0 ? 3 : 0,
          isPinned: index == 1,
        );
      },
    );
  }
}
