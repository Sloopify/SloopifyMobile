import 'package:flutter/material.dart';
import 'package:sloopify_mobile/features/friend_chat_profile/domain/entities/message.dart';

class ReplyPreview extends StatelessWidget {
  final Message replyingTo;
  final VoidCallback onCancel;

  const ReplyPreview({
    required this.replyingTo,
    required this.onCancel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: Text(replyingTo.content, overflow: TextOverflow.ellipsis),
          ),
          IconButton(icon: const Icon(Icons.close), onPressed: onCancel),
        ],
      ),
    );
  }
}
