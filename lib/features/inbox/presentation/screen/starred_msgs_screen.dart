// lib/features/inbox/presentation/pages/starred_messages_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sloopify_mobile/features/inbox/presentation/widgets/starred_message_tile.dart';

class StarredMessagesPage extends StatefulWidget {
  const StarredMessagesPage({super.key});

  @override
  _StarredMessagesPageState createState() => _StarredMessagesPageState();
}

class _StarredMessagesPageState extends State<StarredMessagesPage> {
  final List<StarMessage> messages = List.generate(
    8,
    (i) => StarMessage(
      id: '$i',
      sender: i % 2 == 0 ? 'You' : 'Lorem ipsum',
      content: 'hello Lorem ipsum dolor !!',
      time: '10:10',
      date: '13/5/2013',
      isSentByMe: i % 3 == 0,
    ),
  );

  final Set<String> selected = {};

  @override
  Widget build(BuildContext context) {
    final hasSelection = selected.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        title:
            hasSelection
                ? Text('${selected.length}')
                : const Text('Starred messages'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          if (hasSelection) ...[
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                setState(
                  () => messages.removeWhere((m) => selected.contains(m.id)),
                );
                selected.clear();
              },
            ),
          ] else
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {}, // search starred
            ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: ListView.builder(
          itemCount: messages.length,
          itemBuilder: (ctx, i) {
            final msg = messages[i];
            final isSelected = selected.contains(msg.id);
            return StarredMessageTile(
              message: msg,
              isSelected: isSelected,
              onLongPress: () {
                setState(
                  () =>
                      isSelected
                          ? selected.remove(msg.id)
                          : selected.add(msg.id),
                );
              },
              onTap: () {
                if (selected.isNotEmpty) {
                  setState(
                    () =>
                        isSelected
                            ? selected.remove(msg.id)
                            : selected.add(msg.id),
                  );
                } else {
                  // normal tap, maybe open message details
                }
              },
            );
          },
        ),
      ),
    );
  }
}

class StarMessage {
  final String id;
  final String sender;
  final String content;
  final String time;
  final String date;
  final bool isSentByMe;

  StarMessage({
    required this.id,
    required this.sender,
    required this.content,
    required this.time,
    required this.date,
    required this.isSentByMe,
  });
}
