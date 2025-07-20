// group_chat_menu.dart
import 'package:flutter/material.dart';
import 'package:sloopify_mobile/features/chat_call_group_channel/presentation/screen/group_members/more_options_sheet.dart';

PopupMenuButton<int> groupChatMenu(BuildContext context, bool isAdmin) {
  return PopupMenuButton<int>(
    onSelected: (value) {
      switch (value) {
        case 0:
          Navigator.pushNamed(context, '/group_details');
          break;
        case 1:
          Navigator.pushNamed(context, '/group_media');
          break;
        case 2:
          Navigator.pushNamed(context, '/search');
          break;
        case 3:
          Navigator.pushNamed(context, '/mute');
          break;
        case 4:
          Navigator.pushNamed(context, '/chat_theme');
          break;
        case 5:
          showModalBottomSheet(
            context: context,
            builder: (_) => MoreOptionsSheet(isAdmin),
          );
      }
    },
    itemBuilder:
        (context) => [
          const PopupMenuItem(value: 0, child: Text('Group information')),
          const PopupMenuItem(value: 1, child: Text('Group media')),
          const PopupMenuItem(value: 2, child: Text('Search')),
          const PopupMenuItem(value: 3, child: Text('Mute')),
          const PopupMenuItem(value: 4, child: Text('Chat theme')),
          const PopupMenuItem(value: 5, child: Text('More')),
        ],
  );
}
