import 'package:flutter/material.dart';

class AdminsAndMembersList extends StatelessWidget {
  final List<String> groupAdmins = ["Admin 1", "Admin 2"];
  final List<String> groupMembers = List.generate(20, (i) => "Member ${i + 1}");

  AdminsAndMembersList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const Padding(
          padding: EdgeInsets.all(12),
          child: Text(
            "Group admins",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        ...groupAdmins.map(
          (admin) => ListTile(
            leading: const CircleAvatar(),
            title: Text(admin),
            trailing: const Icon(Icons.check_circle, color: Colors.teal),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Group members",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text("20 members", style: TextStyle(color: Colors.teal)),
            ],
          ),
        ),
        ...groupMembers.map(
          (member) =>
              ListTile(leading: const CircleAvatar(), title: Text(member)),
        ),
      ],
    );
  }
}
