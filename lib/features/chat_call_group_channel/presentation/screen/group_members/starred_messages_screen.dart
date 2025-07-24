import 'package:flutter/material.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_app_bar.dart';
import 'package:sloopify_mobile/features/chat_call_group_channel/data/models/message_model.dart';

class StarredMessagesScreen extends StatelessWidget {
  final List<Message> messages = [];

  StarredMessagesScreen({super.key}); // Replace with your actual model/data

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getCustomAppBar(title: ("Starred messages"), context: context),
      body: ListView.builder(
        itemCount: messages.length,
        itemBuilder: (_, index) {
          final msg = messages[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(msg.userAvatar),
            ),
            title: Text("${msg.senderName} > ${msg.groupName}"),
            subtitle: Text(msg.content),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text(msg.timestamp), Icon(msg.statusIcon)],
            ),
          );
        },
      ),
    );
  }
}
