import 'package:flutter/material.dart';

class GroupOptions extends StatelessWidget {
  final bool isAdmin;

  const GroupOptions({super.key, required this.isAdmin});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: const Text("Notification"),
          trailing: const Icon(Icons.notifications),
        ),
        ListTile(
          title: const Text("Starred message"),
          trailing: const Icon(Icons.star),
        ),
        if (isAdmin)
          ListTile(
            title: const Text("Group permissions"),
            trailing: const Icon(Icons.lock),
          ),
        ListTile(
          title: const Text("Encryption"),
          subtitle: const Text("Messages and calls are end-to-end encrypted."),
          trailing: const Icon(Icons.verified_user),
        ),
      ],
    );
  }
}
