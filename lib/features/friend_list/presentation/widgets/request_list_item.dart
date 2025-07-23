import 'package:flutter/material.dart';

class RequestListItem extends StatelessWidget {
  final Map<String, dynamic> request;
  final VoidCallback? onCancel;
  final VoidCallback? onAccept;
  final VoidCallback? onDecline;

  const RequestListItem({
    required this.request,
    this.onCancel,
    this.onAccept,
    this.onDecline,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final String status = request['status']?.toLowerCase() ?? '';
    final String imageUrl = request['imageUrl'] ?? '';
    final String name = request['name'] ?? 'Unknown';
    final int mutualFriends = request['mutualFriends'] ?? 0;

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 6),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
        radius: 24,
      ),
      title: Text(name),
      subtitle: Text(
        "$mutualFriends mutual friend${mutualFriends == 1 ? '' : 's'}",
      ),
      trailing: _buildTrailingButtons(status),
    );
  }

  Widget _buildTrailingButtons(String status) {
    if (status == 'rejected') {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.red.shade100,
          borderRadius: BorderRadius.circular(6),
        ),
        child: const Text('Rejected', style: TextStyle(color: Colors.red)),
      );
    } else if (status == 'pending' && onAccept != null && onDecline != null) {
      // This is a received request
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.check_circle, color: Colors.green),
            onPressed: onAccept,
            tooltip: 'Accept',
          ),
          IconButton(
            icon: const Icon(Icons.cancel, color: Colors.red),
            onPressed: onDecline,
            tooltip: 'Decline',
          ),
        ],
      );
    } else if (status == 'pending' && onCancel != null) {
      // This is a sent request
      return OutlinedButton(
        onPressed: onCancel,
        child: const Text("Cancel request"),
      );
    } else {
      return const SizedBox.shrink(); // No action
    }
  }
}
