import 'package:flutter/material.dart';
import 'package:sloopify_mobile/features/chat_call_group_channel/domain/entities/user.dart';

class FriendsList extends StatelessWidget {
  final List<User> friends;
  final List<User> selected;
  final void Function(User) onToggle;

  const FriendsList({
    super.key,
    required this.friends,
    required this.selected,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: friends.length,
      itemBuilder: (_, i) {
        final user = friends[i];
        final isSelected = selected.contains(user);

        return ListTile(
          leading: CircleAvatar(backgroundImage: NetworkImage(user.imageUrl)),
          title: Text(user.name),
          trailing: Checkbox(
            value: isSelected,
            onChanged: (_) => onToggle(user),
          ),
        );
      },
    );
  }
}
