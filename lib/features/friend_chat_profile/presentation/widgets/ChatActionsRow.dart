import 'package:flutter/material.dart';

class ChatActionsRow extends StatelessWidget {
  const ChatActionsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: const [
        _ChatAction(icon: Icons.message, label: "Message"),
        _ChatAction(icon: Icons.call, label: "Call"),
        _ChatAction(icon: Icons.videocam, label: "Video"),
      ],
    );
  }
}

class _ChatAction extends StatelessWidget {
  final IconData icon;
  final String label;
  const _ChatAction({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Icon(icon, size: 30), const SizedBox(height: 5), Text(label)],
    );
  }
}
