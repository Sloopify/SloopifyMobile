import 'package:flutter/material.dart';

class ActionButtons extends StatelessWidget {
  const ActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: const [
        _ActionButton(icon: Icons.video_call, label: 'Video call'),
        _ActionButton(icon: Icons.call, label: 'Call'),
        _ActionButton(icon: Icons.search, label: 'Search'),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;

  const _ActionButton({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(onPressed: () {}, icon: Icon(icon, color: Colors.teal)),
        Text(label),
      ],
    );
  }
}
