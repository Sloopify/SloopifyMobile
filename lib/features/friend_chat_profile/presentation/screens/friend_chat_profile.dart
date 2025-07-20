import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_app_bar.dart';
import 'package:sloopify_mobile/features/chat_friend/presentation/bloc/friend_chat/friend_chat_state.dart';
import 'package:sloopify_mobile/features/friend_chat_profile/presentation/bloc/friend_chat_profile_bloc.dart';
import 'package:sloopify_mobile/features/friend_chat_profile/presentation/bloc/friend_chat_profile_state.dart';
import 'package:sloopify_mobile/features/friend_chat_profile/presentation/widgets/BlockReportButtons.dart';
import 'package:sloopify_mobile/features/friend_chat_profile/presentation/widgets/ChatActionsRow.dart';
import 'package:sloopify_mobile/features/friend_chat_profile/presentation/widgets/MediaSection.dart';
import 'package:sloopify_mobile/features/friend_chat_profile/presentation/widgets/NotificationSettings.dart';
import 'package:sloopify_mobile/features/friend_chat_profile/presentation/widgets/PrivacyOptions.dart';
import 'package:sloopify_mobile/features/friend_chat_profile/presentation/widgets/chat_Notification_Settings.dart';
// import 'package:sloopify_mobile/features/profile/presentation/widgets/profile_header.dart';

class FriendChatProfileView extends StatelessWidget {
  const FriendChatProfileView({super.key});
  static const routeName = 'friend_chat_profile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getCustomAppBar(title: ("Friend Chat Profile"), context: context),
      body: BlocBuilder<FriendProfileBloc, FriendProfileState>(
        builder: (context, state) {
          if (state.messages.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return LayoutBuilder(
            builder: (context, constraints) {
              final isMobile = constraints.maxWidth < 600;
              return ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  const ChatActionsRow(),
                  const Divider(),
                  const MediaSection(),
                  const Divider(),
                  const ChatNotificationSettingsScreen(
                    selected: MuteDuration.hours24,
                    isMuted: false,
                  ),
                  const Divider(),
                  const PrivacyOptions(),
                  const Divider(),
                  const BlockReportButtons(),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
