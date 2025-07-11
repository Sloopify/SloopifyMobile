import 'package:flutter/material.dart';

class FriendshipRequestItem extends StatelessWidget {
  const FriendshipRequestItem({super.key});

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
                        'assets/images/friendlist/3.jpg',
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
                    Text("12 mutual friend", style: TextStyle(fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.check_box_outlined, color: Colors.grey),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.cancel_outlined, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
