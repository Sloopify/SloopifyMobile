import 'package:flutter/material.dart';

class ChatMessagesList extends StatelessWidget {
  const ChatMessagesList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      reverse: true,
      padding: const EdgeInsets.all(12),
      itemCount: 20, // Replace with actual messages
      itemBuilder:
          (_, index) => Align(
            alignment:
                index.isEven ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.symmetric(vertical: 4),
              decoration: BoxDecoration(
                color: index.isEven ? Colors.blue[100] : Colors.grey[300],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text("Message $index"),
            ),
          ),
    );
  }
}
