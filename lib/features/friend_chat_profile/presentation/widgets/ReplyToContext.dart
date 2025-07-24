import 'package:flutter/material.dart';
import 'package:sloopify_mobile/features/friend_chat_profile/data/models/message_model.dart';

class ReplyToContext extends StatelessWidget {
  final Message repliedMessage;

  const ReplyToContext({required this.repliedMessage, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      margin: const EdgeInsets.only(bottom: 4),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        border: Border(left: BorderSide(color: Colors.teal, width: 3)),
      ),
      child: Text(
        repliedMessage.content,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontStyle: FontStyle.italic),
      ),
    );
  }
}
