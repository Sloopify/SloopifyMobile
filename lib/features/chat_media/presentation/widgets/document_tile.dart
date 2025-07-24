import 'package:flutter/material.dart';
import '../../data/models/document_model.dart';

class DocumentTile extends StatelessWidget {
  final DocumentModel document;

  const DocumentTile({super.key, required this.document});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Image.asset(
        document.iconAsset,
        width: 32,
        height: 32,
        fit: BoxFit.contain,
      ),
      title: Text(document.name),
      subtitle: Text('size: ${document.size}   Type: ${document.type}'),
      trailing: Text(document.date),
    );
  }
}
