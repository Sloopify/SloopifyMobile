import 'package:flutter/material.dart';
import 'package:sloopify_mobile/features/chat_friend/presentation/widgets/attachment_sheet.dart';
import 'package:sloopify_mobile/features/chat_friend/presentation/widgets/recording_widget.dart';

class ChatInputBar extends StatefulWidget {
  final Function(bool) onRecordingChanged;
  final bool isRecording;

  const ChatInputBar({
    super.key,
    required this.onRecordingChanged,
    required this.isRecording,
  });

  @override
  State<ChatInputBar> createState() => _ChatInputBarState();
}

class _ChatInputBarState extends State<ChatInputBar> {
  final TextEditingController _controller = TextEditingController();
  bool showSend = false;

  void _handleAttachmentTap() {
    showModalBottomSheet(
      context: context,
      builder: (_) => const AttachmentSheet(),
    );
  }

  void _toggleRecording() {
    widget.onRecordingChanged(!widget.isRecording);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      duration: const Duration(milliseconds: 200),
      crossFadeState:
          widget.isRecording
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
      firstChild: _buildInputBar(),
      secondChild: RecordingWidget(onStop: _toggleRecording),
    );
  }

  Widget _buildInputBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _handleAttachmentTap,
          ),
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(hintText: 'Type a message'),
              onChanged: (val) => setState(() => showSend = val.isNotEmpty),
            ),
          ),
          if (showSend)
            IconButton(
              icon: const Icon(Icons.send),
              onPressed: () {
                // send message
                _controller.clear();
                setState(() => showSend = false);
              },
            )
          else
            IconButton(
              icon: const Icon(Icons.mic),
              onPressed: _toggleRecording,
            ),
        ],
      ),
    );
  }
}
