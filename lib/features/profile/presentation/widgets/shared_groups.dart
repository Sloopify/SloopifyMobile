import 'package:flutter/material.dart';
import 'option_row.dart';

class SharedGroupsSection extends StatelessWidget {
  const SharedGroupsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '12 Shared group',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const OptionRow(
          image: 'assets/images/friendlist/group.jpg',
          label: 'Create new group with Lorem Ipsum',
        ),
        ...List.generate(
          4,
          (index) => const OptionRow(icon: Icons.group, label: 'name of group'),
        ),
        const OptionRow(
          icon: Icons.check_circle,
          label: 'View all shared group',
        ),
      ],
    );
  }
}
