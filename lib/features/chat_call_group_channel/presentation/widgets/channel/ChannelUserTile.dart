import 'package:flutter/material.dart';
import 'package:sloopify_mobile/features/chat_call_group_channel/data/models/ChannelUser_Model.dart';

class ChannelUserTile extends StatelessWidget {
  final ChannelUser user;
  final String currentUserId;

  const ChannelUserTile({
    super.key,
    required this.user,
    required this.currentUserId,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: CircleAvatar(backgroundImage: NetworkImage(user.avatarUrl)),
      title: Text(user.name),
      subtitle: Text(user.role.name),
      trailing:
          user.id == currentUserId
              ? const Icon(Icons.person, color: Colors.green)
              : const Icon(Icons.more_vert),
    );
  }
}
