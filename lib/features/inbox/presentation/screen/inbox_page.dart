import 'package:flutter/material.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_app_bar.dart';
import 'package:sloopify_mobile/features/chat_call_group_channel/presentation/screen/group_members/group_detail_screen.dart';
import 'package:sloopify_mobile/features/chat_system/presentation/screens/chat_screen.dart';
import 'package:sloopify_mobile/features/inbox/presentation/screen/starred_msgs_screen.dart';
import 'package:sloopify_mobile/features/inbox/presentation/widgets/MessageTile.dart';
import 'package:sloopify_mobile/features/inbox/presentation/widgets/stories_carousel.dart';
import 'package:sloopify_mobile/features/inbox/presentation/widgets/online_avatar_list.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen({super.key});
  static const routeName = "inbox";

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  int selectedTabIndex = 0;
  final List<String> tabs = ['All', 'Unread', 'Groups'];
  String searchQuery = "";

  final List<Map<String, dynamic>> sampleMessages = List.generate(
    10,
    (i) => {
      "name": "Lorem ipsum",
      "message": "can you help me ?",
      "time":
          i == 1
              ? "15:20"
              : i == 0
              ? "20:00"
              : "Yesterday",
      "unread":
          i == 0
              ? 3
              : i == 1
              ? 2
              : 0,
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getCustomAppBar(
        context: context,
        title: "Inbox",
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (value) {
              if (value == 'starred') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const StarredMessagesPage(),
                  ),
                );
              } else if (value == 'settings') {
                // navigate to settings page
              }
              // other actions...
            },
            itemBuilder:
                (context) => [
                  const PopupMenuItem(
                    value: 'new_group',
                    child: Text('New group'),
                  ),
                  const PopupMenuItem(
                    value: 'mark_read',
                    child: Text('Mark all as read'),
                  ),
                  const PopupMenuItem(
                    value: 'starred',
                    child: Text('Starred messages'),
                  ),
                  const PopupMenuItem(
                    value: 'settings',
                    child: Text('Settings'),
                  ),
                ],
          ),
        ],
      ),
      body: Column(
        children: [
          const StoriesCarousel(),
          const OnlineAvatarList(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value.toLowerCase();
                });
              },
            ),
          ),
          buildTabs(),
          Expanded(child: buildChatList()),
        ],
      ),
    );
  }

  Widget buildTabs() {
    return Row(
      children: List.generate(tabs.length, (index) {
        final isSelected = selectedTabIndex == index;
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedTabIndex = index;

              if (tabs[index] == 'Groups') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const GroupDetailScreen()),
                );
              }
            });
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: isSelected ? Colors.teal : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              tabs[index],
              style: TextStyle(color: isSelected ? Colors.white : Colors.black),
            ),
          ),
        );
      }),
    );
  }

  Widget buildChatList() {
    final filtered =
        sampleMessages.where((msg) {
          final name = (msg["name"] as String).toLowerCase();
          return name.contains(searchQuery);
        }).toList();

    return ListView.builder(
      itemCount: filtered.length,
      itemBuilder: (context, index) {
        final msg = filtered[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ChatScreen(senderName: msg["name"]),
              ),
            );
          },
          child: MessageTile(
            name: msg["name"] as String,
            message: msg["message"] as String,
            time: msg["time"] as String,
            unreadCount: msg["unread"] as int,
          ),
        );
      },
    );
  }
}
