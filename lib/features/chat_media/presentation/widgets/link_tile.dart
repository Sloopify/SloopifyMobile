import 'package:flutter/material.dart';
import 'package:sloopify_mobile/features/chat_media/data/models/link_model.dart';

class LinkTile extends StatelessWidget {
  final LinkModel link;

  const LinkTile({super.key, required this.link});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.link, color: Colors.teal),
      title: Text(link.url, maxLines: 1, overflow: TextOverflow.ellipsis),
      subtitle: Text(link.domain),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
    );
  }
}
