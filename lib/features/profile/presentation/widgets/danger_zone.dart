import 'package:flutter/material.dart';

class DangerZoneSection extends StatelessWidget {
  const DangerZoneSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        DangerOption(icon: Icons.block, label: 'Block Lorem ipsum'),
        DangerOption(icon: Icons.report, label: 'Report Lorem ipsum'),
      ],
    );
  }
}

class DangerOption extends StatelessWidget {
  final IconData icon;
  final String label;

  const DangerOption({required this.icon, required this.label, super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: Colors.red),
      title: Text(label, style: const TextStyle(color: Colors.red)),
    );
  }
}
