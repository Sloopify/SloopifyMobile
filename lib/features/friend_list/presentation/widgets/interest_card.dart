import 'package:flutter/material.dart';

class InterestCard extends StatelessWidget {
  const InterestCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              'assets/images/friendlist/3.jpg',
              height: 60,
              width: 60,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Lorem ipsum",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          // ⬇ Insert this block
          const SizedBox(height: 8),
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
          // ⬆ End insert
          const SizedBox(height: 4),
          const Text("4 mutual friends", style: TextStyle(fontSize: 12)),
          const Spacer(),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Icon(Icons.person_add_alt_1, size: 20),
              Icon(Icons.delete_outline, size: 20),
            ],
          ),
        ],
      ),
    );
  }
}
