import 'package:flutter/material.dart';

class LinksList extends StatelessWidget {
  final List<String> links;

  const LinksList({super.key, required this.links});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: links.length,
      separatorBuilder: (_, __) => Divider(),
      itemBuilder: (context, index) {
        final link = links[index];
        return ListTile(
          leading: Icon(Icons.link, color: Colors.teal),
          title: Text(link, overflow: TextOverflow.ellipsis),
          subtitle: Text(Uri.parse(link).host),
          onTap: () {
            // Launch URL logic here
          },
        );
      },
    );
  }
}
