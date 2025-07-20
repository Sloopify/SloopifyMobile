import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sloopify_mobile/features/chat_call_group_channel/presentation/bloc/friend_chat/friend_chat_bloc.dart';
import 'package:sloopify_mobile/features/chat_call_group_channel/presentation/bloc/friend_chat/friend_chat_event.dart';

class ChatInputField extends StatefulWidget {
  const ChatInputField({super.key});

  @override
  State<ChatInputField> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          IconButton(icon: Icon(Icons.add_circle_outline), onPressed: () {}),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(hintText: "Input field"),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () {
              context.read<ChatBloc>().add(SendMessageEvent(text: ''));
              controller.clear();
            },
          ),
        ],
      ),
    );
  }
}
