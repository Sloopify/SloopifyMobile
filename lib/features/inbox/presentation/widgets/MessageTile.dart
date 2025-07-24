import 'package:flutter/material.dart';
import 'package:sloopify_mobile/features/inbox/presentation/widgets/MuteBottomSheet.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class MessageTile extends StatelessWidget {
  final String name;
  final String message;
  final String time;
  final int unreadCount;
  final bool isPinned;

  const MessageTile({
    super.key,
    required this.name,
    required this.message,
    required this.time,
    this.unreadCount = 0,
    this.isPinned = false,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(name + time),
      background: swipeLeftActions(context), // ✅ Corrected
      secondaryBackground: swipeRightActions(), // ✅ Corrected
      child: ListTile(
        leading: const CircleAvatar(
          backgroundImage: AssetImage("assets/images/friendlist/inbox.png"),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            if (isPinned)
              const Icon(Icons.push_pin, size: 16, color: Colors.grey),
          ],
        ),
        subtitle: Text(message, maxLines: 1, overflow: TextOverflow.ellipsis),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(time, style: const TextStyle(fontSize: 12)),
            const SizedBox(height: 4),
            if (unreadCount > 0)
              CircleAvatar(
                backgroundColor: Colors.teal,
                radius: 10,
                child: Text(
                  unreadCount.toString(),
                  style: const TextStyle(fontSize: 12, color: Colors.white),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // Swipe from left → right (Mute / Read)
  Widget swipeLeftActions(BuildContext context) {
    return Container(
      color: Colors.green,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GestureDetector(
        onTap:
            () => showModalBottomSheet(
              context: context,
              builder: (_) => const MuteBottomSheet(),
            ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.check, color: Colors.white),
            SizedBox(height: 10),
            Text("Read", style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }

  // Swipe from right → left (Delete)
  Widget swipeRightActions() {
    return Container(
      color: Colors.red,
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.delete, color: Colors.white),
          SizedBox(height: 10),
          Text("Delete", style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
