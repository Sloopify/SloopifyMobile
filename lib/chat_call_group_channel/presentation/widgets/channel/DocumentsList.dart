import 'package:flutter/material.dart';

class DocumentsList extends StatelessWidget {
  final List<DocumentItem> documents;

  const DocumentsList({super.key, required this.documents});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: documents.length,
      separatorBuilder: (_, __) => Divider(),
      itemBuilder: (context, index) {
        final doc = documents[index];
        return ListTile(
          leading: Icon(doc.icon, color: Colors.redAccent),
          title: Text(doc.name),
          subtitle: Text('Size: ${doc.size} • Type: ${doc.type}'),
          trailing: Text(doc.date),
        );
      },
    );
  }
}

class DocumentItem {
  final String name;
  final String size;
  final String type;
  final String date;
  final IconData icon;

  DocumentItem({
    required this.name,
    required this.size,
    required this.type,
    required this.date,
    required this.icon,
  });
}
