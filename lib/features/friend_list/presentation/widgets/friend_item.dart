import 'package:flutter/material.dart';
import 'package:sloopify_mobile/features/friend_list/domain/entities/friend.dart';
import 'package:sloopify_mobile/features/friend_list/presentation/widgets/friend_choices.dart';

class FriendItem extends StatelessWidget {
  const FriendItem({super.key, required Friend friend});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 24,
            backgroundImage: AssetImage('assets/images/friendlist/3.jpg'),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "lorem ipsum",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Row(
                  children: const [
                    CircleAvatar(
                      radius: 8,
                      backgroundImage: AssetImage(
                        'assets/images/friendlist/2.jpg',
                      ),
                    ),
                    SizedBox(width: 4),
                    CircleAvatar(
                      radius: 8,
                      backgroundImage: AssetImage(
                        'assets/images/friendlist/4.jpg',
                      ),
                    ),
                    SizedBox(width: 4),
                    CircleAvatar(
                      radius: 8,
                      backgroundImage: AssetImage(
                        'assets/images/friendlist/5.jpg',
                      ),
                    ),
                    SizedBox(width: 4),
                    SizedBox(width: 4),
                    CircleAvatar(
                      radius: 8,
                      backgroundImage: AssetImage(
                        'assets/images/friendlist/5.jpg',
                      ),
                    ),
                    Text("12 mutual friend", style: TextStyle(fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),
          const Icon(Icons.chat_bubble_outline),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              showDialog(
                context: context,
                builder:
                    (_) => Dialog(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const FriendChoices(),
                    ),
              );
            },
          ),
        ],
      ),
    );
  }
}
