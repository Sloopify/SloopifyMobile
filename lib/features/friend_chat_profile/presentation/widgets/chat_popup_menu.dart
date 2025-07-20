import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sloopify_mobile/features/chat_media/data/datasources/media_local_datasource.dart';
import 'package:sloopify_mobile/features/chat_media/data/repository/media_repository_impl.dart';
import 'package:sloopify_mobile/features/chat_media/domain/usecases/fetch_media_by_date.dart';
import 'package:sloopify_mobile/features/chat_media/presentation/bloc/chat_friend_cubit.dart';
import 'package:sloopify_mobile/features/chat_media/presentation/bloc/chat_media_cubit.dart';
import 'package:sloopify_mobile/features/chat_media/presentation/bloc/link_cubit.dart';
import 'package:sloopify_mobile/features/chat_media/presentation/screen/chat_media_page.dart';

class ChatPopupMenu extends StatelessWidget {
  final VoidCallback onProfile;
  final VoidCallback onSearch;
  final VoidCallback onNewGroup;
  final VoidCallback onMedia;
  final VoidCallback onDocuments; // 👈 add this
  final VoidCallback onLinks; // 👈 add this
  final VoidCallback onMute;
  final VoidCallback onTheme;
  final VoidCallback onMore;

  const ChatPopupMenu({
    super.key,
    required this.onProfile,
    required this.onSearch,
    required this.onNewGroup,
    required this.onMedia,
    required this.onDocuments, // 👈 required
    required this.onLinks, // 👈 required
    required this.onMute,
    required this.onTheme,
    required this.onMore,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<_ChatMenuOption>(
      icon: const Icon(Icons.more_vert),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      onSelected: (value) {
        switch (value) {
          case _ChatMenuOption.profile:
            onProfile();
            break;
          case _ChatMenuOption.search:
            onSearch();
            break;
          case _ChatMenuOption.newGroup:
            onNewGroup();
            break;
          case _ChatMenuOption.media:
            onMedia();
            break;
          case _ChatMenuOption.documents:
            onDocuments(); // 👈
            break;
          case _ChatMenuOption.links:
            onLinks(); // 👈
            break;
          case _ChatMenuOption.mute:
            onMute();
            break;
          case _ChatMenuOption.theme:
            onTheme();
            break;
          case _ChatMenuOption.more:
            onMore();
            break;
        }
      },
      itemBuilder:
          (context) => [
            _buildMenuItem(Icons.person, "Profile", _ChatMenuOption.profile),
            _buildMenuItem(Icons.search, "Search", _ChatMenuOption.search),
            _buildMenuItem(Icons.group, "New group", _ChatMenuOption.newGroup),
            _buildMenuItem(
              Icons.insert_drive_file,
              "Media ,links ,documents",
              _ChatMenuOption.media,
            ),
            _buildMenuItem(
              Icons.notifications_off,
              "Mute notification",
              _ChatMenuOption.mute,
            ),
            _buildMenuItem(
              Icons.color_lens,
              "Chat theme",
              _ChatMenuOption.theme,
            ),
            _buildMenuItem(Icons.more_horiz, "More", _ChatMenuOption.more),
          ],
    );
  }

  PopupMenuItem<_ChatMenuOption> _buildMenuItem(
    IconData icon,
    String text,
    _ChatMenuOption value,
  ) {
    return PopupMenuItem<_ChatMenuOption>(
      value: value,
      child: Row(
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 12),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}

enum _ChatMenuOption {
  profile,
  search,
  newGroup,
  media,
  documents,
  links,
  mute,
  theme,
  more,
}
