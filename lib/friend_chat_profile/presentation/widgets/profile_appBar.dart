import 'package:flutter/material.dart';
import 'package:sloopify_mobile/features/friend_chat_profile/data/models/user_model.dart';

class ProfileHeader extends StatelessWidget {
  final UserModel user;
  const ProfileHeader({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: NetworkImage(user.avatarUrl as String),
        ),
        const SizedBox(height: 10),
        Text(user.name, style: Theme.of(context).textTheme.titleLarge),
        Text(user.status, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}
