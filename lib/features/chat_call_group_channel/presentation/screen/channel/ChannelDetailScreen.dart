// lib/features/chat_call_group_channel/presentation/pages/channel_detail_page.dart

import 'package:flutter/material.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_app_bar.dart';
import 'package:sloopify_mobile/features/chat_call_group_channel/data/models/ChannelUser_Model.dart';

class ChannelDetailPage extends StatelessWidget {
  final String currentUserId = 'user_1'; // You can replace with passed-in value
  final List<ChannelUser> admins;

  const ChannelDetailPage({super.key, required this.admins});
  static const routeName = "chDetails";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getCustomAppBar(title: ("Channel name"), context: context),
      body: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(admins[0].avatarUrl),
          ),
          Text('Channel name', style: TextStyle(fontWeight: FontWeight.bold)),
          Text('Channel description'),
          Text('1300 followers'),

          ElevatedButton.icon(
            onPressed: () {},
            icon: Icon(Icons.share),
            label: Text("Share"),
          ),

          ListTile(
            title: Text('Media, Links, Documents'),
            trailing: Icon(Icons.chevron_right),
            onTap: () {},
          ),

          Divider(),

          ListTile(
            title: Text('Notification'),
            subtitle: Text('All'),
            trailing: Icon(Icons.notifications_none),
          ),

          ListTile(
            title: Text('Starred message'),
            trailing: Icon(Icons.star_border),
          ),

          Divider(),

          ...admins.map(
            (admin) => ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(admin.avatarUrl),
              ),
              title: Text(admin.name),
              subtitle: Text(admin.role.name),
              trailing:
                  admin.id == currentUserId
                      ? null
                      : IconButton(
                        icon: Icon(Icons.more_vert),
                        onPressed: () {},
                      ),
            ),
          ),

          Divider(),

          ListTile(
            title: Text('Transfer ownership'),
            trailing: Icon(Icons.swap_horiz),
            onTap: () {
              Navigator.pushNamed(context, '/transfer_ownership');
            },
          ),

          ListTile(
            title: Text('Delete channel'),
            textColor: Colors.red,
            onTap: () {},
          ),

          ListTile(
            title: Text('Report channel'),
            textColor: Colors.red,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
