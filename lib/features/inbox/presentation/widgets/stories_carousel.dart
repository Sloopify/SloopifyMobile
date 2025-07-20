// lib/features/inbox/presentation/widgets/stories_carousel.dart

import 'package:flutter/material.dart';

class StoriesCarousel extends StatelessWidget {
  const StoriesCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    final stories = List.generate(5, (i) => "Lorem ipsum");

    return Container(
      height: 100,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: stories.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return storyItem(isAddButton: true);
          } else {
            return storyItem();
          }
        },
      ),
    );
  }

  Widget storyItem({bool isAddButton = false}) {
    return Container(
      width: 70,
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.grey.shade300,
            backgroundImage:
                isAddButton
                    ? null
                    : const AssetImage('assets/images/friendlist/inbox.png'),
            child:
                isAddButton
                    ? const Icon(Icons.add, size: 30, color: Colors.teal)
                    : null,
          ),
          const SizedBox(height: 5),
          Text(
            isAddButton ? "Your Story" : "Lorem",
            style: const TextStyle(fontSize: 12),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
