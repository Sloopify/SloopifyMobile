// lib/features/inbox/presentation/widgets/online_avatar_list.dart

import 'package:flutter/material.dart';

class OnlineAvatarList extends StatelessWidget {
  const OnlineAvatarList({super.key});

  @override
  Widget build(BuildContext context) {
    final onlineUsers = List.generate(10, (i) => 'Lorem');

    return SizedBox(
      height: 80,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Online',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: onlineUsers.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                return CircleAvatar(
                  radius: 25,
                  backgroundImage: const AssetImage(
                    'assets/images/friendlist/inbox.png',
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
