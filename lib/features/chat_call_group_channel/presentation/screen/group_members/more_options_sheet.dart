import 'package:flutter/material.dart';

class MoreOptionsSheet extends StatelessWidget {
  final bool isAdmin;

  const MoreOptionsSheet(this.isAdmin, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isAdmin)
          ListTile(
            title: const Text(
              'Delete chat',
              style: TextStyle(color: Colors.red),
            ),
            onTap: () {},
          ),
        ListTile(
          title: const Text(
            'Leave the group',
            style: TextStyle(color: Colors.red),
          ),
          onTap: () {},
        ),
        ListTile(
          title: const Text(
            'Report group',
            style: TextStyle(color: Colors.red),
          ),
          onTap: () {},
        ),
      ],
    );
  }
}
