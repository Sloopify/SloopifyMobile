import 'package:flutter/material.dart';
import 'package:sloopify_mobile/features/chat_call_group_channel/domain/entities/member.dart';

class MemberList extends StatelessWidget {
  final List<Member> members;

  const MemberList({super.key, required this.members});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
          members.map((member) {
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(member.imageUrl),
              ),
              title: Text(member.name),
              trailing:
                  member.isAdmin
                      ? const Text(
                        "Admin",
                        style: TextStyle(color: Colors.teal),
                      )
                      : null,
            );
          }).toList(),
    );
  }
}
