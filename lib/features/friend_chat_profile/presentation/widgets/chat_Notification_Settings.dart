import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_app_bar.dart';
import 'package:sloopify_mobile/features/chat_friend/presentation/bloc/friend_chat/friend_chat_bloc.dart';
import 'package:sloopify_mobile/features/chat_friend/presentation/bloc/friend_chat/friend_chat_event.dart';
import 'package:sloopify_mobile/features/chat_friend/presentation/bloc/friend_chat/friend_chat_state.dart';

class ChatNotificationSettingsScreen extends StatelessWidget {
  final MuteDuration selected;
  final bool isMuted;
  static const routeName = 'mute_notifications';

  const ChatNotificationSettingsScreen({
    super.key,
    required this.selected,
    required this.isMuted,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getCustomAppBar(title: "Notifications", context: context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SwitchListTile(
            title: const Text("Mute notifications"),
            value: isMuted,
            onChanged: (value) {
              if (value) {
                context.read<ChatBloc>().add(MuteChatEvent(selected));
              } else {
                context.read<ChatBloc>().add(UnmuteChatEvent());
              }
            },
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Choose how long the chat will stay muted.\nYou can unmute the chat at any time.",
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
          ),
          ...MuteDuration.values
              .where((e) => e != MuteDuration.none)
              .map(
                (option) => RadioListTile<MuteDuration>(
                  title: Text(_labelForDuration(option)),
                  value: option,
                  groupValue: selected,
                  onChanged:
                      isMuted
                          ? (val) => context.read<ChatBloc>().add(
                            MuteChatEvent(val ?? MuteDuration.hours24),
                          )
                          : null,
                ),
              ),
        ],
      ),
    );
  }

  String _labelForDuration(MuteDuration duration) {
    switch (duration) {
      case MuteDuration.hours24:
        return '24 hours';
      case MuteDuration.days7:
        return '7 days';
      case MuteDuration.days30:
        return '30 days';
      case MuteDuration.untilUnmuted:
        return 'Until I unmute';
      default:
        return '';
    }
  }
}
