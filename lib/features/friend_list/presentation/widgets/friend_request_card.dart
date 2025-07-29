import 'package:flutter/material.dart';
import 'package:sloopify_mobile/features/friend_list/domain/entities/friend.dart';

class FriendRequestCard extends StatelessWidget {
  const FriendRequestCard({super.key, required Friend friend});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.teal),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                'assets/images/friendlist/5.jpg',
                height: 80,
                width: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Lorem ipsum",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: List.generate(4, (index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 4.0),
                        child: CircleAvatar(
                          radius: 10, // smallest practical size
                          backgroundImage: AssetImage(
                            'assets/images/friendlist/${index + 1}.jpg',
                          ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "12 mutual friends",
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(4), // Slight rounding
              ),
              child: const Icon(Icons.check_box_outlined, size: 20),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Icon(Icons.cancel_outlined, size: 20),
            ),
          ],
        ),
      ),
    );
  }
}
