import 'package:flutter/material.dart';

class RequestListItem extends StatelessWidget {
  final Map<String, dynamic> request;

  const RequestListItem({required this.request, super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 6),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(request['imageUrl']),
        radius: 24,
      ),
      title: Text(request['name']),
      subtitle: Text("${request['mutualFriends']} mutual friend"),
      trailing:
          request['status'] == 'Rejected'
              ? Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.red.shade100,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  'Rejected',
                  style: TextStyle(color: Colors.red),
                ),
              )
              : OutlinedButton(
                onPressed: () {},
                child: const Text("Cancel request"),
              ),
    );
  }
}
