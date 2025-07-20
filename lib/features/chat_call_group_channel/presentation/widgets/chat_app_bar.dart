import 'package:flutter/material.dart';
import 'package:sloopify_mobile/features/chat_call_group_channel/presentation/bloc/friend_chat/friend_chat_state.dart';
import 'package:sloopify_mobile/features/chat_call_group_channel/presentation/screen/group_screen.dart';
import 'package:sloopify_mobile/features/chat_call_group_channel/presentation/screen/video_call_screen.dart';

import 'package:sloopify_mobile/features/chat_media/presentation/screen/chat_media_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sloopify_mobile/features/chat_media/data/datasources/media_local_datasource.dart';
import 'package:sloopify_mobile/features/chat_media/data/repository/media_repository_impl.dart';
import 'package:sloopify_mobile/features/chat_media/domain/usecases/fetch_media_by_date.dart';
import 'package:sloopify_mobile/features/chat_media/presentation/bloc/chat_media_cubit.dart';
import 'package:sloopify_mobile/features/chat_media/presentation/bloc/chat_friend_cubit.dart';
import 'package:sloopify_mobile/features/chat_media/presentation/bloc/link_cubit.dart';
import 'package:sloopify_mobile/features/chat_media/presentation/widgets/document_tab.dart';
import 'package:sloopify_mobile/features/chat_media/presentation/widgets/link_tabs.dart';
import 'package:sloopify_mobile/features/friend_chat_profile/presentation/widgets/chat_Notification_Settings.dart';
import 'package:sloopify_mobile/features/friend_chat_profile/presentation/widgets/chat_popup_menu.dart';
import 'package:sloopify_mobile/features/friend_chat_profile/presentation/widgets/chat_theme_screen.dart';

class ChatAppBar extends StatelessWidget {
  const ChatAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context),
      ),
      title: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Lorem ipsum",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            "Last seen 2:13 PM",
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.call_outlined),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const VideoCallScreen()),
            );
          },
        ),
        IconButton(
          icon: const Icon(Icons.videocam_outlined),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const VideoCallScreen()),
            );
          },
        ),
        IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (_) => ChatPopupMenu(
                      onProfile: () {},
                      onSearch: () {},
                      onNewGroup: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const GroupCreateScreen(),
                          ),
                        );
                      },
                      onMedia: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ChatMediaPage(),
                          ),
                        );
                      },
                      onDocuments: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const DocumentTab(),
                          ),
                        );
                      },
                      onLinks: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const LinksTab()),
                        );
                      },
                      onMute: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (_) => const ChatNotificationSettingsScreen(
                                  selected: MuteDuration.hours24,
                                  isMuted: false,
                                ),
                          ),
                        );
                      },
                      onTheme: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ChatThemeScreen(),
                          ),
                        );
                      },
                      onMore: () {},
                    ),
              ),
            );
          },
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}
