import 'package:flutter/material.dart';

class FriendRequestCard extends StatelessWidget {
  const FriendRequestCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
              height: 48,
              width: 48,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Lorem ipsum",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                SizedBox(
                  width: 380,
                  height: 120,
                  child: Padding(
                    padding: EdgeInsets.only(top: 20, left: 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(4, (index) {
                        return CircleAvatar(
                          radius: 40, // 80px diameter
                          backgroundImage: AssetImage(
                            'assets/images/friendlist/${index + 1}.jpg',
                          ),
                        );
                      }),
                    ),
                  ),
                ),

                const SizedBox(height: 4),
                Text("12 mutual friends", style: TextStyle(fontSize: 12)),
              ],
            ),
          ),
          const Icon(Icons.check_box_outlined),
          const SizedBox(width: 8),
          const Icon(Icons.cancel_outlined),
        ],
      ),
    );
  }
}
